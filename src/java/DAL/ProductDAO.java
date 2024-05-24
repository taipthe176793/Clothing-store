/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Product;
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
public class ProductDAO extends DBContext {

    public List<Product> getAllProducts()
            throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Product> productList = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[product] WHERE [is_deleted] = 0";
                //3. Create Statement
                stm = con.prepareStatement(sql);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getInt("price"));
                    p.setImg1(rs.getString("image1"));
                    p.setImg2(rs.getString("image2"));
                    p.setImg3(rs.getString("image3"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setIsDelete(rs.getBoolean("is_deleted"));
                    p.setRating(rs.getDouble("rating"));

                    productList.add(p);

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
        return productList;
    }

    public Product findProductById(int productId)
            throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[product] WHERE [product_id] = ? AND [is_deleted] = 0";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                if (rs.next()) {
                    Product p = new Product();
                    p.setProductId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getInt("price"));
                    p.setImg1(rs.getString("image1"));
                    p.setImg2(rs.getString("image2"));
                    p.setImg3(rs.getString("image3"));
                    p.setCategoryId(rs.getInt("category_id"));
                    p.setIsDelete(rs.getBoolean("is_deleted"));
                    p.setRating(rs.getDouble("rating"));

                    return p;

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

    public void addProduct(Product product) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "INSERT INTO [dbo].[product]\n"
                        + "([name] , [description], [price], [image1], [image2] , [image3], [category_id], [is_deleted], [rating])\n"
                        + "VALUES\n"
                        + "(?,?,?,?,?,?,?,?,?)";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, product.getName());
                stm.setString(2, product.getDescription());
                stm.setDouble(3, product.getPrice());
                stm.setString(4, product.getImg1());
                stm.setString(5, product.getImg2());
                stm.setString(6, product.getImg3());
                stm.setInt(7, product.getCategoryId());
                stm.setBoolean(8, false);
                stm.setDouble(9, product.getRating());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

}
