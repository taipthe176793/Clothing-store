/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAL.AccountDAO;
import Models.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class AuthenticationControllers extends HttpServlet {

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
            out.println("<title>Servlet AuthenticationControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AuthenticationControllers at " + request.getContextPath() + "</h1>");
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

        String action = (request.getParameter("action") != null ? request.getParameter("action") : "");

        switch (action) {
            case "login":
                request.getRequestDispatcher("Views/authen/login.jsp").forward(request, response);
                break;

            case "signup":
                request.getRequestDispatcher("Views/authen/signup.jsp").forward(request, response);
                break;
            default:
                throw new AssertionError();
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
        String action = (request.getParameter("action") != null ? request.getParameter("action") : "");
        switch (action) {
            case "signup":
                boolean success = signUp(request, response);
                if (!success) {
                    request.getRequestDispatcher("Views/authen/signup.jsp").forward(request, response);
                } else {
                    request.setAttribute("Success", "Sign Up Successfully!");
                    request.getRequestDispatcher("Views/authen/signup.jsp").forward(request, response);
                }
                break;
            case "login":
                Account account = login(request, response);
                if (account == null) {
                    request.setAttribute("error","Username or password is wrong.");
                    request.getRequestDispatcher("Views/authen/login.jsp").forward(request, response);
                } else {
                    HttpSession session = request.getSession();
                    session.setAttribute("account", account);
                    response.sendRedirect("home");
                }
                break;
            default:
                throw new AssertionError();
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

    private boolean signUp(HttpServletRequest request, HttpServletResponse response) {
        try {
            AccountDAO Adao = new AccountDAO();
            String fullname = request.getParameter("fullname");
            String username = request.getParameter("user");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("pass");
            String confirmpass = request.getParameter("confirm-pass");
            if (!password.equals(confirmpass)) {
                request.setAttribute("error", "Password must match ConfirmPassword!");
                return false;
            }
            if (Adao.checkEmailExist(email)) {
                request.setAttribute("error", "Email is already used for another account!");
                return false;
            }
            if (Adao.checkUsernameExist(username)) {
                request.setAttribute("error", "Username is already existed");
                return false;
            }
            Account acc = new Account(username, password, 3, email, fullname, phone);
            Adao.addAccount(acc);
            return true;

        } catch (SQLException | ClassNotFoundException ex) {
            request.setAttribute("error", ex.getMessage());
        }
        return false;
    }

    public static void main(String[] args) {
        try {
            AccountDAO Adao = new AccountDAO();
            System.out.println(Adao.loginByEmail("taipt21","taipt0820"));
        } catch (SQLException ex) {
            Logger.getLogger(AuthenticationControllers.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }

    private Account login(HttpServletRequest request, HttpServletResponse response) {
        try {
            String userInput = request.getParameter("user");
            String password = request.getParameter("pass");
            Account account = null;
            AccountDAO Adao = new AccountDAO();
            if (userInput.contains("@")) {

                account = Adao.loginByEmail(userInput, password);
                
            } else {
                account = Adao.loginByUsername(userInput, password);
            }
            return account;
        } catch (SQLException ex) {
            request.setAttribute("error", ex.getMessage());     
        } 
        return null;
    } 
}
