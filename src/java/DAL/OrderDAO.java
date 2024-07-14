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
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

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

    public List<Order> getUserOrders(int customerId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Order> orderList = new ArrayList<>();
        try {
            con = connect;

            if (con != null) {
                String sql = "SELECT *\n"
                        + "  FROM [dbo].[order]\n"
                        + "  WHERE [customer_id] = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, customerId);
                rs = stm.executeQuery();
                while (rs.next()) {

                    Order c = new Order();

                    c.setOrderId(rs.getInt("order_id"));
                    c.setCustomerId(rs.getInt("customer_id"));
                    c.setTotalAmount(rs.getDouble("total_amount"));
                    c.setDiscount(rs.getDouble("discount"));
                    c.setIsPaid(rs.getBoolean("is_paid"));
                    c.setStatus(rs.getString("status"));
                    c.setTrackingCode(rs.getString("tracking_code"));
                    c.setEmail(rs.getString("email"));
                    c.setFullname(rs.getString("fullname"));
                    c.setPhone(rs.getString("phone"));
                    c.setDeliveryAddress(rs.getString("delivery_address"));
                    c.setCreatedAt(rs.getDate("created_at"));

                    orderList.add(c);

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
        return orderList;
    }
    

}
