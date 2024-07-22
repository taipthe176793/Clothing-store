/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers.customer;

import DAL.AccountDAO;
import DAL.CouponDAO;
import DAL.OrderDAO;
import Models.Account;
import Models.Coupon;
import Models.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import utilities.CommonConst;

/**
 *
 * @author HP
 */
@WebServlet(name="MyCouponController", urlPatterns={"/my-coupon"})
public class MyCouponController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet MyCouponController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MyCouponController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action : "";
        switch (action) {
            case "view":
            default:
                this.showMyCoupon(request, response);
        }
    } 
    
    private void showMyCoupon(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
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
                response.sendRedirect(request.getContextPath() + "/auth?action=login");
                return;
            }
            AccountDAO accountDAO = new AccountDAO();
            CouponDAO couponDAO = new CouponDAO();
            int customerId = accountDAO.getCustomerIdByAccountId(account.getAccountId());
            List<Coupon> coupons = couponDAO.getAllCouponsByCustomer(customerId);
            request.setAttribute("coupons", coupons);
            request.getRequestDispatcher("/Views/user/historyCoupon.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error fetching addresses", e);
        }
    }

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
