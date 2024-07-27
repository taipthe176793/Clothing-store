/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.staff;

import DAL.AccountDAO;
import DAL.OrderDAO;
import DAL.ProductVariantDAO;
import Models.Account;
import Models.Order;
import Models.OrderDetails;
import Models.ProductVariant;
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
import static utilities.CommonConst.OPERATION_INCREASE;
import static utilities.CommonConst.ORDER_CANCELLED_STATUS;
import static utilities.CommonConst.ORDER_DELIVERED_STATUS;

/**
 *
 * @author HP
 */
@WebServlet(name = "ManagerOrderController", urlPatterns = {"/staff/manage-order"})
public class ManagerOrderController extends HttpServlet {

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
            out.println("<title>Servlet ManagerOrderController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerOrderController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action : "";
        switch (action) {
            case "view":
                this.showDetailOrder(request, response);
                break;
            case "requested":
                this.showAllOrderRequest(request, response);
                break;
            default:
                this.showAllOrder(request, response);
        }
    }

    private void showAllOrderRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            AccountDAO accountDAO = new AccountDAO();
            OrderDAO orderDao = new OrderDAO();
            List<Order> orders = orderDao.getUserOrdersByStaffReq();
            request.setAttribute("requested", "true");
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/Views/staff/manage-order.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error fetching addresses", e);
        }
    }

    private void showDetailOrder(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            OrderDAO orderDao = new OrderDAO();
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            Order order = orderDao.getUserOrdersById(orderId);
            request.setAttribute("order", order);
            request.getRequestDispatcher("/Views/staff/orderDetail.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Errror: " + e);
            throw new ServletException("Error fetching addresses", e);
        }
    }

    private void showAllOrder(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            AccountDAO accountDAO = new AccountDAO();
            OrderDAO orderDao = new OrderDAO();
            List<Order> orders = orderDao.getUserOrdersByStaff();
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/Views/staff/manage-order.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error fetching addresses", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        action = action != null ? action : "";
        switch (action) {
            case "UpdateStatus":
                this.updateStatus(request, response);
                break;
            default:
                throw new AssertionError();
        }
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            OrderDAO orderDao = new OrderDAO();
            int result = orderDao.updateOrderStatus(orderId, status);
            if (status.equals(ORDER_DELIVERED_STATUS)) {
                orderDao.updateOrderPaymentStatus(orderId, 1);
            } else if (status.equals(ORDER_CANCELLED_STATUS)) {
                for (OrderDetails od : orderDao.getOrderByOrderId(orderId).getListOrderDetails()) {
                    int quantity = od.getQuantity();
                    ProductVariantDAO pvDAO = new ProductVariantDAO();
                    ProductVariant v = pvDAO.findProductVariantById(od.getProductVariantId());
                    pvDAO.updateVariantQuantity(v, quantity, OPERATION_INCREASE);
                }
            }

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/staff/manage-order?action=view&orderId=" + orderId + "&success=Change status order successfully");
            } else {
                response.sendRedirect(request.getContextPath() + "/staff/manage-order?action=view&orderId=" + orderId + "&error=Change status order fail");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/staff/manage-order?error=Have a error with data");
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
