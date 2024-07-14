/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

}
