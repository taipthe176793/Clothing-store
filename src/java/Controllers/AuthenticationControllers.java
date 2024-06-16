/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import Controllers.customer.CartControllers;
import DAL.AccountDAO;
import DAL.CartItemDAO;
import Models.Account;
import Models.CartItem;
import Models.GoogleAccount;
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
 * @author admin
 */
public class AuthenticationControllers extends HttpServlet {

    private static final int ADMIN_ROLE = 1;
    private static final int STAFF_ROLE = 2;

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

            String action = (request.getParameter("action") != null ? request.getParameter("action") : "");

            switch (action) {
                case "login":
                    request.getRequestDispatcher("Views/authen/login.jsp").forward(request, response);
                    break;
                case "signup":
                    request.getRequestDispatcher("Views/authen/signup.jsp").forward(request, response);
                    break;
                case "logout":
                    Cookie[] arr = request.getCookies();
                    if (arr != null) {
                        for (Cookie o : arr) {
                            if (o.getName().equals("cart")) {
                                o.setMaxAge(0);
                                response.addCookie(o);
                            }
                            if (o.getName().equals("userId")) {
                                o.setMaxAge(0);
                                response.addCookie(o);
                            }
                            if (o.getName().equals("username")) {
                                o.setMaxAge(0);
                                response.addCookie(o);
                            }
                            if (o.getName().equals("role")) {
                                o.setMaxAge(0);
                                response.addCookie(o);
                            }
                        }
                        Cookie cartCookie = new Cookie("cart", "");
                        cartCookie.setMaxAge(60*60*24*7);
                        response.addCookie(cartCookie);
                    }
                    response.sendRedirect("home");
                    break;
                case "loginWithGoogle":
                    Account gAccount = loginWithGoogle(request, response);
                    if (gAccount != null) {
                        arr = request.getCookies();
                        String cartCookie = "";
                        if (arr != null) {
                            for (Cookie o : arr) {
                                if (o.getName().equals("cart")) {
                                    CartControllers.mergeAndSyncCart(response, gAccount, o);
                                }
                            }
                        }

                        Cookie userId = new Cookie("userId", gAccount.getAccountId() + "");
                        userId.setMaxAge(60 * 60 * 24 * 7);
                        response.addCookie(userId);

                        Cookie username = new Cookie("username", gAccount.getUsername());
                        username.setMaxAge(60 * 60 * 24 * 7);
                        response.addCookie(username);

                        Cookie role = new Cookie("role", gAccount.getRoleId() + "");
                        role.setMaxAge(60 * 60 * 24 * 7);
                        response.addCookie(role);

                        response.sendRedirect("home");
                    } else {
                        request.setAttribute("error", "Login Failed");
                        request.getRequestDispatcher("Views/authen/login.jsp").forward(request, response);
                    }
                    break;
                default:
                    throw new AssertionError();
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
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
                        request.setAttribute("error", "Username or password is wrong.");
                        request.getRequestDispatcher("Views/authen/login.jsp").forward(request, response);
                    } else {

                        Cookie[] arr = request.getCookies();
                        String cartCookie = "";
                        if (arr != null) {
                            for (Cookie o : arr) {
                                if (o.getName().equals("cart")) {
                                    CartControllers.mergeAndSyncCart(response, account, o);
                                    break;
                                }
                            }

                        }

                        Cookie userId = new Cookie("userId", account.getAccountId() + "");
                        userId.setMaxAge(60 * 60 * 24 * 7);
                        response.addCookie(userId);

                        Cookie username = new Cookie("username", account.getUsername());
                        username.setMaxAge(60 * 60 * 24 * 7);
                        response.addCookie(username);

                        Cookie role = new Cookie("role", account.getRoleId() + "");
                        role.setMaxAge(60 * 60 * 24 * 7);
                        response.addCookie(role);

                        if (Integer.parseInt(role.getValue()) == ADMIN_ROLE) {
                            response.sendRedirect("admin/dashboard");
                        } else if (Integer.parseInt(role.getValue()) == STAFF_ROLE) {
                            response.sendRedirect("staff/dashboard");
                        } else {
                            response.sendRedirect("home");
                        }
                    }
                    break;
                default:
                    throw new AssertionError();
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

    private boolean signUp(HttpServletRequest request, HttpServletResponse response) {
        try {
            AccountDAO aDAO = new AccountDAO();
            String fullname = request.getParameter("fullname");
            String username = request.getParameter("user");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("pass");
            String confirmpass = request.getParameter("confirm-pass");
            if (!password.equals(confirmpass)) {
                request.setAttribute("error", "Password must match Confirm Password!");
                return false;
            }
            if (aDAO.checkEmailExist(email)) {
                request.setAttribute("error", "Email is already used for another account!");
                return false;
            }
            if (aDAO.checkUsernameExist(username)) {
                request.setAttribute("error", "Username is already existed");
                return false;
            }
            Account acc = new Account(username, password, 3, email, fullname, phone);
            aDAO.addAccount(acc);
            return true;

        } catch (SQLException | ClassNotFoundException ex) {
            request.setAttribute("error", ex.getMessage());
        }
        return false;
    }

    private Account login(HttpServletRequest request, HttpServletResponse response) {
        try {
            String userInput = request.getParameter("user");
            String password = request.getParameter("pass");
            Account account = null;
            AccountDAO aDAO = new AccountDAO();
            if (userInput.contains("@")) {

                account = aDAO.loginByEmail(userInput, password);

            } else {
                account = aDAO.loginByUsername(userInput, password);
            }
            return account;
        } catch (SQLException ex) {
            request.setAttribute("error", ex.getMessage());
        }
        return null;
    }

    private Account loginWithGoogle(HttpServletRequest request, HttpServletResponse response) {
        try {
            String code = request.getParameter("code");
            GoogleLogin gg = new GoogleLogin();
            String accessToken = gg.getToken(code);
            GoogleAccount acc = gg.getUserInfo(accessToken);
            Account account = null;
            if (acc == null) {
                return null;
            } else {
                AccountDAO aDAO = new AccountDAO();
                account = new Account();
                if (!aDAO.checkEmailExist(acc.getEmail())) {
                    account.setUsername(acc.getEmail());
                    String username = account.getUsername();
                    account.setPassword("12345678");
                    account.setEmail(acc.getEmail());
                    account.setRoleId(3);
                    account.setFullname(acc.getGiven_name());
                    account.setPhone("");
                    aDAO.addAccount(account);
                }
                account = aDAO.getAccountByEmail(acc.getEmail());
                return account;
            }
        } catch (IOException ex) {
            Logger.getLogger(AuthenticationControllers.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AuthenticationControllers.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AuthenticationControllers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }
}
