/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author admin
 */
public class OrderDAO extends DBContext {

    public boolean isTrackingCodeExist(String trackingCode) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT [tracking_code]\n"
                        + "  FROM [dbo].[order]\n"
                        + "  WHERE [tracking_code] = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, trackingCode);

                rs = stm.executeQuery();
                if (rs.next()) {
                    return true;
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
        return false;
    }

    public int insertOrder(Order order) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "INSERT INTO [dbo].[order] \n"
                        + "([customer_id], [total_amount], [discount], [is_paid], [status], "
                        + "[tracking_code], [email], [fullname], [phone], [delivery_address], [created_at]) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
                stm = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                stm.setInt(1, order.getCustomerId());
                stm.setDouble(2, order.getTotalAmount());
                stm.setDouble(3, order.getDiscount());
                stm.setBoolean(4, order.isIsPaid());
                stm.setString(5, order.getStatus());
                stm.setString(6, order.getTrackingCode());
                stm.setString(7, order.getEmail());
                stm.setString(8, order.getFullname());
                stm.setString(9, order.getPhone());
                stm.setString(10, order.getDeliveryAddress());
                stm.executeUpdate();

                rs = stm.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
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
        return -1;
    }

}
