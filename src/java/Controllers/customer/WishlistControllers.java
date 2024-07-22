/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.customer;

import DAL.AccountDAO;
import DAL.ProductDAO;
import DAL.ProductVariantDAO;
import Models.Account;
import Models.Product;
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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilities.CommonConst;

/**
 *
 * @author caoqu
 */
public class WishlistControllers extends HttpServlet {

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
            out.println("<title>Servlet WishlistControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet WishlistControllers at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Cookie[] cookies = request.getCookies();
            int accountId = 0;
            Account account = null;

            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals(CommonConst.USER_ID_COOKIE)) {
                        accountId = Integer.parseInt(cookie.getValue());
                        AccountDAO aDAO = new AccountDAO();
                        account = aDAO.getAccountById(accountId);
                        request.getSession().setAttribute("account", account);
                    }
                }
            }

            if (account != null) {
                ProductVariantDAO productvariantDAO = new ProductVariantDAO();
                AccountDAO accountDAO = new AccountDAO();                
                List<Product> favoriteProducts = accountDAO.getWishlistProducts(account.getAccountId());
                for(int i = 0; i < favoriteProducts.size(); i++){
                    List<ProductVariant> pvList = productvariantDAO.getAllVariantsOfAProduct(favoriteProducts.get(i).getProductId());
                    favoriteProducts.get(i).setVariantList(pvList);
                }
                request.setAttribute("favoriteProducts", favoriteProducts);
                request.getRequestDispatcher("/Views/wishlist.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/auth?action=login");
            }
        } catch (SQLException ex) {
            response.sendRedirect("404");
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        AccountDAO accountDAO = new AccountDAO();
        Account account = null;
        Cookie[] arr = request.getCookies();

        if (arr != null) {
            for (Cookie o : arr) {
                if (o.getName().equals(CommonConst.USER_ID_COOKIE)) {
                    try {
                        account = accountDAO.getAccountById(Integer.parseInt(o.getValue()));
                    } catch (SQLException e) {
                        e.printStackTrace();
                        request.setAttribute("error", "Database error: " + e.getMessage());
                        request.getRequestDispatcher("/Views/publicProducts.jsp").forward(request, response);
                        return;
                    }
                }
            }
        }

        if (account == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.isEmpty()) {
            request.setAttribute("error", "Product ID not specified.");
            request.getRequestDispatcher("/Views/publicProducts.jsp").forward(request, response);
            return;
        }

        int productId = Integer.parseInt(productIdStr);
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                if (!accountDAO.isProductInWishlist(account.getAccountId(), productId)) {
                    if (accountDAO.addToWishlist(account.getAccountId(), productId)) {
                        account.addToWishlist(productId);
                        request.getSession().setAttribute("notification", "Add to wishlist successfully");
                        request.getSession().setAttribute("type", "alert-box-success");
                    } else {
                        request.setAttribute("error", "Failed to add product to wishlist.");
                    }
                } else {
                    request.setAttribute("error", "Product is already in the wishlist.");
                }
            } else if ("remove".equals(action)) {
                if (accountDAO.removeFromWishlist(account.getAccountId(), productId)) {
                    account.removeFromWishlist(productId);
                } else {
                    request.setAttribute("error", "Failed to remove product from wishlist.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/Views/publicProducts.jsp").forward(request, response);
            return;
        }

        response.sendRedirect(request.getHeader("Referer"));
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

}
