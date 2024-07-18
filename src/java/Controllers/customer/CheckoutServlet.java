/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.customer;

import DAL.AccountDAO;
import DAL.CartItemDAO;
import DAL.CouponDAO;
import DAL.OrderDAO;
import DAL.OrderDetailsDAO;
import DAL.ProductDAO;
import DAL.ProductVariantDAO;
import Models.CartItem;
import Models.CustomerAddress;
import Models.Order;
import Models.OrderDetails;
import Models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilities.CommonConst;
import utilities.CookieUtils;
import utilities.EmailUtils;
import utilities.GeneratorUtils;

/**
 *
 * @author admin
 */
public class CheckoutServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CheckoutServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CheckoutServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("Views/checkout.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("accId") == null ? "2" : request.getParameter("accId"));
            String customerName = request.getParameter("fullname");
            String customerEmail = request.getParameter("email");
            String address = "";
            String phone = "";
            String code = request.getParameter("code");
            String customerAddress = request.getParameter("address") == null ? "" : request.getParameter("address");

            // Process customer address if provided
            if (!customerAddress.isBlank()) {
                String[] addressInfo = customerAddress.split("-");
                address = addressInfo[0].trim();
                phone = addressInfo[1].trim();
            } else {
                // If customer address not provided, construct address from city, district, ward, etc.
                String city = request.getParameter("city").trim();
                String district = request.getParameter("district").trim();
                String ward = request.getParameter("ward").trim();
                String streetAddress = request.getParameter("stAddress");
                phone = request.getParameter("phone");
                address = city + ", " + district + ", " + ward + ", " + streetAddress;

                // Assuming customerId = 2 means anonymous customer, add address to database
                if (customerId != 2) {
                    AccountDAO accountDAO = new AccountDAO();
                    accountDAO.addAddress(new CustomerAddress(customerId, phone, address));
                }
            }

            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            double discount = Double.parseDouble(request.getParameter("discount"));
            String paymentMethod = request.getParameter("paymentMethod");

            Order order = new Order();
            order.setCustomerId(customerId);
            order.setFullname(customerName);
            order.setEmail(customerEmail);
            order.setPhone(phone);
            order.setDeliveryAddress(address);
            order.setStatus(CommonConst.ORDER_PENDING_STATUS); 
            order.setDiscount(discount);
            order.setTotalAmount(totalAmount);
            order.setIsPaid(!paymentMethod.equals(CommonConst.COD_METHOD)); 
            order.setOrderCode(GeneratorUtils.generateOrderCode()); 

            // Retrieve ordered items details
            String[] itemsId = request.getParameterValues("vId");
            String[] itemsQuantities = request.getParameterValues("vQuantity");
            List<OrderDetails> orderDetailsList = new ArrayList<>();
            for (int i = 0; i < itemsId.length; i++) {
                OrderDetails details = new OrderDetails();
                details.setProductVariantId(Integer.parseInt(itemsId[i]));
                details.setQuantity(Integer.parseInt(itemsQuantities[i]));
                orderDetailsList.add(details);
            }

            // Place order with stock check
            OrderDAO orderDAO = new OrderDAO(); 
            int orderId = orderDAO.placeOrderWithStockCheck(order, orderDetailsList);

            if (orderId != -1) {
                // Handle coupon usage if provided
                if (!code.isBlank()) {
                    CouponDAO couponDAO = new CouponDAO(); 
                    int couponId = couponDAO.getCouponByCode(code).getCouponId();
                    couponDAO.addCouponToUsedCouponHistory(customerId, couponId);
                }

                // Update cart and delete customer cart items
                String items = "";
                for (int i = 0; i < itemsId.length; i++) {
                    items += itemsId[i] + ":" + itemsQuantities[i] + "/";
                }
                updateCartAfterPlacedOrder(items.substring(0, items.length() - 1), request, response);

                // Delete customer cart items if not guest customer
                if (customerId != 2) {
                    CartItemDAO cartItemDAO = new CartItemDAO(); 
                    for (String vId : itemsId) {
                        int cartItemId = cartItemDAO.getCartItemId(new CartItem(customerId, Integer.parseInt(vId)));
                        cartItemDAO.deleteCustomerCartItem(customerId, cartItemId);
                    }
                }

                
                order = orderDAO.getOrderByOrderId(orderId); 
                String content = EmailUtils.generateOrderEmailContent(order, CommonConst.ORDER_CONFIRMATION_SUBTITLE);
                EmailUtils.sendEmail(order.getEmail(), CommonConst.ORDER_CONFIRMATION_TITLE, content);

                
                response.sendRedirect("checkout-success");
            } else {
                response.sendRedirect("checkout-failed");
            }

        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void updateCartAfterPlacedOrder(String items, HttpServletRequest request, HttpServletResponse response) {
        String cartCookie = CookieUtils.getCookieValueByName(utilities.CommonConst.CART_COOKIE, request);
        if (cartCookie == null || cartCookie.isEmpty()) {
            return;
        }

        String[] cartItems = cartCookie.split("/");
        String[] orderItems = items.split("/");
        List<String> updatedCartItems = new ArrayList<>();

        Map<String, Integer> orderedItemsMap = new HashMap<>();
        for (String orderItem : orderItems) {
            String[] variation = orderItem.split(":");
            String variationId = variation[0];
            int quantity = Integer.parseInt(variation[1]);
            orderedItemsMap.put(variationId, quantity);
        }

        // Update the cart items based on the order
        for (String cartItem : cartItems) {
            String[] variationInCart = cartItem.split(":");
            String variationIdInCart = variationInCart[0];
            int variationQuantityInCart = Integer.parseInt(variationInCart[1]);

            if (orderedItemsMap.containsKey(variationIdInCart)) {
                int orderedQuantity = orderedItemsMap.get(variationIdInCart);
                if (variationQuantityInCart > orderedQuantity) {
                    // Decrease the quantity in the cart
                    int newQuantity = variationQuantityInCart - orderedQuantity;
                    updatedCartItems.add(variationIdInCart + ":" + newQuantity);
                }
                // If orderedQuantity >= variationQuantityInCart, this item is fully removed from the cart
            } else {
                // This item was not ordered, so keep it in the cart
                updatedCartItems.add(cartItem);
            }
        }

        String updatedCartCookie = String.join("/", updatedCartItems);

        CookieUtils.updateCookieValueByName(utilities.CommonConst.CART_COOKIE, updatedCartCookie, request, response);
        CookieUtils.updateCookieValueByName(utilities.CommonConst.ITEMS_NUMBER_CART_COOKIE, String.valueOf(updatedCartItems.size()), request, response);
    }

}
