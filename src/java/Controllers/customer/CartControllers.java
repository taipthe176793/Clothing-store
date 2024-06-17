/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.customer;

import DAL.AccountDAO;
import DAL.CartItemDAO;
import DAL.ProductVariantDAO;
import Models.Account;
import Models.CartItem;
import Models.ProductVariant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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
            AccountDAO aDAO = new AccountDAO();
            Account account = null;
            List<CartItem> cartItems = new ArrayList<>();
            Cookie[] arr = request.getCookies();

            if (arr != null) {
                for (Cookie o : arr) {
                    if (o.getName().equals("userId")) {
                        account = aDAO.getAccountById(Integer.parseInt(o.getValue()));
                        break;
                    }
                }
            }

            if (arr != null) {
                for (Cookie o : arr) {
                    if (o.getName().equals("cart")) {
                        if (account == null) {
                            account = new Account();
                            account.setCartFromCookie(o.getValue());

                        }
                        cartItems = account.getCartItems();
                        o.setMaxAge(0);
                        response.addCookie(o);
                        break;
                    }
                }
            }

            request.setAttribute("cart", cartItems);

            Cookie cartCookie = new Cookie("cart", account.cartToCookieValue());
            cartCookie.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(cartCookie);

            request.getRequestDispatcher("Views/shoping-cart.jsp").forward(request, response);
        } catch (SQLException ex) {
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
            case "update":
                //code update cart logic

                url = request.getServletContext().getContextPath() + "/cart";
                break;
            case "remove":
                //code remove to cart logic

                url = request.getServletContext().getContextPath() + "/cart";
                break;
            case "checkout":
                //code checkout

                break;

            default:
                throw new AssertionError();
        }

        response.sendRedirect(url);
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

            Cookie[] arr = request.getCookies();
            String userId = "";
            String txt = "";
            if (arr != null) {
                for (Cookie o : arr) {
                    if (o.getName().equals("cart")) {
                        txt += o.getValue();
                        o.setMaxAge(0);
                        response.addCookie(o);
                    }
                    if (o.getName().equals("userId")) {
                        userId = o.getValue();
                    }
                }
            }

            if (txt.isBlank()) {
                txt = variant.getProductVariantId() + ":" + quantity;
            } else {
                //check if this item already existed in cart
                if (txt.contains(variant.getProductVariantId() + ":")) {
                    txt = updateCartCookie(txt, variant, quantity);
                } else {
                    txt += "/" + variant.getProductVariantId() + ":" + quantity;
                }
            }

            Cookie cart = new Cookie("cart", txt);
            cart.setMaxAge(60 * 60 * 24 * 7);
            response.addCookie(cart);
            //check if user is logged in
            if (!userId.isBlank()) {
                AccountDAO accountDAO = new AccountDAO();
                Account account = accountDAO.getAccountById(Integer.parseInt(userId));
                account.setCartFromCookie(txt);
                //update cart detail id
                updateCartItemId(account.getAccountId(), account.getCartItems());
            }
        } catch (SQLException ex) {
            Logger.getLogger(CartControllers.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private String updateCartCookie(String txt, ProductVariant variant, int quantity) {

        String updateCartCookie = "";
        String[] items = txt.split("/");
        for (String i : items) {
            //find item to update
            if (i.contains(variant.getProductVariantId() + ":")) {
                String[] itemDetail = i.split(":");
                int quantityToAdd = Integer.parseInt(itemDetail[1]);
                itemDetail[1] = (quantity + quantityToAdd) > variant.getQuantity()
                        ? variant.getQuantity() + "" : (quantity + quantityToAdd) + "";
                i = itemDetail[0] + ":" + itemDetail[1];
            }
            updateCartCookie += i + "/";
        }
        return updateCartCookie.substring(0, updateCartCookie.lastIndexOf("/"));

    }

    public static void mergeAndSyncCart(HttpServletResponse response, Account account, Cookie cookie) throws SQLException {

        CartItemDAO ciDAO = new CartItemDAO();
        //check if customer cart is not empty
        if (!account.getCartItems().isEmpty()) {
            Account tempAccount = new Account();
            tempAccount.setCartFromCookie(cookie.getValue());
            Account.mergeCart(account, tempAccount.getCartItems());
            ciDAO.updateCartToDatabase(account.getAccountId(), account.getCartItems());
        } else {
            account.setCartFromCookie(cookie.getValue());
            //Insert cart details into database
            for (CartItem cd : account.getCartItems()) {
                CartItemDAO cdDAO = new CartItemDAO();
                cdDAO.addNewCartItem(account.getAccountId(), cd);
            }
        }
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        Cookie cartCookie = new Cookie("cart", account.cartToCookieValue());
        cartCookie.setMaxAge(60 * 60 * 24 * 7);
        response.addCookie(cartCookie);
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
            Logger.getLogger(CartControllers.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
