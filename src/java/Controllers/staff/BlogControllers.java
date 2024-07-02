/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controllers.staff;

import DAL.BlogDAO;
import Models.Blog;
import Models.BlogType;
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
import java.util.List;
import java.sql.SQLException;
import java.util.UUID;

/**
 *
 * @author caoqu
 */
@MultipartConfig
public class BlogControllers extends HttpServlet {

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
            out.println("<title>Servlet BlogControllers</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BlogControllers at " + request.getContextPath() + "</h1>");
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
            String action = request.getParameter("action");
            BlogDAO blogDAO = new BlogDAO();
            BlogDAO blogTypeDAO = new BlogDAO();
            List<BlogType> blogTypes = blogTypeDAO.getAllBlogTypes();

            if ("edit".equals(action)) {
                int blogId = Integer.parseInt(request.getParameter("blogId"));
                Blog blog = blogDAO.findBlogById(blogId);

                request.setAttribute("blog", blog);
                request.setAttribute("blogTypes", blogTypes);
                request.getRequestDispatcher("/Views/staff/edit-blog.jsp").forward(request, response);
            } else if ("add".equals(action)) {
                request.setAttribute("blogTypes", blogTypes);
                request.getRequestDispatcher("/Views/staff/add-blog.jsp").forward(request, response);
            } else {
                List<Blog> blogs = blogDAO.getBlogs();

                request.setAttribute("blogs", blogs);
                request.setAttribute("blogTypes", blogTypes);
                request.getRequestDispatcher("/Views/staff/blogs-table.jsp").forward(request, response);
            }
        } catch (IOException | ServletException ex) {
            ex.printStackTrace();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                addBlog(request, response);
                break;
            case "edit":
                editBlog(request, response);
                break;
            case "delete":
                deleteBlog(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/staff/blog");
                break;
        }
    }

    private void addBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String body = request.getParameter("body");
            int blogTypeId = Integer.parseInt(request.getParameter("blogTypeId"));
            Part part = request.getPart("image");

            String imagePath = "";
            if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
                String path = request.getServletContext().getRealPath("/images/blog");
                File dir = new File(path);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String fileName = part.getSubmittedFileName();
                String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1);
                String savedFileName = UUID.randomUUID().toString() + "." + fileExtension;

                File file = new File(dir, savedFileName);
                part.write(file.getAbsolutePath());

                imagePath = request.getContextPath() + "/images/blog/" + savedFileName;
            }
            Blog blog = new Blog();
            blog.setTitle(title);
            blog.setBody(body);
            blog.setBlogTypeId(blogTypeId);
            blog.setImage(imagePath);

            BlogDAO blogDAO = new BlogDAO();
            blogDAO.addBlog(blog);

            HttpSession session = request.getSession();
            session.setAttribute("notification", "New blog added successfully");
            response.sendRedirect(request.getContextPath() + "/staff/blog");
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ServletException("Error adding blog", ex);
        }
    }

    private void editBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int blogId = Integer.parseInt(request.getParameter("blogId"));
            String title = request.getParameter("title");
            String body = request.getParameter("body");
            int blogTypeId = Integer.parseInt(request.getParameter("blogTypeId"));
            Part part = request.getPart("image");

            String imagePath = "";
            if (part != null && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
                String path = request.getServletContext().getRealPath("/images/blog");
                File dir = new File(path);
                if (!dir.exists()) {
                    dir.mkdirs();
                }

                String fileName = part.getSubmittedFileName();
                String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1);
                String savedFileName = UUID.randomUUID().toString() + "." + fileExtension;

                File file = new File(dir, savedFileName);
                part.write(file.getAbsolutePath());

                imagePath = request.getContextPath() + "/images/blog/" + savedFileName;
            } else {
                BlogDAO blogDAO = new BlogDAO();
                Blog currentBlog = blogDAO.findBlogById(blogId);
                if (currentBlog != null) {
                    imagePath = currentBlog.getImage();
                }
            }

            Blog blog = new Blog();
            blog.setBlogId(blogId);
            blog.setTitle(title);
            blog.setBody(body);
            blog.setBlogTypeId(blogTypeId);
            blog.setImage(imagePath);

            BlogDAO blogDAO = new BlogDAO();
            blogDAO.updateBlog(blog);

            HttpSession session = request.getSession();
            session.setAttribute("notification", "Blog updated successfully");
            response.sendRedirect(request.getContextPath() + "/staff/blog");
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ServletException("Error editing blog", ex);
        }
    }

    private void deleteBlog(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int blogId = Integer.parseInt(request.getParameter("blogId"));

            BlogDAO blogDAO = new BlogDAO();
            Blog blog = blogDAO.findBlogById(blogId);

            if (blog != null && !blog.isStatus()) {
                blogDAO.deleteBlog(blogId);
                HttpSession session = request.getSession();
                session.setAttribute("notification", "Blog deleted successfully");
                response.sendRedirect(request.getContextPath() + "/staff/blog");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("notification", "Cannot delete an approved blog");
                response.sendRedirect(request.getContextPath() + "/staff/blog");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new ServletException("Error deleting blog", ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
