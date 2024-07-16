/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.customer;

import DAL.FeedbackDAO;
import DAL.OrderDAO;
import DAL.OrderDetailsDAO;
import DAL.ProductDAO;
import Models.Feedback;
import Models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import static utilities.CommonConst.USER_ID_COOKIE;
import utilities.CookieUtils;
import utilities.GeneratorUtils;

/**
 *
 * @author caoqu
 */
public class FeedbackCusController extends HttpServlet {

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
            out.println("<title>Servlet FeedbackCusController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackCusController at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            List<Feedback> feedbackList;

            String starFilterParam = request.getParameter("starFilter");
            if (starFilterParam == null || starFilterParam.equals("All")) {
                feedbackList = feedbackDAO.getFeedbacksByProductId(productId);
            } else {
                int starFilter = Integer.parseInt(starFilterParam);
                feedbackList = feedbackDAO.getFeedbacksByProductIdAndRating(productId, starFilter);
            }
            

            request.getSession().setAttribute("feedbackList", feedbackList);
            request.getSession().setAttribute("starFilter", starFilterParam);
            
            response.sendRedirect(request.getServletContext().getContextPath() + "/product?id=" + productId);

        } catch (NumberFormatException | SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            int productId = Integer.parseInt(request.getParameter("productId"));
            int feedbackId = request.getParameter("feedbackId") != null ? Integer.parseInt(request.getParameter("feedbackId")) : 0;

            FeedbackDAO feedbackDAO = new FeedbackDAO();

            if ("report".equals(action) && feedbackId > 0) {
                feedbackDAO.reportFeedback(feedbackId);
                GeneratorUtils.makeNotification(request, "Report success", utilities.CommonConst.NOTI_SUCCESS);
            } else {
                int customerId = 0;
                String cusId = CookieUtils.getCookieValueByName(USER_ID_COOKIE, request);
                if (!cusId.isBlank()) {
                    customerId = Integer.parseInt(cusId);
                }

                String comment = request.getParameter("comment");
                double rating = Double.parseDouble(request.getParameter("rating"));

                Feedback existingFeedback = feedbackDAO.getFeedbackByCustomerIdAndProductId(customerId, productId);
                if (existingFeedback != null) {
                    existingFeedback.setComment(comment);
                    existingFeedback.setRating(rating);
                    feedbackDAO.updateFeedback(existingFeedback);
                } else {
                    Feedback newFeedback = new Feedback();
                    newFeedback.setCustomerId(customerId);
                    newFeedback.setProductId(productId);
                    newFeedback.setComment(comment);
                    newFeedback.setRating(rating);
                    feedbackDAO.saveFeedback(newFeedback);
                }

            }
            response.sendRedirect(request.getServletContext().getContextPath() + "/product?id=" + productId);
        } catch (NumberFormatException | SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
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
