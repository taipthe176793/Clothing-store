/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.customer;

import DAL.AccountDAO;
import DAL.CartItemDAO;
import DAL.CouponDAO;
import DAL.ProductDAO;
import DAL.ProductVariantDAO;
import Models.Account;
import Models.CartItem;
import Models.Coupon;
import Models.Product;
import Models.ProductVariant;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilities.CookieUtils;
import utilities.GeneratorUtils;

/**
 *
 * @author admin
 */
public class CartControllers extends HttpServlet {

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
            out.println("<title>Servlet CartControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartControllers at " + request.getContextPath() + "</h1>");
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
        try {

            ProductDAO pDAO = new ProductDAO();
            List<Product> products = pDAO.getAllProducts();
            ProductVariantDAO pvDAO = new ProductVariantDAO();
            List<ProductVariant> variants = pvDAO.getAllVariantsOfAllProducts();
            for (int i = 0; i < products.size(); i++) {
                Product p = products.get(i);
                p.setVariantList(pvDAO.getAllVariantsOfAProduct(p.getProductId()));
                products.set(i, p);
            }
            request.setAttribute("allProduct", products);
            request.setAttribute("allVariant", variants);

            if (request.getSession().getAttribute("discount") != null) {
                request.setAttribute("discount", request.getSession().getAttribute("discount"));
                request.getSession().removeAttribute("discount");
                request.setAttribute("code", request.getSession().getAttribute("code"));
                request.getSession().removeAttribute("code");
            }

            GeneratorUtils.getNotification(request);

            AccountDAO aDAO = new AccountDAO();
            Account account = null;
            String cartCookieValue;
            List<CartItem> cartItems;
            String accId = CookieUtils.getCookieValueByName(utilities.CommonConst.USER_ID_COOKIE, request);

            if (!accId.isBlank()) {
                account = aDAO.getAccountById(Integer.parseInt(accId));
            }

            if (account == null) {
                account = new Account();
                account.setCartFromCookie(CookieUtils.getCookieValueByName(utilities.CommonConst.CART_COOKIE, request));
            }
            cartItems = account.getCartItems();
            cartCookieValue = account.cartToCookieValue();

            request.setAttribute(utilities.CommonConst.CART_COOKIE, cartItems);

            CookieUtils.updateCookieValueByName(utilities.CommonConst.CART_COOKIE, cartCookieValue, request, response);

            request.getRequestDispatcher("Views/shoping-cart.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(CartControllers.class.getName()).log(Level.SEVERE, null, ex);
        }

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
            String action = request.getParameter("action") == null ? "" : request.getParameter("action");
            String productId = request.getParameter("id") == null ? "" : request.getParameter("id");
            String color = request.getParameter("color") == null ? "" : request.getParameter("color");
            String size = request.getParameter("size") == null ? "" : request.getParameter("size");

            String url = "";

            switch (action) {
                case "addToCart":
                    addToCart(request, response);
                    url = request.getServletContext().getContextPath() + "/product?id=" + productId + "&color=" + color + "&size=" + size;
                    break;
                case "updateQuantity":
                    //code update cart logic
                    updateCartItemQuantity(request, response);
                    url = request.getServletContext().getContextPath() + "/cart";
                    break;
                case "delete":
                    //code remove to cart logic
                    deleteCartItem(request, response);
                    url = request.getServletContext().getContextPath() + "/cart";
                    break;
                case "checkout":
                    HttpSession session = request.getSession();
                    session.invalidate();
                    storeItemsToSession(request);
                    url = request.getServletContext().getContextPath() + "/checkout";
                    break;
                case "applyCoupon":
                    //code checkout
                    applyCoupon(request);
                    url = request.getServletContext().getContextPath() + "/cart";
                    break;

                default:
                    throw new AssertionError();
            }

            response.sendRedirect(url);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CartControllers.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("home");
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

    private void addToCart(HttpServletRequest request, HttpServletResponse response) {
        try {

            int id = Integer.parseInt(request.getParameter("id"));
            String color = request.getParameter("color");
            String size = request.getParameter("size");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            ProductVariantDAO pvDAO = new ProductVariantDAO();
            ProductVariant variant = pvDAO.findVariantByProperties(id, color, size);

            String userId = CookieUtils.getCookieValueByName(utilities.CommonConst.USER_ID_COOKIE, request);
            String txt = CookieUtils.getCookieValueByName(utilities.CommonConst.CART_COOKIE, request);

            if (txt.isBlank()) {
                txt = variant.getProductVariantId() + ":" + quantity;
                GeneratorUtils.makeNotification(request, "Add to cart successfully", utilities.CommonConst.NOTI_SUCCESS);
            } else {
                //check if this item already existed in cart
                if (txt.contains(variant.getProductVariantId() + ":")) {
                    txt = updateToCartCookie(txt, variant, quantity, "Add", request);
                } else {
                    txt += "/" + variant.getProductVariantId() + ":" + quantity;
                    GeneratorUtils.makeNotification(request, "Add to cart successfully", utilities.CommonConst.NOTI_SUCCESS);
                }
            }

            CookieUtils.updateCookieValueByName(utilities.CommonConst.CART_COOKIE, txt, request, response);
            CookieUtils.updateCookieValueByName(utilities.CommonConst.ITEMS_NUMBER_CART_COOKIE, txt.split("/").length + "", request, response);

            //check if user is logged in
            if (!userId.isBlank()) {
                AccountDAO accountDAO = new AccountDAO();
                Account account = accountDAO.getAccountById(Integer.parseInt(userId));
                account.setCartFromCookie(txt);
                //update cart detail id
                updateCartItemId(account.getAccountId(), account.getCartItems());

            }
        } catch (SQLException ex) {
            Logger.getLogger(CartControllers.class
                    .getName()).log(Level.SEVERE, null, ex);
        }

    }

    private String updateToCartCookie(String txt, ProductVariant variant, int quantity, String action, HttpServletRequest request) {

        String updateCartCookie = "";
        String[] items = txt.split("/");
        for (String i : items) {
            //find item to update
            if (i.contains(variant.getProductVariantId() + ":")) {
                String[] itemDetail = i.split(":");
                int quantityToChange = Integer.parseInt(itemDetail[1]);
                switch (action) {
                    case "Add":
                        itemDetail[1] = (quantity + quantityToChange) > variant.getQuantity()
                                ? variant.getQuantity() + "" : (quantity + quantityToChange) + "";
                        if (Integer.parseInt(itemDetail[1].trim()) == variant.getQuantity()) {
                            GeneratorUtils.makeNotification(request, "This item in your cart has reached its maximum quantity limit.",
                                    utilities.CommonConst.NOTI_WARNING);
                        } else {
                            GeneratorUtils.makeNotification(request, "Add to cart successfully", utilities.CommonConst.NOTI_SUCCESS);
                        }
                        break;
                    case "Change":
                        itemDetail[1] = quantity + "";
                        break;
                    default:
                        throw new AssertionError();
                }

                i = itemDetail[0] + ":" + itemDetail[1];
            }
            updateCartCookie += i + "/";
        }
        return updateCartCookie.substring(0, updateCartCookie.lastIndexOf("/"));

    }

    public static void mergeAndSyncCart(HttpServletRequest request, HttpServletResponse response, Account account) throws SQLException {

        String cartTxt = CookieUtils.getCookieValueByName(utilities.CommonConst.CART_COOKIE, request);
        CartItemDAO ciDAO = new CartItemDAO();
        //check if customer cart is not empty
        if (!account.getCartItems().isEmpty()) {
            Account tempAccount = new Account();
            tempAccount.setCartFromCookie(cartTxt);
            Account.mergeCart(account, tempAccount.getCartItems());
            ciDAO.updateCartToDatabase(account.getAccountId(), account.getCartItems());
        } else {
            account.setCartFromCookie(cartTxt);
            //Insert cart details into database
            for (CartItem cd : account.getCartItems()) {
                CartItemDAO cdDAO = new CartItemDAO();
                cdDAO.addNewCartItem(account.getAccountId(), cd);
            }
        }

        CookieUtils.updateCookieValueByName(utilities.CommonConst.CART_COOKIE, account.cartToCookieValue(), request, response);
        CookieUtils.updateCookieValueByName(utilities.CommonConst.ITEMS_NUMBER_CART_COOKIE,
                account.cartToCookieValue().split("/").length + "", request, response);
    }

    private void updateCartItemId(int customerId, List<CartItem> cartItems) {
        try {
            CartItemDAO cdDAO = new CartItemDAO();
            //update cart detail id
            for (int i = 0; i < cartItems.size(); i++) {
                CartItem cd = new CartItem();
                cd.setCustomerId(customerId);
                cd.setProductVariantId(cartItems.get(i).getProductVariantId());
                cd.setQuantity(cartItems.get(i).getQuantity());
                cd.setCartItemId(cdDAO.getCartItemId(cd));
                cartItems.set(i, cd);
            }
            //update cart to db
            cdDAO.updateCartToDatabase(customerId, cartItems);

        } catch (SQLException ex) {
            Logger.getLogger(CartControllers.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void deleteCartItem(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException {
        try {

            int cartItemId = Integer.parseInt(request.getParameter("cItemIdDelete"));
            int variantId = Integer.parseInt(request.getParameter("itemIdDelete"));

            String cartTxt = CookieUtils.getCookieValueByName(utilities.CommonConst.CART_COOKIE, request);
            String userId = CookieUtils.getCookieValueByName(utilities.CommonConst.USER_ID_COOKIE, request);
            //check if user is logged in
            if (!userId.isBlank()) {
                AccountDAO aDao = new AccountDAO();
                CartItemDAO ciDao = new CartItemDAO();
                Account account = aDao.getAccountById(Integer.parseInt(userId));
                //update to db
                ciDao.deleteCustomerCartItem(account.getAccountId(), cartItemId);
                //fetch updated data
                account.setCartItems(ciDao.getCartItems(account.getAccountId()));
                //assign updated data to cartTxt
                cartTxt = account.cartToCookieValue();
            } else {
                cartTxt = deleteItemInCartCookie(cartTxt, variantId);
            }
            CookieUtils.updateCookieValueByName(utilities.CommonConst.CART_COOKIE, cartTxt, request, response);
            CookieUtils.updateCookieValueByName(utilities.CommonConst.ITEMS_NUMBER_CART_COOKIE,
                    cartTxt.split("/").length + "", request, response);

            GeneratorUtils.makeNotification(request, "Item deleted successfully", utilities.CommonConst.NOTI_SUCCESS);

        } catch (SQLException ex) {
            Logger.getLogger(CartControllers.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    private String deleteItemInCartCookie(String cartTxt, int variantId) throws SQLException, ClassNotFoundException {
        ProductVariantDAO pvDAO = new ProductVariantDAO();
        ProductVariant pv = pvDAO.findProductVariantById(variantId);
        String[] items = cartTxt.split("/");
        cartTxt = "";
        for (String item : items) {
            String[] info = item.split(":");
            int pvId = Integer.parseInt(info[0]);
            if (pvId != pv.getProductVariantId()) {
                cartTxt += info[0] + ":" + info[1] + "/";
            }
        }
        return cartTxt.isBlank() ? "" : cartTxt.substring(0, cartTxt.length() - 1);
    }

    private void updateCartItemQuantity(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException {

        try {

            int cartItemId = Integer.parseInt(request.getParameter("cItemId"));
            int variantId = Integer.parseInt(request.getParameter("itemId"));
            int updateQuantity = Integer.parseInt(request.getParameter("cItemQuantity"));

            ProductVariantDAO pvDAO = new ProductVariantDAO();

            String cartTxt = CookieUtils.getCookieValueByName(utilities.CommonConst.CART_COOKIE, request);
            String userId = CookieUtils.getCookieValueByName(utilities.CommonConst.USER_ID_COOKIE, request);
            //check if user is logged in
            if (!userId.isBlank()) {
                AccountDAO aDao = new AccountDAO();
                CartItemDAO ciDao = new CartItemDAO();
                Account account = aDao.getAccountById(Integer.parseInt(userId));
                //update to db
                ciDao.updateCustomerCartItem(account.getAccountId(), cartItemId, updateQuantity);
                //fetch updated data
                account.setCartItems(ciDao.getCartItems(account.getAccountId()));
                //assign updated data to cartTxt
                cartTxt = account.cartToCookieValue();
            } else {
                cartTxt = updateToCartCookie(cartTxt, pvDAO.findProductVariantById(variantId),
                        updateQuantity, "Change", request);
            }
            CookieUtils.updateCookieValueByName(utilities.CommonConst.CART_COOKIE, cartTxt, request, response);

        } catch (SQLException ex) {
            Logger.getLogger(CartControllers.class
                    .getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void applyCoupon(HttpServletRequest request) {
        try {
            String couponCode = request.getParameter("coupon");
            int userId = Integer.parseInt(CookieUtils.getCookieValueByName(utilities.CommonConst.USER_ID_COOKIE, request));

            CouponDAO couponDAO = new CouponDAO();
            Coupon coupon = couponDAO.getCouponByCode(couponCode);

            checkCouponValidation(request, userId, coupon);

        } catch (SQLException ex) {
            Logger.getLogger(CartControllers.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void storeItemsToSession(HttpServletRequest request) {

        try {

            ProductDAO pDAO = new ProductDAO();
            ProductVariantDAO pvDAO = new ProductVariantDAO();
            AccountDAO aDAO = new AccountDAO();
            Account account = null;

            List<Product> products = new ArrayList<>();
            List<ProductVariant> variants = new ArrayList<>();

            String userId = CookieUtils.getCookieValueByName(utilities.CommonConst.USER_ID_COOKIE, request);
            if (!userId.isBlank()) {
                account = aDAO.getAccountById(Integer.parseInt(userId));
            }

            String[] itemIdTxt = request.getParameterValues("cartItem");
            for (String itemIdTxt1 : itemIdTxt) {
                String pvId = itemIdTxt1.split("-")[1];
                ProductVariant pv = pvDAO.findProductVariantById(Integer.parseInt(pvId));
                pv.setQuantity(Integer.parseInt(itemIdTxt1.split("-")[2]));
                variants.add(pv);
                Product p = pDAO.findProductById(pv.getProductId());
                if (!products.contains(p)) {
                    products.add(p);
                }
            }
            double discount = Double.parseDouble(request.getParameter("discount").isBlank() ? "0" : request.getParameter("discount"));
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
            String code = request.getParameter("code");

            HttpSession session = request.getSession();
            session.setAttribute("products", products);
            session.setAttribute("variants", variants);
            session.setAttribute("discount", discount);
            session.setAttribute("code", code);
            session.setAttribute("totalAmount", totalAmount);
            if (account != null) {
                session.setAttribute("account", account);
                session.setAttribute("addressList", account.getAddresses());
            }

        } catch (SQLException ex) {
            Logger.getLogger(CartControllers.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CartControllers.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private void checkCouponValidation(HttpServletRequest request, int userId, Coupon coupon) throws SQLException {

        HttpSession session = request.getSession();
        CouponDAO cDAO = new CouponDAO();

        if (coupon == null) {
            GeneratorUtils.makeNotification(request, "Invalid Coupon", utilities.CommonConst.NOTI_ERROR);
        } else {

            if (!cDAO.checkCouponExpiration(coupon)) {

                GeneratorUtils.makeNotification(request, "Expired Coupon", utilities.CommonConst.NOTI_WARNING);

            } else if (cDAO.checkUsedCoupon(userId, coupon.getCouponId())) {

                GeneratorUtils.makeNotification(request, "You have used this Coupon", utilities.CommonConst.NOTI_WARNING);

            } else if (coupon.getQuantity() == 0) {

                GeneratorUtils.makeNotification(request, "Coupon has run out of uses", utilities.CommonConst.NOTI_WARNING);

            } else {

                GeneratorUtils.makeNotification(request, "Apply coupon successful", utilities.CommonConst.NOTI_SUCCESS);
                session.setAttribute("discount", (double) coupon.getDiscount());
                session.setAttribute("code", coupon.getCode());

            }

        }

    }

}
