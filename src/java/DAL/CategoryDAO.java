/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class CategoryDAO extends DBContext {

    public List<Category> getAllCategories()
            throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Category> categoryList = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[category]";
                //3. Create Statement
                stm = con.prepareStatement(sql);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {

                    Category c = new Category();

                    c.setCategoryId(rs.getInt("category_id"));
                    c.setName(rs.getString("name"));
                    c.setDescription(rs.getString("description"));
                    c.setImg(rs.getString("img"));

                    categoryList.add(c);

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
        return categoryList;
    }

    public boolean checkCategoryExisted(String name) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean isExisted = false;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[category] WHERE [name] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, name);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                if (rs.next()) {
                    isExisted = true;
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
        return isExisted;
    }

    public void addCategory(Category category) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "INSERT INTO [dbo].[category]\n"
                        + "([name] , [description], [img])\n"
                        + "VALUES\n"
                        + "(?,?,?)";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, category.getName());
                stm.setString(2, category.getDescription());
                stm.setString(3, category.getImg());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

    public void updateCategory(Category category) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        String info = category.toString();
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "UPDATE [dbo].[category]\n"
                        + "   SET [name] = ? \n"
                        + "      ,[description] = ? \n"
                        + "      ,[img] = ? \n"
                        + " WHERE [category_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, category.getName());
                stm.setString(2, category.getDescription());
                stm.setString(3, category.getImg());
                stm.setInt(4, category.getCategoryId());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }

    }

    public Category getCategoryById(int categoryId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Category category = null;

        try {
            // Connect to the database
            con = connect;
            if (con != null) {
                // Create SQL query to retrieve the category by ID
                String sql = "SELECT * FROM [dbo].[category] WHERE [category_id] = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, categoryId);

                // Execute the query
                rs = stm.executeQuery();

                // Process the result
                if (rs.next()) {
                    category = new Category();
                    category.setCategoryId(rs.getInt("category_id"));
                    category.setName(rs.getString("name"));
                    category.setDescription(rs.getString("description"));
                    category.setImg(rs.getString("img"));
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
        return category;
    }

    public String getAllCategoriesName() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        StringBuilder lables = new StringBuilder("[");

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[category]";
                //3. Create Statement
                stm = con.prepareStatement(sql);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    lables.append("\"").append(rs.getString("name")).append("\"");
                    lables.append(",");
                }
                lables.deleteCharAt(lables.lastIndexOf(","));
                lables.append("]");
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }

        }
        return lables.toString();
    }

}
