/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAL.OrderDAO;
import DAL.OrderDetailsDAO;
import Models.Order;
import Models.OrderDetails;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import utilities.CommonConst;
import static utilities.CommonConst.IS_PAID;
import static utilities.CommonConst.ORDER_CANCELLED_STATUS;
import utilities.EmailUtils;
import utilities.VNPayUtils;

/**
 *
 * @author admin
 */
public class VNPAYReturnServlet extends HttpServlet {

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
            out.println("<title>Servlet VNPAYReturnServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VNPAYReturnServlet at " + request.getContextPath() + "</h1>");
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
        Map<String, String> vnpParams = request.getParameterMap()
                .entrySet()
                .stream()
                .collect(Collectors.toMap(Map.Entry::getKey, e -> e.getValue()[0]));

        boolean isValid = VNPayUtils.verifyResponse(vnpParams);
        if (isValid) {
            try {
                String orderId = vnpParams.get("vnp_TxnRef");
                String transactionStatus = vnpParams.get("vnp_TransactionStatus");

                OrderDAO orderDAO = new OrderDAO();
                Order order = orderDAO.getOrderByOrderId(Integer.parseInt(orderId));

                if ("00".equals(transactionStatus)) {
                    order.setIsPaid(true);
                    orderDAO.updateOrderPaymentStatus(order.getOrderId(), IS_PAID);

                    String content = EmailUtils.generateOrderEmailContent(order, CommonConst.ORDER_CONFIRMATION_SUBTITLE);
                    EmailUtils.sendEmail(order.getEmail(), CommonConst.ORDER_CONFIRMATION_TITLE, content);

                    response.sendRedirect("checkout-success");
                } else {
                    order.setStatus(CommonConst.ORDER_CANCELLED_STATUS);
                    orderDAO.updateOrderStatus(order.getOrderId(), ORDER_CANCELLED_STATUS);

                    // Updating variation quantity after order has been cancelled
                    for (OrderDetails orDetails : order.getListOrderDetails()) {
                        orderDAO.updateVariationQuantityOfCancelledOrder(orDetails);
                    }

                    String content = EmailUtils.generateOrderEmailContent(order, "A transaction error has occurred. Your Order " + order.getOrderCode() + " has been cancelled.");
                    EmailUtils.sendEmail(order.getEmail(), CommonConst.ORDER_PAYMENT_FAILED_TITLE, content);

                    response.sendRedirect("checkout-failed");
                }
            } catch (SQLException | ClassNotFoundException ex) {
                Logger.getLogger(VNPAYReturnServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            response.sendRedirect("checkout-failed");
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
        processRequest(request, response);
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
