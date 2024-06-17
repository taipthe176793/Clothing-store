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

/**
 *
 * @author caoqu
 */
public class ProfileController extends HttpServlet {

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
            out.println("<title>Servlet ProfileController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileController at " + request.getContextPath() + "</h1>");
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
            String action = request.getParameter("action");

            if (action == null) {
                action = "view";  // default action
            }

            switch (action) {
                case "view":
                    viewProfile(request, response);
                    break;
                case "update":
                    Cookie[] arr = request.getCookies();
                    int accountId = 0;
                    Account account = null;

                    if (arr != null) {
                        for (Cookie o : arr) {

                            if (o.getName().equals("userId")) {
                                accountId = Integer.parseInt(o.getValue());
                                AccountDAO aDAO = new AccountDAO();

                                account = aDAO.getAccountById(accountId);

                                break;
                            }
                        }
                    }
                    request.setAttribute("account", account);
                    request.getRequestDispatcher("/Views/user/edit-user-profile.jsp").forward(request, response);
                    break;
                default:
                    response.sendRedirect("home");
                    break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProfileController.class.getName()).log(Level.SEVERE, null, ex);
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
        String action = request.getParameter("action");
        if (action == null) {
            action = ""; // default to no action
        }

        switch (action) {
            case "update":
                updateProfile(request, response);
                break;
            default:
                response.sendRedirect("home");
                break;
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Cookie[] arr = request.getCookies();
            int accountId = 0;
            Account account = null;

            if (arr != null) {
                for (Cookie o : arr) {

                    if (o.getName().equals("userId")) {
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

            String username = request.getParameter("user");
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");

            account.setUsername(username);
            account.setFullname(fullname);
            account.setEmail(email);
            account.setPhone(phone);

            AccountDAO accDAO = new AccountDAO();
            Account updatedAccount = accDAO.updateAccount(account);

            if (updatedAccount != null) {
                request.setAttribute("account", updatedAccount);
                request.setAttribute("message", "Update Successfully");
                response.sendRedirect(request.getContextPath() + "/customer/profile?action=view");
            } else {
                request.setAttribute("message", "Update Failed");
                request.getRequestDispatcher("/Views/user/edit-user-profile.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.getRequestDispatcher("/Views/user/edit-user-profile.jsp").forward(request, response);
        }
    }

    private void viewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            Cookie[] arr = request.getCookies();
            int accountId = 0;
            Account account = null;

            if (arr != null) {
                for (Cookie o : arr) {

                    if (o.getName().equals("userId")) {
                        accountId = Integer.parseInt(o.getValue());
                        AccountDAO aDAO = new AccountDAO();

                        account = aDAO.getAccountById(accountId);

                        break;
                    }

                }
            }

            if (account != null) {
                request.setAttribute("account", account);
                request.getRequestDispatcher("/Views/user/user-profile.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } catch (SQLException ex) {
            response.sendRedirect("404");
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
