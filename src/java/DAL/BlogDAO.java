/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Blog;
import Models.BlogType;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author caoqu
 */
public class BlogDAO extends DBContext {

    public List<Blog> getBlogs() throws SQLException, ClassNotFoundException {
        List<Blog> blogList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT * FROM [dbo].[blog]";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("blog_id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setBody(rs.getString("body"));
                    blog.setImage(rs.getString("image"));
                    blog.setBlogTypeId(rs.getInt("blog_type_id"));
                    blog.setStatus(rs.getBoolean("status"));
                    blog.setCreatedAt(rs.getDate("created_at"));
                    blogList.add(blog);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }

        return blogList;
    }

    public List<BlogType> getAllBlogTypes() throws SQLException {
        List<BlogType> blogTypes = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT blog_type_id, name FROM blog_type";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    BlogType blogType = new BlogType();
                    blogType.setBlogTypeId(rs.getInt("blog_type_id"));
                    blogType.setName(rs.getString("name"));
                    blogTypes.add(blogType);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }

        return blogTypes;
    }

    public void addBlog(Blog blog) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "INSERT INTO [dbo].[blog] ([title], [body], [image], [blog_type_id], [created_at]) VALUES (?, ?, ?, ?, GETDATE())";
                stm = con.prepareStatement(sql);
                stm.setString(1, blog.getTitle());
                stm.setString(2, blog.getBody());
                stm.setString(3, blog.getImage());
                stm.setInt(4, blog.getBlogTypeId());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }

    public void updateBlog(Blog blog) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "UPDATE [dbo].[blog] SET [title] = ?, [body] = ?, [image] = ?, [blog_type_id] = ? WHERE [blog_id] = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, blog.getTitle());
                stm.setString(2, blog.getBody());
                stm.setString(3, blog.getImage());
                stm.setInt(4, blog.getBlogTypeId());
                stm.setInt(5, blog.getBlogId());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }

    public void deleteBlog(int blogId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                Blog blog = findBlogById(blogId);
                if (blog != null && !blog.isStatus()) {
                    String sql = "DELETE FROM [dbo].[blog] WHERE [blog_id] = ?";
                    stm = con.prepareStatement(sql);
                    stm.setInt(1, blogId);

                    stm.executeUpdate();
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }

    public Blog findBlogById(int blogId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT * FROM [dbo].[blog] WHERE [blog_id] = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, blogId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("blog_id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setBody(rs.getString("body"));
                    blog.setImage(rs.getString("image"));
                    blog.setBlogTypeId(rs.getInt("blog_type_id"));
                    blog.setStatus(rs.getBoolean("status"));
                    blog.setCreatedAt(rs.getDate("created_at"));
                    return blog;
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
        return null;
    }

    public List<Blog> searchBlogsByTitle(String title) throws SQLException, ClassNotFoundException {
        List<Blog> blogList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT * FROM [dbo].[blog] WHERE title LIKE ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + title + "%");
                rs = stm.executeQuery();
                while (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("blog_id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setBody(rs.getString("body"));
                    blog.setImage(rs.getString("image"));
                    blog.setBlogTypeId(rs.getInt("blog_type_id"));
                    blog.setStatus(rs.getBoolean("status"));
                    blog.setCreatedAt(rs.getDate("created_at"));
                    blogList.add(blog);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }

        return blogList;
    }

    public List<Blog> filterBlogsByStatus(boolean status) throws SQLException {
        List<Blog> blogList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT * FROM [dbo].[blog] WHERE status = ?";
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, status);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("blog_id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setBody(rs.getString("body"));
                    blog.setImage(rs.getString("image"));
                    blog.setBlogTypeId(rs.getInt("blog_type_id"));
                    blog.setStatus(rs.getBoolean("status"));
                    blog.setCreatedAt(rs.getDate("created_at"));
                    blogList.add(blog);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }

        return blogList;
    }

    public List<Blog> filterBlogsByBlogType(int blogTypeId) throws SQLException {
        List<Blog> blogList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT * FROM [dbo].[blog] WHERE blog_type_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, blogTypeId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("blog_id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setBody(rs.getString("body"));
                    blog.setImage(rs.getString("image"));
                    blog.setBlogTypeId(rs.getInt("blog_type_id"));
                    blog.setStatus(rs.getBoolean("status"));
                    blog.setCreatedAt(rs.getDate("created_at"));
                    blogList.add(blog);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }

        return blogList;
    }

    public List<Blog> getBlogsSortedByDateDescending() throws SQLException {
        List<Blog> blogList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT * FROM [dbo].[blog] ORDER BY created_at DESC";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("blog_id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setBody(rs.getString("body"));
                    blog.setImage(rs.getString("image"));
                    blog.setBlogTypeId(rs.getInt("blog_type_id"));
                    blog.setStatus(rs.getBoolean("status"));
                    blog.setCreatedAt(rs.getDate("created_at"));
                    blogList.add(blog);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }

        return blogList;
    }

    public List<Blog> getBlogsSortedByDateAscending() throws SQLException {
        List<Blog> blogList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT * FROM [dbo].[blog] ORDER BY created_at ASC";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("blog_id"));
                    blog.setTitle(rs.getString("title"));
                    blog.setBody(rs.getString("body"));
                    blog.setImage(rs.getString("image"));
                    blog.setBlogTypeId(rs.getInt("blog_type_id"));
                    blog.setStatus(rs.getBoolean("status"));
                    blog.setCreatedAt(rs.getDate("created_at"));
                    blogList.add(blog);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }

        return blogList;
    }

}
