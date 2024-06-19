/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers;

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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author caoqu
 */
public class ProductDetailControllers extends HttpServlet {

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
            out.println("<title>Servlet ProductDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailServlet at " + request.getContextPath() + "</h1>");
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
            
            HttpSession session = request.getSession();
            
            int productId = Integer.parseInt(request.getParameter("id"));
            String color = request.getParameter("color") == null ? "" : request.getParameter("color");
            String size = request.getParameter("size") == null ? "" : request.getParameter("size");
            List<String> sizesOfColor = new ArrayList<>();
            HashMap<String, Integer> sizeQuantity = new HashMap<>();

            ProductDAO pDAO = new ProductDAO();
            Product product = pDAO.findProductById(productId);
            
            List<Product> sameCategory = pDAO.getSameCategoryProducts(product.getCategoryId());

            ProductVariantDAO pvDao = new ProductVariantDAO();
            product.setVariantList(pvDao.getAllVariantsOfAProduct(productId));

            for (ProductVariant pv : product.getVariantList()) {
                //Get sizesOfColor
                if (color.equalsIgnoreCase(pv.getColor())) {
                    sizesOfColor.add(pv.getSize());
                }
                //Get quantity of selected Color
                if (pv.getColor().equalsIgnoreCase(color)) {
                    sizeQuantity.put(pv.getSize(), pv.getQuantity());
                }
            }

            if (!sizesOfColor.contains(size) && !(size.isBlank() || color.isBlank())) {

                response.sendRedirect("product?id=" + productId + "&color=" + color + "&size=" + sizesOfColor.get(0));

            } else if ((color.isBlank() || size.isBlank()) && product.getFirstInStock() != null) {

                response.sendRedirect("product?id=" + productId + "&color="
                        + product.getFirstInStock().getColor() + "&size=" + product.getFirstInStock().getSize());

            } else {
                
                if(session.getAttribute("notification") != null) {
                    request.setAttribute("notification", session.getAttribute("notification"));
                    request.setAttribute("type", session.getAttribute("type"));
                    session.invalidate();
                }
                
                request.setAttribute("color", color);
                request.setAttribute("size", size);
                request.setAttribute("sizesOfColor", sizesOfColor);
                request.setAttribute("sizeQuantity", sizeQuantity);
                request.setAttribute("product", product);
                request.setAttribute("sameCategory", sameCategory);
                request.getRequestDispatcher("Views/productDetail.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
        } catch (ClassNotFoundException ex) {
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
