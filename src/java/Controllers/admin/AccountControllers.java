/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.admin;

import DAL.AccountDAO;
import DAL.RoleDAO;
import Models.Account;
import Models.Role;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
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
public class AccountControllers extends HttpServlet {

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
            out.println("<title>Servlet AccountControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AccountControllers at " + request.getContextPath() + "</h1>");
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
            List<Account> accountList = new ArrayList<>();
            accountList = aDAO.getAccountList();

            RoleDAO rDAO = new RoleDAO();
            List<Role> roleList = new ArrayList<>();
            roleList = rDAO.getRoleList();

            HttpSession session = request.getSession();
            if (session.getAttribute("notification") != null) {
                request.setAttribute("notification", session.getAttribute("notification"));
                session.invalidate();
            }
            request.setAttribute("roleList", roleList);
            request.setAttribute("accountList", accountList);
            request.getRequestDispatcher("/Views/admin/accounts-table.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AccountControllers.class.getName()).log(Level.SEVERE, null, ex);
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

        switch (action) {
            case "add":
                addStaff(request);
                break;
            case "update":
                updateRole(request);
                break;
            default:
                throw new AssertionError();
        }
        response.sendRedirect("accounts");
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

    private void updateRole(HttpServletRequest request) {
        HttpSession session = request.getSession();
        try {
            int accountId = Integer.parseInt(request.getParameter("id"));
            int roleId = Integer.parseInt(request.getParameter("role"));

            AccountDAO aDAO = new AccountDAO();
            if (aDAO.updateAccountRole(accountId, roleId)) {
                session.setAttribute("notification", "Updated successfully");
            } else {
                session.setAttribute("notification", "Update failed");
            }

        } catch (Exception ex) {
            session.setAttribute("notification", "An error occurred while updating the role.");
            Logger.getLogger(CouponControllers.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    private void addStaff(HttpServletRequest request) {
        HttpSession session = request.getSession();
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            int roleId = 2;
            String email = request.getParameter("email");
            String fullname = request.getParameter("fullname");
            String phone = request.getParameter("phone");
            

            if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()
                    || fullname == null || fullname.trim().isEmpty() || email == null || email.trim().isEmpty()
                    || phone == null || phone.trim().isEmpty()) {
                session.setAttribute("notification", "All fields are required.");
                return;
            }

            AccountDAO aDAO = new AccountDAO();
            if (aDAO.checkUsernameExist(username)) {
                session.setAttribute("notification", "Username already exists.");
                return;
            }
            if (aDAO.checkEmailExist(email)) {
                session.setAttribute("notification", "Email already exists.");
                return;
            }

            Account newAccount = new Account();
            newAccount.setUsername(username);
            newAccount.setPassword(password);
            newAccount.setRoleId(roleId);
            newAccount.setFullname(fullname);
            newAccount.setEmail(email);
            newAccount.setPhone(phone);

            aDAO.addAccount(newAccount);
            session.setAttribute("notification", "Staff added successfully.");
        } catch (SQLException | ClassNotFoundException ex) {
            session.setAttribute("notification", "An error occurred while adding the staff.");
            Logger.getLogger(AccountControllers.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}

    
