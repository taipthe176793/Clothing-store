/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.customer;

import DAL.AccountDAO;
import DAL.CartItemDAO;
import DAL.OrderDAO;
import DAL.OrderDetailsDAO;
import DAL.ProductVariantDAO;
import Models.CartItem;
import Models.CustomerAddress;
import Models.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilities.CookieUtils;
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
            //Guest is 2
            int cusId = Integer.parseInt(request.getParameter("accId") == null ? "2" : request.getParameter("accId"));
            String cusName = request.getParameter("fullname");
            String cusEmail = request.getParameter("email");
            String address = "";
            String phone = "";
            String cusAddress = request.getParameter("address") == null ? "" : request.getParameter("address");
            if (!cusAddress.isBlank()) {
                String[] addressInfo = cusAddress.split("-");
                address = addressInfo[0].trim();
                phone = addressInfo[1].trim();
            } else {
                String city = request.getParameter("city").trim();
                String district = request.getParameter("district").trim();
                String ward = request.getParameter("ward").trim();
                String stAddress = request.getParameter("stAddress");
                phone = request.getParameter("phone");
                address = city + ", " + district + ", " + ward + ", " + stAddress;
                if (cusId != 2) {
                    AccountDAO aDAO = new AccountDAO();
                    aDAO.addAddress(new CustomerAddress(cusId, phone, address));
                }
            }
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            double discount = Double.parseDouble(request.getParameter("discount"));
            String paymentMethod = request.getParameter("paymentMethod");

            //Construct an order
            Order order = new Order();
            order.setCustomerId(cusId);
            order.setFullname(cusName);
            order.setEmail(cusEmail);
            order.setPhone(phone);
            order.setDeliveryAddress(address);
            order.setStatus(Constant.CommonConst.ORDER_PENDING_STATUS);
            order.setDiscount(discount);
            order.setTotalAmount(totalAmount);
            order.setIsPaid(!paymentMethod.equals(Constant.CommonConst.COD_METHOD));
            order.setTrackingCode(GeneratorUtils.generateOrderTrackingCode());

            //Insert order to database
            OrderDAO orderDAO = new OrderDAO();
            int orderId = orderDAO.insertOrder(order);

            //Insert Order Details to database
            OrderDetailsDAO oDetailsDAO = new OrderDetailsDAO();
            String[] itemsId = request.getParameterValues("vId");
            String[] itemsQuantities = request.getParameterValues("vQuantity");
            for (int i = 0; i < itemsId.length; i++) {
                oDetailsDAO.insertOrderDetails(orderId, Integer.parseInt(itemsQuantities[i]), Integer.parseInt(itemsId[i]));
            }

            //Items for update cart, update variation quantity
            ProductVariantDAO pvDAO = new ProductVariantDAO();
            String items = "";
            for (int i = 0; i < itemsId.length; i++) {
                items += itemsId[i] + ":" + itemsQuantities[i] + "/";
                //Update variantion quantity
                pvDAO.updateVariantQuantity(pvDAO.findProductVariantById(Integer.parseInt(itemsId[i])),
                        Integer.parseInt(itemsQuantities[i]), Constant.CommonConst.OPERATION_DESCREASE);
            }
            //Update cart cookie after placed an order
            items = items.substring(0, items.length() - 1);
            updateCartAfterPlacedOrder(items, request, response);

            //Update customer cart in database
            if (cusId != 2) {
                CartItemDAO ciDAO = new CartItemDAO();
                for (String vId : itemsId) {
                    int cartItemId = ciDAO.getCartItemId(new CartItem(cusId, Integer.parseInt(vId)));
                    ciDAO.deleteCustomerCartItem(cusId, cartItemId);
                }
            }

            response.sendRedirect("cart");

        } catch (SQLException ex) {
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex.getMessage());
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
        String cartCookie = CookieUtils.getCookieValueByName(Constant.CommonConst.CART_COOKIE, request);
        String[] cartItems = cartCookie.split("/");
        cartCookie = "";
        String[] orderItems = items.split("/");
        //Split cart cookie to order Items
        for (int i = 0; i < orderItems.length; i++) {
            String[] variation = orderItems[i].split(":");
            String variationId = variation[0];
            for (String item : cartItems) {
                String[] variationInCart = item.split(":");
                String variationIdInCart = variationInCart[0];
                String variationQuantityInCart = variationInCart[1];
                if (!variationId.equals(variationIdInCart)) {
                    cartCookie += variationIdInCart + ":" + variationQuantityInCart + "/";
                }
            }
        }
        cartCookie = cartCookie.substring(0, cartCookie.length() - 1).isBlank()
                ? "" : cartCookie.substring(0, cartCookie.length() - 1);

        CookieUtils.updateCookieValueByName(Constant.CommonConst.CART_COOKIE, cartCookie, request, response);
        CookieUtils.updateCookieValueByName(Constant.CommonConst.ITEMS_NUMBER_CART_COOKIE, cartCookie.split("/").length + "", request, response);
    }

}
