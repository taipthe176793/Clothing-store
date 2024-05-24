/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.admin;

import DAL.ProductDAO;
import DAL.ProductVariantDAO;
import Models.Product;
import Models.ProductVariant;
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
public class ProductVariantControllers extends HttpServlet {

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
            out.println("<title>Servlet ProductVariantControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductVariantControllers at " + request.getContextPath() + "</h1>");
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
            int productId = Integer.parseInt(request.getParameter("pId"));

            ProductDAO pDao = new ProductDAO();
            ProductVariantDAO pvDao = new ProductVariantDAO();

            Product product = pDao.findProductById(productId);
            List<ProductVariant> variantsList = pvDao.getAllVariantsOfAProduct(productId);

            request.setAttribute("product", product);
            request.setAttribute("variantsList", variantsList);

            request.getRequestDispatcher("/Views/admin/product-variants-table.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            request.setAttribute("error", ex.getMessage());
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
            int productId = Integer.parseInt(request.getParameter("pId"));
            
            String color = request.getParameter("color");
            
            String size = request.getParameter("size");
            
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            ProductVariant variant = new ProductVariant(productId, color, size, quantity);
            
            ProductVariantDAO pvDao = new ProductVariantDAO();
            
            pvDao.addProductVariant(variant);
            
            String url = request.getRequestURL().toString() + "?pId=" + productId;
            
            response.sendRedirect(url);
        } catch (SQLException ex) {
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
