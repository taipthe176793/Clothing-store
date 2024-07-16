/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.staff;

import DAL.FeedbackDAO;
import DAL.ProductDAO;
import Models.Feedback;
import Models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author caoqu
 */
public class FeedbackControllers extends HttpServlet {

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
            out.println("<title>Servlet FeedbackControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet FeedbackControllers at " + request.getContextPath() + "</h1>");
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
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            ProductDAO productDAO = new ProductDAO();
            List<Product> products = productDAO.getAllProducts();

            String search = request.getParameter("search");
            String sortDate = request.getParameter("sortDate");

            List<Feedback> feedbacks;
     

            if (search != null && !search.isEmpty()) {
                feedbacks = feedbackDAO.searchFeedbacksByProduct(search);           
            } else {
                feedbacks = feedbackDAO.getAllFeedbacks();              
            }
            
              if ("desc".equals(sortDate)) {
            feedbacks = feedbackDAO.getFeedbacksSortedByDateDescending();
         
        } else if ("asc".equals(sortDate)) {
            feedbacks = feedbackDAO.getFeedbacksSortedByDateAscending();
            
        }

            request.setAttribute("search", search);
            request.setAttribute("sortDate", sortDate);
            request.setAttribute("feedbacks", feedbacks);  
            request.setAttribute("products", products);

            request.getRequestDispatcher("/Views/staff/feedback-table.jsp").forward(request, response);

        } catch (NumberFormatException | SQLException | ClassNotFoundException ex) {
            PrintWriter pw = response.getWriter();
            String mess = "<html> " + ex.getMessage() + "  </html>";
            pw.print(mess);
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

            String action = request.getParameter("action");
            FeedbackDAO feedbackDAO = new FeedbackDAO();

            if (request.getParameter("feedbackId") != null) {
                int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));

                if ("hidden".equals(action)) {
                    feedbackDAO.updateFeedbackStatus(feedbackId, true);

                } else if ("active".equals(action)) {
                    feedbackDAO.updateFeedbackStatus(feedbackId, false);
                } else if ("cancel".equals(action)) {
                    feedbackDAO.cancelReport(feedbackId);
                }
            }
            response.sendRedirect("feedback");
        } catch (SQLException ex) {
        } catch (ClassNotFoundException ex) {
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
