/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import Controllers.customer.CartControllers;
import DAL.AccountDAO;
import Models.Account;
import Models.GoogleAccount;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import utilities.CommonConst;
import static utilities.CommonConst.CART_COOKIE;
import static utilities.CommonConst.NOTI_SUCCESS;
import static utilities.CommonConst.ROLE_CUSTOMER;
import utilities.CookieUtils;
import utilities.EmailUtils;
import utilities.EncryptionUtils;
import utilities.GeneratorUtils;

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
                    GeneratorUtils.getNotification(request);
                    request.getRequestDispatcher("Views/authen/login.jsp").forward(request, response);
                    break;
                case "signup":
                    request.getRequestDispatcher("Views/authen/signup.jsp").forward(request, response);
                    break;
                case "logout":
                    CookieUtils.deleteCookieByName(CommonConst.USER_ID_COOKIE, request, response);
                    CookieUtils.deleteCookieByName(CommonConst.USER_ROLE, request, response);

                    CookieUtils.updateCookieValueByName(CommonConst.CART_COOKIE, EncryptionUtils.encrypt(""), request, response);
                    response.sendRedirect("home");
                    break;
                case "loginWithGoogle":
                    Account gAccount = loginWithGoogle(request, response);
                    if (gAccount != null) {
                        CartControllers.mergeAndSyncCart(request, response, gAccount);

                        CookieUtils.updateCookieValueByName(CommonConst.USER_ID_COOKIE, gAccount.getAccountId() + "", request, response);

                        CookieUtils.updateCookieValueByName(CommonConst.USER_ROLE, gAccount.getRoleId() + "", request, response);

                        response.sendRedirect("home");
                    } else {
                        request.setAttribute("error", "Login Failed");
                        request.getRequestDispatcher("Views/authen/login.jsp").forward(request, response);
                    }
                    break;
                case "forgotPassword":
                    request.getRequestDispatcher("Views/authen/forgotPassword.jsp").forward(request, response);
                    break;
                case "newPassword":
                    request.getRequestDispatcher("Views/authen/newPassword.jsp").forward(request, response);
                    break;
                case "validateOtp":
                    request.getRequestDispatcher("Views/authen/enterOtp.jsp").forward(request, response);
                    break;
                default:
                    throw new AssertionError();
            }

        } catch (SQLException ex) {
            response.sendRedirect("404");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AuthenticationControllers.class.getName()).log(Level.SEVERE, null, ex);
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
                        GeneratorUtils.makeNotification(request, "SignUp Successfully", NOTI_SUCCESS);
                        response.sendRedirect("auth?action=login");
                    }
                    break;
                case "login":
                    String userInput = request.getParameter("user");
                    String password = request.getParameter("pass");

                    if (validateInput(userInput, password)) {
                        Account account = login(request, response);
                        if (account == null) {
                            request.setAttribute("error", "Username or password is wrong.");
                            request.setAttribute("user", userInput);
                            request.getRequestDispatcher("Views/authen/login.jsp").forward(request, response);
                        } else {

                            CartControllers.mergeAndSyncCart(request, response, account);

                            CookieUtils.updateCookieValueByName(CommonConst.USER_ID_COOKIE, account.getAccountId() + "", request, response);

                            CookieUtils.updateCookieValueByName(CommonConst.USER_ROLE, account.getRoleId() + "", request, response);

                            switch (account.getRoleId()) {
                                case CommonConst.ROLE_ADMIN:
                                    response.sendRedirect("admin/dashboard");
                                    break;
                                case CommonConst.ROLE_STAFF:
                                    response.sendRedirect("staff/manage-order");
                                    break;
                                default:
                                    response.sendRedirect("home");
                                    break;
                            }
                        }
                    } else {
                        request.setAttribute("error", "Username and Password must not contain spaces.");
                        request.setAttribute("user", userInput);
                        request.getRequestDispatcher("Views/authen/login.jsp").forward(request, response);
                    }
                    break;
                case "forgotPassword":
                    forgotPassword(request, response);
                    break;
                case "newPassword":
                    newPassword(request, response);
                    break;
                case "validateOtp":
                    validateOtp(request, response);
                    break;
                default:
                    throw new AssertionError();
            }

        } catch (SQLException ex) {
            response.sendRedirect("404");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AuthenticationControllers.class.getName()).log(Level.SEVERE, null, ex);
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
            Account acc = new Account(username, EncryptionUtils.toSHA256(password), ROLE_CUSTOMER, email, fullname, phone);
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

                account = aDAO.loginByEmail(userInput, EncryptionUtils.toSHA256(password));

            } else {
                account = aDAO.loginByUsername(userInput, EncryptionUtils.toSHA256(password));
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
                    String username = acc.getEmail().split("@")[0];
                    String password = GeneratorUtils.generateRandomPassword();
                    account.setUsername(username);
                    account.setPassword(EncryptionUtils.toSHA256(password));
                    account.setEmail(acc.getEmail());
                    account.setRoleId(ROLE_CUSTOMER);
                    account.setFullname(acc.getName());
                    account.setPhone("");
                    aDAO.addAccount(account);
                }
                account = aDAO.getAccountByEmail(acc.getEmail());
                return account;
            }
        } catch (IOException | SQLException | ClassNotFoundException ex) {
            Logger.getLogger(AuthenticationControllers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    private boolean validateInput(String username, String password) {
        return username != null && !username.contains(" ")
                && password != null && !password.contains(" ");
    }

    private void forgotPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        AccountDAO aDAO = new AccountDAO();

        try {
            if (!aDAO.checkEmailExist(email)) {
                request.setAttribute("error", "Email does not exist in our system.");
                request.getRequestDispatcher("Views/authen/forgotPassword.jsp").forward(request, response);
                return;
            }

            // Generate OTP
            Random rd = new Random();
            int otp = rd.nextInt(900000) + 100000;

            // Send OTP via email
            String subject = "Reset Password";
            String content = "Your OTP code is: " + otp;
            EmailUtils.sendEmail(email, subject, content);

            // Store OTP and email in session
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);

            // Redirect to validate OTP page
            response.sendRedirect("auth?action=validateOtp");

        } catch (SQLException | ClassNotFoundException e) {
            request.setAttribute("error", "Internal error occurred. Please try again later.");
            request.getRequestDispatcher("Views/authen/forgotPassword.jsp").forward(request, response);
        }
    }

    private void newPassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String password = request.getParameter("password");
        String confPassword = request.getParameter("confPassword");
        String email = (String) request.getSession().getAttribute("email");

        // Validate password fields
        if (password == null || password.trim().isEmpty()
                || confPassword == null || confPassword.trim().isEmpty()) {
            request.setAttribute("message", "Password fields cannot be empty.");
            request.getRequestDispatcher("Views/authen/enterOtp.jsp").forward(request, response);
            return;
        }

        // Validate passwords match
        if (!password.equals(confPassword)) {
            request.setAttribute("message", "Passwords do not match.");
            request.getRequestDispatcher("Views/authen/enterOtp.jsp").forward(request, response);
            return;
        }

        // Process password reset here
        try {
            // Convert email to accountId (if needed), assuming AccountDAO is used
            AccountDAO accountDAO = new AccountDAO();
            Account account = accountDAO.getAccountByEmail(email);
            if (account != null) {
                // Update password in database for the account
                account.setPassword(EncryptionUtils.toSHA256(password)); // Set new password (you might need to hash it)
                boolean updateResult = accountDAO.updatePassword(account);

                if (updateResult) {
                    request.setAttribute("message", "Password updated successfully.");
                    response.sendRedirect("auth?action=login");
                } else {
                    request.setAttribute("message", "Failed to update password.");
                    request.getRequestDispatcher("Views/authen/enterOtp.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("message", "Account not found.");
                request.getRequestDispatcher("Views/authen/enterOtp.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("message", "Error updating password: " + ex.getMessage());
            request.getRequestDispatcher("Views/authen/enterOtp.jsp").forward(request, response);
        }
    }

    private void validateOtp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int value = Integer.parseInt(request.getParameter("otp"));
            HttpSession session = request.getSession();
            Integer otp = (Integer) session.getAttribute("otp"); // Use Integer to handle null values

            if (otp == null) {
                request.setAttribute("message", "Session expired. Please try again.");
                request.getRequestDispatcher("Views/authen/forgotPassword.jsp").forward(request, response);
                return;
            }

            RequestDispatcher dispatcher = null;
            if (value == otp) {
                String email = (String) session.getAttribute("email");
                if (email != null) {
                    request.setAttribute("email", email);
                    request.setAttribute("status", "success");
                    request.getRequestDispatcher("Views/authen/newPassword.jsp").forward(request, response);
                } else {
                    request.setAttribute("message", "Email not found in session.");
                    request.getRequestDispatcher("Views/authen/forgotPassword.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("message", "Wrong OTP!");
                request.getRequestDispatcher("Views/authen/enterOtp.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid OTP value.");
            request.getRequestDispatcher("Views/authen/enterOtp.jsp").forward(request, response);
        }
    }

}
