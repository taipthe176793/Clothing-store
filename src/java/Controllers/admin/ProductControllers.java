/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.admin;

import DAL.CategoryDAO;
import DAL.ProductDAO;
import Models.Category;
import Models.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
@MultipartConfig
public class ProductControllers extends HttpServlet {

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
            out.println("<title>Servlet ProductManagerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductManagerServlet at " + request.getContextPath() + "</h1>");
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
            ProductDAO pDAO = new ProductDAO();
            CategoryDAO cDAO = new CategoryDAO();

            List<Product> productList = pDAO.getAllProducts();
            List<Category> categoryList = cDAO.getAllCategories();

            request.setAttribute("productList", productList);
            request.setAttribute("categoryList", categoryList);

            request.getRequestDispatcher("/Views/admin/products-table.jsp").forward(request, response);
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

        switch (action) {
            case "add":
                addProduct(request);
                break;
            default:
                throw new AssertionError();
        }
        response.sendRedirect("product");

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

    private void addProduct(HttpServletRequest request) {

        try {

            String name = request.getParameter("name");

            double price = Double.parseDouble(request.getParameter("price"));

            int categoryID = Integer.parseInt(request.getParameter("categoryId"));

            String description = request.getParameter("description") == null ? "" : request.getParameter("description");

            Part[] Parts = {request.getPart("image1"), request.getPart("image2"), request.getPart("image3")};
            List<String> imagePaths = new ArrayList<>();

            for (Part part : Parts) {

                String imagePath = null;

                if (part == null
                        || part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty()) {
                    imagePath = "";
                } else {
                    String path = request.getServletContext().getRealPath("/images");
                    File dir = new File(path);
                    if (!dir.exists()) {
                        dir.mkdirs();
                    }

                    File image = new File(dir, part.getSubmittedFileName());
                    part.write(image.getAbsolutePath());

                    imagePath = request.getContextPath() + "/images/" + image.getName();
                }
                imagePaths.add(imagePath);
            }

            Product product = new Product(name, description, price,
                    imagePaths.get(0), imagePaths.get(1),
                    imagePaths.get(2), categoryID, false, 0.0);

            ProductDAO pDAO = new ProductDAO();

            pDAO.addProduct(product);

        } catch (IOException | ServletException ex) {
        } catch (Exception ex) {
        }

    }

}
