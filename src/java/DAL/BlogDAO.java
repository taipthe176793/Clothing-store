/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Blog;
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
                String sql = "SELECT * FROM [dbo].[blogs]";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("blogId"));
                    blog.setTitle(rs.getString("title"));
                    blog.setBody(rs.getString("body"));
                    blog.setImage(rs.getString("image"));
                    blog.setBlogTypeId(rs.getInt("blogTypeId"));
                    blog.setStatus(rs.getBoolean("status"));
                    blog.setCreatedAt(rs.getDate("createdAt"));
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
            if (con != null) {
                con.close();
            }
        }

        return blogList;
    }

    

    public void addBlog(Blog blog) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "INSERT INTO [dbo].[blog] ([title], [body], [image], [blog_type_id], [status]) VALUES (?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, blog.getTitle());
                stm.setString(2, blog.getBody());
                stm.setString(3, blog.getImage());
                stm.setInt(4, blog.getBlogTypeId());
                stm.setBoolean(5, blog.isStatus());

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
                String sql = "UPDATE [dbo].[blog] SET [title] = ?, [body] = ?, [image] = ?, [blog_type_id] = ?, [status] = ? WHERE [blog_id] = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, blog.getTitle());
                stm.setString(2, blog.getBody());
                stm.setString(3, blog.getImage());
                stm.setInt(4, blog.getBlogTypeId());
                stm.setBoolean(5, blog.isStatus());
                stm.setInt(6, blog.getBlogId());

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
                String sql = "DELETE FROM [dbo].[blog] WHERE [blog_id] = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, blogId);

                stm.executeUpdate();
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

}
