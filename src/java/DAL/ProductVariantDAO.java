/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.ProductVariant;
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
public class ProductVariantDAO extends DBContext {

    public List<ProductVariant> getAllVariantsOfAllProducts() throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<ProductVariant> variantsList = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[product_variants]  WHERE [is_deleted] = 0";
                //3. Create Statement
                stm = con.prepareStatement(sql);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    ProductVariant v = new ProductVariant();
                    v.setProductVariantId(rs.getInt("product_variant_id"));
                    v.setProductId(rs.getInt("product_id"));
                    v.setColor(rs.getString("color"));
                    v.setSize(rs.getString("size"));
                    v.setQuantity(rs.getInt("quantity"));
                    v.setIsDeleted(rs.getBoolean("is_deleted"));

                    variantsList.add(v);

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
        return variantsList;

    }

    public List<ProductVariant> getAllVariantsOfAProduct(int productId) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<ProductVariant> variantsList = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[product_variants] WHERE [product_id] = ? AND [is_deleted] = 0";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    ProductVariant v = new ProductVariant();
                    v.setProductVariantId(rs.getInt("product_variant_id"));
                    v.setProductId(rs.getInt("product_id"));
                    v.setColor(rs.getString("color"));
                    v.setSize(rs.getString("size"));
                    v.setQuantity(rs.getInt("quantity"));
                    v.setIsDeleted(rs.getBoolean("is_deleted"));

                    variantsList.add(v);

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
        return variantsList;

    }

    public void addProductVariant(ProductVariant variant) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "INSERT INTO [dbo].[product_variants]\n"
                        + "( [product_id], [color], [size], [quantity])\n"
                        + "VALUES(?,?,?,?)";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, variant.getProductId());
                stm.setString(2, variant.getColor());
                stm.setString(3, variant.getSize());
                stm.setInt(4, variant.getQuantity());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

    public ProductVariant findProductVariant(ProductVariant variant) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[product_variants] WHERE [product_id] = ? AND [color] = ? AND [size] = ? ";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, variant.getProductId());
                stm.setString(2, variant.getColor());
                stm.setString(3, variant.getSize());

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    ProductVariant v = new ProductVariant();
                    v.setProductVariantId(rs.getInt("product_variant_id"));
                    v.setProductId(rs.getInt("product_id"));
                    v.setColor(rs.getString("color"));
                    v.setSize(rs.getString("size"));
                    v.setQuantity(rs.getInt("quantity"));
                    v.setIsDeleted(rs.getBoolean("is_deleted"));

                    return v;

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

    public void updateVariant(int productVariantId, ProductVariant variant) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "UPDATE [dbo].[product_variants]\n"
                        + "   SET [color] = ?\n"
                        + "      ,[size] = ?\n"
                        + "      ,[quantity] = ?\n"
                        + "      ,[is_deleted] = ?\n"
                        + " WHERE [product_variant_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, variant.getColor());
                stm.setString(2, variant.getSize());
                stm.setInt(3, variant.getQuantity());
                stm.setBoolean(4, false);
                stm.setInt(5, productVariantId);

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }

    }

    public void deleteVariant(int variantId) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "UPDATE [dbo].[product_variants]\n"
                        + "   SET [is_deleted] = ?\n"
                        + " WHERE [product_variant_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, true);
                stm.setInt(2, variantId);

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }

    }

    public ProductVariant findVariantByProperties(int productId, String color, String size) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[product_variants] WHERE [product_id] = ? AND [color] = ? AND [size] = ? ";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);
                stm.setString(2, color);
                stm.setString(3, size);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    ProductVariant v = new ProductVariant();
                    v.setProductVariantId(rs.getInt("product_variant_id"));
                    v.setProductId(rs.getInt("product_id"));
                    v.setColor(rs.getString("color"));
                    v.setSize(rs.getString("size"));
                    v.setQuantity(rs.getInt("quantity"));
                    v.setIsDeleted(rs.getBoolean("is_deleted"));

                    return v;

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
