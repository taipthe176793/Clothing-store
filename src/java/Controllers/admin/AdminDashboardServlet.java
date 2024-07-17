package Controllers.admin;

import DAL.BlogDAO;
import DAL.CategoryDAO;
import DAL.OrderDAO;
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
 * @author admin
 */
public class AdminDashboardServlet extends HttpServlet {

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
            out.println("<title>Servlet DashboardServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DashboardServlet at " + request.getContextPath() + "</h1>");
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
            OrderDAO oDao = new OrderDAO();
            double revenueGrowth = oDao.getRevenueGrowth();
            double totalSales = oDao.getTotalSalesThisMonth();
            int orders = oDao.getTotalOrdersThisMonth();
            BlogDAO bDao = new BlogDAO();
            int blogs = bDao.getNoOfNewBlogsThisMonth();
            String[] labels = {"Jan",
                "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
            List<Double> revenues = oDao.getRevenueMonthDataOfYear(2024);
            if (request.getSession().getAttribute("revenues") != null) {
                revenues = (List) request.getSession().getAttribute("revenues");
                if (revenues.size() > 12) {
                    int days;
                    int month = (int) request.getSession().getAttribute("month");
                    int year = (int) request.getSession().getAttribute("year");
                    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
                        days = 31;
                    } else if (month == 2) {
                        days = (year % 4 == 0 && year % 100 != 0) ? 29 : 28;
                    } else {
                        days = 30;
                    }
                    labels = new String[]{"1st", "5th", "10th", "15th", "20th", "25th", days + "th"};
                }
                request.setAttribute("year", request.getSession().getAttribute("year"));
                request.setAttribute("month", request.getSession().getAttribute("month"));
                request.getSession().invalidate();
            }

            StringBuilder labelsJson = new StringBuilder("[");
            for (int i = 0; i < labels.length; i++) {
                labelsJson.append("\"").append(labels[i]).append("\"");
                if (i < labels.length - 1) {
                    labelsJson.append(",");
                }
            }
            labelsJson.append("]");

            CategoryDAO cDao = new CategoryDAO();
            String lableForPieChart = cDao.getAllCategoriesName();
            List<Double> revanuesCate = oDao.getRevenueDataByCategory();

            request.setAttribute("pieChartLabels", lableForPieChart);
            request.setAttribute("pieChartRevenues", revanuesCate);

            request.setAttribute("revenues", revenues);
            request.setAttribute("labelsData", labelsJson);
            request.setAttribute("revenueGrowth", revenueGrowth);
            request.setAttribute("salesThisMonth", totalSales + "");
            request.setAttribute("orders", orders);
            request.setAttribute("noOfBlogs", blogs);
            request.getRequestDispatcher("../Views/admin/dashboard.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AdminDashboardServlet.class.getName()).log(Level.SEVERE, null, ex);
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

            OrderDAO oDao = new OrderDAO();
            List<Double> revenues;
            int year = Integer.parseInt(request.getParameter("year"));
            int month = Integer.parseInt(request.getParameter("month"));
            if (month != 0) {
                revenues = oDao.getRevenueDataByMonthOfYear(month, year);
            } else {
                revenues = oDao.getRevenueMonthDataOfYear(year);
            }
            request.getSession().setAttribute("revenues", revenues);
            request.getSession().setAttribute("year", year);
            request.getSession().setAttribute("month", month);
            response.sendRedirect("dashboard");
        } catch (SQLException ex) {
            Logger.getLogger(AdminDashboardServlet.class.getName()).log(Level.SEVERE, null, ex);
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
