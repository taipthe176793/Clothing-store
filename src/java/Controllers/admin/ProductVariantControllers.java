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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
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
            product.setVariantList(pvDao.getAllVariantsOfAProduct(productId));

            HttpSession session = request.getSession();
            if (session.getAttribute("notification") != null) {
                request.setAttribute("notification", session.getAttribute("notification"));
                session.removeAttribute("notification");
            }

            request.setAttribute("product", product);
            request.setAttribute("variantsList", product.getVariantList());

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

        String action = request.getParameter("action") == null ? "" : request.getParameter("action");

        int productId = Integer.parseInt(request.getParameter("pId"));

        switch (action) {
            case "add":
                addVariant(productId, request);
                break;
            case "update":
                updateVariant(productId, request);
                break;
            case "delete":
                deleteVariant(request);
                break;
            default:
                throw new AssertionError();
        }

        String url = request.getRequestURL().toString() + "?pId=" + productId;

        response.sendRedirect(url);

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

    private void addVariant(int productId, HttpServletRequest request) {

        try {

            String color = request.getParameter("color");

            String size = request.getParameter("size");

            int quantity = Integer.parseInt(request.getParameter("quantity"));

            ProductVariant variant = new ProductVariant(productId, color, size, quantity);

            ProductVariantDAO pvDao = new ProductVariantDAO();

            ProductVariant foundVariant = pvDao.findProductVariant(variant);

            HttpSession session = request.getSession();

            if (foundVariant != null && foundVariant.isIsDeleted()) {

                pvDao.updateVariant(foundVariant.getProductVariantId(), variant);
                session.setAttribute("notification", "Added successfully.");

            } else if (foundVariant != null && !foundVariant.isIsDeleted()) {

                session.setAttribute("notification", "Add failed: Existed Variant!");

            } else {

                pvDao.addProductVariant(variant);
                session.setAttribute("notification", "Added successfully.");

            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }

    private void updateVariant(int productId, HttpServletRequest request) {

        try {
            int variantId = Integer.parseInt(request.getParameter("vId"));

            String color = request.getParameter("color");

            String size = request.getParameter("size");

            int quantity = Integer.parseInt(request.getParameter("quantity"));

            ProductVariantDAO pvDao = new ProductVariantDAO();

            ProductVariant foundVariant = pvDao.findVariantByProperties(productId, color, size);

            HttpSession session = request.getSession();

            if (foundVariant != null && foundVariant.getProductVariantId() != variantId) {

                session.setAttribute("notification", "Update failed: Existed Variant!");

            } else {

                pvDao.updateVariant(variantId, new ProductVariant(variantId, productId, color, size, quantity, false));

                session.setAttribute("notification", "Updated successfully.");
            }

        } catch (SQLException ex) {
        }

    }

    private void deleteVariant(HttpServletRequest request) {

        try {
            int variantId = Integer.parseInt(request.getParameter("vId"));

            ProductVariantDAO pvDao = new ProductVariantDAO();

            pvDao.deleteVariant(variantId);

            HttpSession session = request.getSession();

            session.setAttribute("notification", "Deleted successfully.");

        } catch (SQLException ex) {
        }

    }

}
