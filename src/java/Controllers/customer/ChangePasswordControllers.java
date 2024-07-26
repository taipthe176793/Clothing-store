/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.customer;

import DAL.AccountDAO;
import Models.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import utilities.CommonConst;
import utilities.CookieUtils;
import utilities.EncryptionUtils;
import utilities.GeneratorUtils;

/**
 *
 * @author caoqu
 */
public class ChangePasswordControllers extends HttpServlet {

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
            out.println("<title>Servlet ChangePasswordController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordController at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("/Views/user/change-password.jsp").forward(request, response);

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

            Cookie[] arr = request.getCookies();
            int accountId = 0;
            Account account = null;

            if (arr != null) {
                for (Cookie o : arr) {

                    if (o.getName().equals(CommonConst.USER_ID_COOKIE)) {
                        accountId = Integer.parseInt(o.getValue());
                        AccountDAO aDAO = new AccountDAO();

                        account = aDAO.getAccountById(accountId);

                        break;
                    }

                }
            }

            if (account == null) {
                response.sendRedirect("home");
                return;
            }

            String currentPassword = request.getParameter("current_password");
            String newPassword = request.getParameter("new_password");
            String repeatNewPassword = request.getParameter("repeat_new_password");

            AccountDAO accountDAO = new AccountDAO();
            boolean isCurrentPasswordValid = accountDAO.validateCurrentPassword(account.getUsername(), EncryptionUtils.toSHA256(currentPassword));

            if (!isCurrentPasswordValid) {
                request.setAttribute("message", "Current password is incorrect.");
                request.getRequestDispatcher("/Views/user/change-password.jsp").forward(request, response);
                return;
            }

            if (newPassword.length() < 8 || newPassword.contains(" ")) {
                request.setAttribute("message", "New password must be at least 8 characters without spaces.");
                request.getRequestDispatcher("/Views/user/change-password.jsp").forward(request, response);
                return;
            }

            if (!newPassword.equals(repeatNewPassword)) {
                request.setAttribute("message", "New passwords do not match.");
                request.getRequestDispatcher("/Views/user/change-password.jsp").forward(request, response);
                return;
            }

            boolean isPasswordUpdated = accountDAO.updatePassword(new Account(account.getUsername(), EncryptionUtils.toSHA256(newPassword)));

            if (isPasswordUpdated) {
                String notiMessage = "Password changed successfully. Please log in with your new password.";
                GeneratorUtils.makeNotification(request, notiMessage, CommonConst.NOTI_SUCCESS);

                CookieUtils.deleteCookieByName(CommonConst.USER_ID_COOKIE, request, response);
                CookieUtils.deleteCookieByName(CommonConst.USER_ROLE, request, response);
                CookieUtils.deleteCookieByName(CommonConst.USER_NAME, request, response);

                CookieUtils.updateCookieValueByName(CommonConst.CART_COOKIE, "", request, response);

                response.sendRedirect(request.getContextPath() + "/auth?action=login");
            } else {
                request.setAttribute("message", "Failed to change password. Please try again.");
                request.getRequestDispatcher("/Views/user/change-password.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.getRequestDispatcher("/Views/user/change-password.jsp").forward(request, response);
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

}
