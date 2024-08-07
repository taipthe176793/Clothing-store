/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.OrderDetails;
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
public class OrderDetailsDAO extends DBContext {

    public void insertOrderDetails(int orderId, int quantity, int variantId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "INSERT INTO [dbo].[order_detail]\n"
                        + "           ([order_id]\n"
                        + "           ,[quantity]\n"
                        + "           ,[product_variant_id])\n"
                        + "     VALUES\n"
                        + "           ( ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setInt(1, orderId);
                stm.setInt(2, quantity);
                stm.setInt(3, variantId);

                stm.executeUpdate();

            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }

    public boolean hasPurchasedProduct(int customerId, int productId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean hasPurchased = false;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT COUNT(*) "
                        + "FROM order_detail AS od "
                        + "WHERE od.order_id IN ("
                        + "    SELECT o.order_id "
                        + "    FROM orders AS o "
                        + "    WHERE o.customer_id = ? "
                        + ") "
                        + "AND od.product_variant_id = ?";

                stm = con.prepareStatement(sql);
                stm.setInt(1, customerId);
                stm.setInt(2, productId);
                System.out.println("customerId: " + customerId);
                System.out.println("productId: " + productId);

                rs = stm.executeQuery();

                if (rs.next() && rs.getInt(1) > 0) {
                    hasPurchased = true;
                }
                System.out.println("hasPurchased: " + hasPurchased);
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
        }

        return hasPurchased;
    }

    List<OrderDetails> getListOrderDetailByOrderId(int orderId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<OrderDetails> orderDetailList = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT [order_detail_id]\n"
                        + "      ,[order_id]\n"
                        + "      ,[quantity]\n"
                        + "      ,[product_variant_id]\n"
                        + "  FROM [dbo].[order_detail]\n"
                        + "  WHERE [order_id] = ?";

                stm = con.prepareStatement(sql);
                stm.setInt(1, orderId);

                rs = stm.executeQuery();

                while (rs.next()) {
                    OrderDetails od = new OrderDetails();
                    od.setOrderDetailId(rs.getInt("order_detail_id"));
                    od.setOrderId(rs.getInt("order_id"));
                    od.setProductVariantId(rs.getInt("product_variant_id"));
                    od.setQuantity(rs.getInt("quantity"));
                    orderDetailList.add(od);
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

        return orderDetailList;
    }
    
     public List<OrderDetails> getOrderDetailsByOrderId(int orderId) throws ClassNotFoundException {
        List<OrderDetails> orderDetailsList = new ArrayList<>();
        String query = "SELECT order_detail_id, order_id, product_variant_id, quantity FROM Order_Detail WHERE order_id = ?";
        
        try (PreparedStatement preparedStatement = connect.prepareStatement(query)) {
            preparedStatement.setInt(1, orderId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    OrderDetails orderDetails = new OrderDetails();
                    orderDetails.setOrderDetailId(resultSet.getInt("order_detail_id"));
                    orderDetails.setOrderId(resultSet.getInt("order_id"));
                    orderDetails.setProductVariantId(resultSet.getInt("product_variant_id"));
                    orderDetails.setQuantity(resultSet.getInt("quantity"));
                    ProductVariantDAO varianDao = new ProductVariantDAO();
                    orderDetails.setVariant(varianDao.findProductVariantById(resultSet.getInt("product_variant_id")));
                    orderDetailsList.add(orderDetails);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orderDetailsList;
    }

}
