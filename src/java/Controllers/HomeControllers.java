/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAL.CategoryDAO;
import DAL.ProductDAO;
import DAL.ProductVariantDAO;
import Models.Category;
import Models.Product;
import Models.ProductVariant;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class HomeControllers extends HttpServlet {

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
            out.println("<title>Servlet HomeControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeControllers at " + request.getContextPath() + "</h1>");
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
            List<Category> categoryList = new ArrayList<>();
            CategoryDAO cDAO = new CategoryDAO();
            categoryList = cDAO.getAllCategories();
            ProductDAO pDAO = new ProductDAO();
            List<Product> products = pDAO.getAllProducts();
            ProductVariantDAO pvDAO = new ProductVariantDAO();

            for (int i = 0; i < products.size(); i++) {
                Product p = products.get(i);
                p.setVariantList(pvDAO.getAllVariantsOfAProduct(p.getProductId()));
                products.set(i, p);
            }

            List<Product> lastestProducts = pDAO.getLastestProducts();
            List<Product> randomProducts = pDAO.getRandomProducts();

            request.setAttribute("lastestProducts", lastestProducts);
            request.setAttribute("randomProducts", randomProducts);

            request.setAttribute("categoryList", categoryList);
            request.getRequestDispatcher("Views/home.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
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
