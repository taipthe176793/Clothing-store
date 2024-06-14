/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.admin;

import DAL.CategoryDAO;
import Models.Category;
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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
@MultipartConfig
public class CategoryControllers extends HttpServlet {

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
            out.println("<title>Servlet CategoryManagerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CategoryManagerServlet at " + request.getContextPath() + "</h1>");
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
            CategoryDAO cDAO = new CategoryDAO();
            List<Category> categoryList = cDAO.getAllCategories();

            request.setAttribute("categoryList", categoryList);

            HttpSession session = request.getSession();
            if (session.getAttribute("notification") != null) {
                request.setAttribute("notification", session.getAttribute("notification"));
                session.removeAttribute("notification");
            }

            request.getRequestDispatcher("/Views/admin/categories-table.jsp").forward(request, response);
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
                addCategory(request);
                break;
            case "update":
                updateCategory(request);
                break;
            default:
                throw new AssertionError();
        }
        response.sendRedirect("category");
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

    private void updateCategory(HttpServletRequest request) {
        try {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String currentImage = request.getParameter("currentImage2");

            Part part = request.getPart("image");
            String imagePath;

            if (part == null || part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty()) {
                imagePath = currentImage;
            } else {
                String path = request.getServletContext().getRealPath("/images/category");
                File dir = new File(path);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                File image = new File(dir, part.getSubmittedFileName());
                part.write(image.getAbsolutePath());

                imagePath = request.getContextPath() + "/images/category/" + image.getName();
            }

            CategoryDAO cDAO = new CategoryDAO();
            HttpSession session = request.getSession();

            boolean isExisted = cDAO.checkCategoryExisted(name);

            if (isExisted) {
                session.setAttribute("notification", "Update failed: This name has already existed.");
            } else {
                Category category = new Category(Integer.parseInt(id), name, imagePath);
                cDAO.updateCategory(category);
                session.setAttribute("notification", "Updated successfully.");
            }

        } catch (IOException | ServletException ex) {
            ex.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private void addCategory(HttpServletRequest request) {

        try {

            String name = request.getParameter("name");

            Part part = request.getPart("image");

            String imagePath = null;

            if (part == null
                    || part.getSubmittedFileName() == null || part.getSubmittedFileName().trim().isEmpty()) {
                imagePath = "";
            } else {
                String path = request.getServletContext().getRealPath("/images/category");
                File dir = new File(path);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                File image = new File(dir, part.getSubmittedFileName());
                part.write(image.getAbsolutePath());

                imagePath = request.getContextPath() + "/images/category/" + image.getName();
            }

            Category category = new Category(name, imagePath);

            CategoryDAO cDAO = new CategoryDAO();
            HttpSession session = request.getSession();

            if (cDAO.checkCategoryExisted(name)) {
                session.setAttribute("notification", "Add failed: This Name is already existed.");
            } else {
                cDAO.addCategory(category);
                session.setAttribute("notification", "Added successfully");
            }

        } catch (IOException | ServletException ex) {
            ex.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

}