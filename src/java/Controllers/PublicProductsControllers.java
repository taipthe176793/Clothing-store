/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

import DAL.CategoryDAO;
import DAL.ProductDAO;
import Models.Category;
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
import utilities.GeneratorUtils;

/**
 *
 * @author admin
 */
public class PublicProductsControllers extends HttpServlet {

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
            out.println("<title>Servlet ProductsServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductsServlet at " + request.getContextPath() + "</h1>");
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
            GeneratorUtils.getNotification(request);
            ProductDAO pDao = new ProductDAO();
            CategoryDAO cDao = new CategoryDAO();

            int numOfProductPerPage = 8;
            int currentPage = Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"));

            String category = request.getParameter("category") == null ? "" : request.getParameter("category");
            String price = request.getParameter("price") == null ? "" : request.getParameter("price");
            String size = request.getParameter("size") == null ? "" : request.getParameter("size");
            String color = request.getParameter("color") == null ? "" : request.getParameter("color");
            String sort = request.getParameter("sort") == null ? "" : request.getParameter("sort");
            String search = request.getParameter("search") == null ? "" : request.getParameter("search");

            String query = "";
            if (!category.isBlank()) {
                query = "category=" + category + "&price=" + price + "&size=" + size + "&color=" + color + "&sort=" + sort;
            }
            if (!search.isBlank()) {
                query += "&search=" + search;
            }

            List<Category> categoryList = cDao.getAllCategories();

            List<Product> productList;
            int numOfProduct = pDao.getAllProducts().size();

            if (!category.isBlank() || !search.isBlank()) {
                productList = pDao.getProductsByFilterAndPage(category, price, size, color, sort, search, currentPage);
                numOfProduct = pDao.getProductsByFilter(category, price, size, color, sort, search).size();
            } else {
                productList = pDao.getProductByPage(currentPage);
            }

            int totalPageNumber = numOfProduct / numOfProductPerPage;

            int numOfProductEndPage = numOfProduct % numOfProductPerPage;
            if (numOfProductEndPage != 0) {
                totalPageNumber++;
            }

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("query", query);

            request.setAttribute("productList", productList);
            request.setAttribute("totalPageNumber", totalPageNumber);
            request.setAttribute("numOfProduct", numOfProduct);

        } catch (SQLException ex) {
        } catch (ClassNotFoundException ex) {
        }

        request.getRequestDispatcher("Views/publicProducts.jsp").forward(request, response);

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
