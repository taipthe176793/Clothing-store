/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controllers.customer;

import DAL.AccountDAO;
import DAL.OrderDAO;
import Models.Account;
import Models.CustomerAddress;
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
import static utilities.CommonConst.USER_ID_COOKIE;

/**
 *
 * @author HP
 */
@WebServlet(name="HistoryOrderController", urlPatterns={"/history-order"})
public class HistoryOrderController extends HttpServlet {
   
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
            out.println("<title>Servlet HistoryOrderController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HistoryOrderController at " + request.getContextPath () + "</h1>");
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
                this.showDetailOrder(request, response);
                break;
            default:
                this.showHistory(request, response);
        }
    } 
    
    private void showDetailOrder(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            Cookie[] arr = request.getCookies();
            int accountId = 0;
            Account account = null;

            if (arr != null) {
                for (Cookie o : arr) {

                    if (o.getName().equals(USER_ID_COOKIE)) {
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
            OrderDAO orderDao = new OrderDAO();
            int customerId = accountDAO.getCustomerIdByAccountId(account.getAccountId());
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            Order order = orderDao.getUserOrdersById(customerId, orderId);
            request.setAttribute("order", order);
            request.getRequestDispatcher("/Views/user/detailOrder.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Errror: " + e);
            throw new ServletException("Error fetching addresses", e);
        }
    }
    
    private void showHistory(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            Cookie[] arr = request.getCookies();
            int accountId = 0;
            Account account = null;
            if (arr != null) {
                for (Cookie o : arr) {

                    if (o.getName().equals(USER_ID_COOKIE)) {
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
            OrderDAO orderDao = new OrderDAO();
            int customerId = accountDAO.getCustomerIdByAccountId(account.getAccountId());
            List<Order> orders = orderDao.getUserOrders(customerId);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/Views/user/historyOrder.jsp").forward(request, response);
        } catch (SQLException e) {
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
