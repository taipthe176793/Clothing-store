/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.admin;

import DAL.CouponDAO;
import Models.Coupon;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author admin
 */
public class CouponControllers extends HttpServlet {

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
            out.println("<title>Servlet CouponControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CouponControllers at " + request.getContextPath() + "</h1>");
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
            CouponDAO cDAO = new CouponDAO();
            List<Coupon> couponList = cDAO.getAllCoupons();

            request.setAttribute("couponList", couponList);

            HttpSession session = request.getSession();
            if (session.getAttribute("notification") != null) {
                request.setAttribute("notification", session.getAttribute("notification"));
                session.removeAttribute("notification");
            }

            request.getRequestDispatcher("/Views/admin/coupons-table.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CategoryControllers.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CategoryControllers.class.getName()).log(Level.SEVERE, null, ex);
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
                addCoupon(request);
                break;
            case "udpate":
                updateCoupon(request);
                break;
            default:
                throw new AssertionError();
        }
        response.sendRedirect("coupon");
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

    private void addCoupon(HttpServletRequest request) {
    HttpSession session = request.getSession();
    try {
        String code = request.getParameter("code");
        String description = request.getParameter("description");
        int discount = Integer.parseInt(request.getParameter("discount"));
        String expiresAtStr = request.getParameter("expiresAt");
        String startAtStr = request.getParameter("startAt");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate startAt = LocalDate.parse(startAtStr, formatter);
        LocalDate expiresAt = LocalDate.parse(expiresAtStr, formatter);
        LocalDate today = LocalDate.now();

        if (!startAt.isAfter(today)) {
            session.setAttribute("notification", "Start date must be today or later.");
            return;
        }

        if (!startAt.isBefore(expiresAt)) {
            session.setAttribute("notification", "Start date must be before the expiry date.");
            return;
        }

        Coupon coupon = new Coupon(code, description, discount, java.sql.Date.valueOf(expiresAt), java.sql.Date.valueOf(startAt), quantity);
        CouponDAO cDAO = new CouponDAO();

        if (cDAO.checkCouponExisted(code)) {
            session.setAttribute("notification", "Add failed: This coupon already exists.");
        } else {
            cDAO.addCoupon(coupon);
            session.setAttribute("notification", "Added successfully");
        }

    } catch (Exception ex) {
        session.setAttribute("notification", "An error occurred while processing the coupon.");
        Logger.getLogger(CouponControllers.class.getName()).log(Level.SEVERE, null, ex);
    }
}



    private void updateCoupon(HttpServletRequest request) {
    HttpSession session = request.getSession();
    try {
        int couponId = Integer.parseInt(request.getParameter("couponId"));
        String code = request.getParameter("code");
        String description = request.getParameter("description");
        int discount = Integer.parseInt(request.getParameter("discount"));
        String expiresAtStr = request.getParameter("expiresAt");
        String startAtStr = request.getParameter("startAt");
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate startAt = LocalDate.parse(startAtStr, formatter);
        LocalDate expiresAt = LocalDate.parse(expiresAtStr, formatter);
        LocalDate today = LocalDate.now();

        if (!startAt.isAfter(today)) {
            session.setAttribute("notification", "Start date must be today or later.");
            return;
        }

        if (!startAt.isBefore(expiresAt)) {
            session.setAttribute("notification", "Start date must be before the expiry date.");
            return;
        }

        Coupon coupon = new Coupon(couponId, code, description, discount, java.sql.Date.valueOf(expiresAt), java.sql.Date.valueOf(startAt), quantity);
        CouponDAO cDAO = new CouponDAO();

        if (cDAO.checkCouponExisted(code)) {
            session.setAttribute("notification", "Update failed: This coupon already exists.");
        } else {
            cDAO.updateCoupon(coupon);
            session.setAttribute("notification", "Updated successfully");
        }

    } catch (Exception ex) {
        session.setAttribute("notification", "An error occurred while processing the coupon.");
        Logger.getLogger(CouponControllers.class.getName()).log(Level.SEVERE, null, ex);
    }
}


}
