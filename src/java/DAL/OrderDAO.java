/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Controllers.customer.CheckoutServlet;
import Models.Order;
import Models.OrderDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class OrderDAO extends DBContext {

    public boolean isOrderCodeExist(String orderCode) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT [order_code]\n"
                        + "  FROM [dbo].[order]\n"
                        + "  WHERE [order_code] = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, orderCode);

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
                        + "[order_code], [email], [fullname], [phone], [delivery_address], [created_at]) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
                stm = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                stm.setInt(1, order.getCustomerId());
                stm.setDouble(2, order.getTotalAmount());
                stm.setDouble(3, order.getDiscount());
                stm.setBoolean(4, order.isIsPaid());
                stm.setString(5, order.getStatus());
                stm.setString(6, order.getOrderCode());
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
                    c.setOrderCode(rs.getString("order_code"));
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

    public List<Double> getRevenueMonthDataOfYear(int year) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Double> revenues = new ArrayList<>();
        try {
            con = connect;

            if (con != null) {
                String sql = "SELECT \n"
                        + "    MONTH([created_at]) AS [Month],\n"
                        + "    SUM([total_amount]) AS [Revenue]\n"
                        + "FROM [dbo].[order]\n"
                        + "WHERE [is_paid] = 1\n"
                        + "      AND YEAR([created_at]) = ? \n"
                        + "GROUP BY YEAR([created_at]), MONTH([created_at])\n"
                        + "ORDER BY YEAR([created_at]), MONTH([created_at]);";
                stm = con.prepareStatement(sql);
                stm.setInt(1, year);
                rs = stm.executeQuery();

                for (int i = 0; i < 12; i++) {
                    revenues.add(0.0);
                }

                while (rs.next()) {

                    int month = rs.getInt("Month");
                    double revenue = rs.getDouble("Revenue");

                    revenues.set(month - 1, revenue);

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
        return revenues;
    }

    public List<Double> getRevenueDataByMonthOfYear(int month, int year) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Double> revenues = new ArrayList<>();
        try {
            con = connect;

            if (con != null) {
                String sql = "SELECT\n"
                        + "    DAY([created_at]) AS [Day],\n"
                        + "    SUM([total_amount]) AS [Revenue]\n"
                        + "FROM [dbo].[order]\n"
                        + "WHERE [is_paid] = 1\n"
                        + "      AND MONTH([created_at]) = ?\n"
                        + "      AND YEAR([created_at]) = ? \n"
                        + "GROUP BY YEAR([created_at]), MONTH([created_at]), DAY([created_at])\n"
                        + "ORDER BY YEAR([created_at]), MONTH([created_at]), DAY([created_at]);";
                stm = con.prepareStatement(sql);
                stm.setInt(1, month);
                stm.setInt(2, year);
                rs = stm.executeQuery();

                int days = 0;

                if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
                    days = 31;
                } else if (month == 2) {
                    days = (year % 4 == 0 && year % 100 != 0) ? 29 : 28;
                } else {
                    days = 30;
                }

                for (int i = 0; i < days; i++) {
                    revenues.add(0.0);
                }

                while (rs.next()) {

                    int day = rs.getInt("Day");
                    double revenue = rs.getDouble("Revenue");
                    revenues.set(day - 1, revenue);

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
        return revenues;
    }

    public List<Double> getRevenueDataByCategory() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Double> revenues = new ArrayList<>();
        try {
            con = connect;

            if (con != null) {
                String sql = "SELECT c.category_id,\n"
                        + "       c.[name] AS category_name,\n"
                        + "       COALESCE(SUM(od.quantity * p.price), 0) AS total_revenue\n"
                        + "FROM [dbo].[category] c\n"
                        + "LEFT JOIN [dbo].[product] p ON c.category_id = p.category_id\n"
                        + "LEFT JOIN [dbo].[product_variants] pv ON p.product_id = pv.product_id\n"
                        + "LEFT JOIN [dbo].[order_detail] od ON pv.product_variant_id = od.product_variant_id\n"
                        + "LEFT JOIN [dbo].[order] o ON od.order_id = o.order_id\n"
                        + "GROUP BY c.category_id, c.[name]";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();

                while (rs.next()) {
                    double revenue = rs.getDouble("total_revenue");
                    revenues.add(revenue);

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
        return revenues;
    }

    public double getRevenueGrowth() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        double revenueRate = 0;
        try {
            con = connect;

            if (con != null) {
                String sql = "WITH MonthlyRevenue AS (\n"
                        + "    SELECT\n"
                        + "        DATEPART(YEAR, created_at) AS Year,\n"
                        + "        DATEPART(MONTH, created_at) AS Month,\n"
                        + "        SUM(total_amount) AS TotalRevenue\n"
                        + "    FROM [dbo].[order]\n"
                        + "    WHERE is_paid = 1\n"
                        + "    GROUP BY DATEPART(YEAR, created_at), DATEPART(MONTH, created_at)\n"
                        + "),\n"
                        + "CurrentMonth AS (\n"
                        + "    SELECT\n"
                        + "        Year,\n"
                        + "        Month,\n"
                        + "        TotalRevenue\n"
                        + "    FROM MonthlyRevenue\n"
                        + "    WHERE Year = DATEPART(YEAR, GETDATE()) AND Month = DATEPART(MONTH, GETDATE())\n"
                        + "),\n"
                        + "PreviousMonth AS (\n"
                        + "    SELECT\n"
                        + "        Year,\n"
                        + "        Month,\n"
                        + "        TotalRevenue\n"
                        + "    FROM MonthlyRevenue\n"
                        + "    WHERE (Year = DATEPART(YEAR, DATEADD(MONTH, -1, GETDATE())) AND Month = DATEPART(MONTH, DATEADD(MONTH, -1, GETDATE())))\n"
                        + "        OR (Year = DATEPART(YEAR, DATEADD(MONTH, -1, GETDATE())) - 1 AND Month = 12 AND DATEPART(MONTH, GETDATE()) = 1)\n"
                        + ")\n"
                        + "SELECT\n"
                        + "    cm.Year AS CurrentYear,\n"
                        + "    cm.Month AS CurrentMonth,\n"
                        + "    cm.TotalRevenue AS CurrentMonthRevenue,\n"
                        + "    pm.Year AS PreviousYear,\n"
                        + "    pm.Month AS PreviousMonth,\n"
                        + "    pm.TotalRevenue AS PreviousMonthRevenue,\n"
                        + "    CASE\n"
                        + "        WHEN pm.TotalRevenue = 0 THEN NULL\n"
                        + "        ELSE ((cm.TotalRevenue - pm.TotalRevenue) / pm.TotalRevenue) * 100\n"
                        + "    END AS RevenueGrowthPercentage\n"
                        + "FROM CurrentMonth cm\n"
                        + "JOIN PreviousMonth pm ON 1 = 1;";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();

                while (rs.next()) {
                    revenueRate = rs.getDouble("RevenueGrowthPercentage");
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
        return revenueRate;
    }

    public double getTotalSalesThisMonth() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        double sales = 0;
        try {
            con = connect;

            if (con != null) {
                String sql = "  SELECT\n"
                        + "    SUM(total_amount) AS thisMonth\n"
                        + "FROM [dbo].[order]\n"
                        + "WHERE is_paid = 1\n"
                        + "  AND DATEPART(YEAR, created_at) = DATEPART(YEAR, GETDATE())\n"
                        + "  AND DATEPART(MONTH, created_at) = DATEPART(MONTH, GETDATE());";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();

                while (rs.next()) {
                    sales = rs.getDouble("thisMonth");
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
        return sales;
    }

    public int getTotalOrdersThisMonth() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        int orders = 0;
        try {
            con = connect;

            if (con != null) {
                String sql = "SELECT\n"
                        + "    COUNT(order_id) AS ordersThisMonth\n"
                        + "FROM [dbo].[order]\n"
                        + "WHERE is_paid = 1\n"
                        + "  AND DATEPART(YEAR, created_at) = DATEPART(YEAR, GETDATE())\n"
                        + "  AND DATEPART(MONTH, created_at) = DATEPART(MONTH, GETDATE());";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();

                while (rs.next()) {
                    orders = rs.getInt("ordersThisMonth");
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
        return orders;
    }

    public Order getOrderByOrderId(int orderId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        Order order = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT [order_id]\n"
                        + "      ,[customer_id]\n"
                        + "      ,[total_amount]\n"
                        + "      ,[discount]\n"
                        + "      ,[is_paid]\n"
                        + "      ,[status]\n"
                        + "      ,[order_code]\n"
                        + "      ,[email]\n"
                        + "      ,[fullname]\n"
                        + "      ,[phone]\n"
                        + "      ,[delivery_address]\n"
                        + "      ,[created_at]\n"
                        + "  FROM [dbo].[order] WHERE [order_id] = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, orderId);
                rs = stm.executeQuery();

                if (rs.next()) {
                    order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setCustomerId(rs.getInt("customer_id"));
                    order.setTotalAmount(rs.getDouble("total_amount"));
                    order.setDiscount(rs.getDouble("discount"));
                    order.setIsPaid(rs.getBoolean("is_paid"));
                    order.setStatus(rs.getString("status"));
                    order.setOrderCode(rs.getString("order_code"));
                    order.setEmail(rs.getString("email"));
                    order.setFullname(rs.getString("fullname"));
                    order.setPhone(rs.getString("phone"));
                    order.setDeliveryAddress(rs.getString("delivery_address"));
                    order.setCreatedAt(rs.getDate("created_at"));
                    OrderDetailsDAO odDao = new OrderDetailsDAO();
                    order.setListOrderDetails(odDao.getListOrderDetailByOrderId(order.getOrderId()));
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
        return order;
    }

    public int placeOrderWithStockCheck(Order order, List<OrderDetails> orderDetailsList) throws SQLException {
        Connection con = null;
        PreparedStatement checkStockStm = null;
        PreparedStatement updateStockStm = null;
        PreparedStatement insertOrderStm = null;
        PreparedStatement insertOrderDetailsStm = null;
        ResultSet rs = null;
        int orderId = -1;

        try {
            con = connect;
            con.setAutoCommit(false); // Start transaction

            // Insert order
            String insertOrderSql = "INSERT INTO [dbo].[order] ([customer_id], [total_amount], [discount], [is_paid], [status], "
                    + "[order_code], [email], [fullname], [phone], [delivery_address], [created_at]) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
            insertOrderStm = con.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS);
            insertOrderStm.setInt(1, order.getCustomerId());
            insertOrderStm.setDouble(2, order.getTotalAmount());
            insertOrderStm.setDouble(3, order.getDiscount());
            insertOrderStm.setBoolean(4, order.isIsPaid());
            insertOrderStm.setString(5, order.getStatus());
            insertOrderStm.setString(6, order.getOrderCode());
            insertOrderStm.setString(7, order.getEmail());
            insertOrderStm.setString(8, order.getFullname());
            insertOrderStm.setString(9, order.getPhone());
            insertOrderStm.setString(10, order.getDeliveryAddress());
            insertOrderStm.executeUpdate();

            rs = insertOrderStm.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            } else {
                throw new SQLException("Failed to retrieve order ID after insert.");
            }

            // Prepare statements for stock check and update
            String checkStockSql = "SELECT quantity FROM [dbo].[product_variants] WHERE [product_variant_id] = ?";
            String updateStockSql = "UPDATE [dbo].[product_variants] SET [quantity] = [quantity] - ? WHERE [product_variant_id] = ?";
            checkStockStm = con.prepareStatement(checkStockSql);
            updateStockStm = con.prepareStatement(updateStockSql);

            // Prepare statement for inserting order details
            String insertOrderDetailsSql = "INSERT INTO [dbo].[order_detail] ([order_id], [product_variant_id], [quantity]) VALUES (?, ?, ?)";
            insertOrderDetailsStm = con.prepareStatement(insertOrderDetailsSql);

            for (OrderDetails item : orderDetailsList) {
                int variantId = item.getProductVariantId();
                int quantity = item.getQuantity();

                // Check stock
                checkStockStm.setInt(1, variantId);
                rs = checkStockStm.executeQuery();
                if (rs.next()) {
                    int availableQuantity = rs.getInt("quantity");
                    if (availableQuantity < quantity) {
                        throw new SQLException("Insufficient stock for product variant ID: " + variantId);
                    }
                } else {
                    throw new SQLException("Product variant ID: " + variantId + " not found.");
                }

                // Update stock
                updateStockStm.setInt(1, quantity);
                updateStockStm.setInt(2, variantId);
                updateStockStm.executeUpdate();

                // Insert order details
                insertOrderDetailsStm.setInt(1, orderId);
                insertOrderDetailsStm.setInt(2, variantId);
                insertOrderDetailsStm.setInt(3, quantity);
                insertOrderDetailsStm.executeUpdate();
            }

            con.commit();
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            Logger.getLogger(CheckoutServlet.class.getName()).log(Level.SEVERE, null, e);
            return -1;
        } finally {

            if (rs != null) {
                rs.close();
            }
            if (checkStockStm != null) {
                checkStockStm.close();
            }
            if (updateStockStm != null) {
                updateStockStm.close();
            }
            if (insertOrderDetailsStm != null) {
                insertOrderDetailsStm.close();
            }
            if (insertOrderStm != null) {
                insertOrderStm.close();
            }
            if (con != null) {
                con.setAutoCommit(true);
            }
        }

        return orderId;
    }

    public Order getUserOrdersById(int customerId, int orderId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;

            if (con != null) {
                String sql = "SELECT *\n"
                        + "  FROM [dbo].[order]\n"
                        + "  WHERE [customer_id] = ? and order_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, customerId);
                stm.setInt(2, orderId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Order c = new Order();
                    c.setOrderId(rs.getInt("order_id"));
                    c.setCustomerId(rs.getInt("customer_id"));
                    c.setTotalAmount(rs.getDouble("total_amount"));
                    c.setDiscount(rs.getDouble("discount"));
                    c.setIsPaid(rs.getBoolean("is_paid"));
                    c.setStatus(rs.getString("status"));
                    c.setOrderCode(rs.getString("order_code"));
                    c.setEmail(rs.getString("email"));
                    c.setFullname(rs.getString("fullname"));
                    c.setPhone(rs.getString("phone"));
                    c.setDeliveryAddress(rs.getString("delivery_address"));
                    c.setCreatedAt(rs.getDate("created_at"));
                    OrderDetailsDAO orderDetailDao = new OrderDetailsDAO();
                    c.setListOrderDetails(orderDetailDao.getOrderDetailsByOrderId(orderId));
                    return c;
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

    public Order getUserOrdersById(int orderId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;

            if (con != null) {
                String sql = "SELECT *\n"
                        + "  FROM [dbo].[order]\n"
                        + "  WHERE order_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, orderId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Order c = new Order();
                    c.setOrderId(rs.getInt("order_id"));
                    c.setCustomerId(rs.getInt("customer_id"));
                    c.setTotalAmount(rs.getDouble("total_amount"));
                    c.setDiscount(rs.getDouble("discount"));
                    c.setIsPaid(rs.getBoolean("is_paid"));
                    c.setStatus(rs.getString("status"));
                    c.setOrderCode(rs.getString("order_code"));
                    c.setEmail(rs.getString("email"));
                    c.setFullname(rs.getString("fullname"));
                    c.setPhone(rs.getString("phone"));
                    c.setDeliveryAddress(rs.getString("delivery_address"));
                    c.setCreatedAt(rs.getDate("created_at"));
                    OrderDetailsDAO orderDetailDao = new OrderDetailsDAO();
                    c.setListOrderDetails(orderDetailDao.getOrderDetailsByOrderId(orderId));
                    return c;
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

    public List<Order> getUserOrdersByStaffReq() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Order> orderList = new ArrayList<>();
        try {
            con = connect;

            if (con != null) {
                String sql = "SELECT *\n"
                        + "  FROM [dbo].[order] where status = 'Pending'";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Order c = new Order();
                    c.setOrderId(rs.getInt("order_id"));
                    c.setCustomerId(rs.getInt("customer_id"));
                    c.setTotalAmount(rs.getDouble("total_amount"));
                    c.setDiscount(rs.getDouble("discount"));
                    c.setIsPaid(rs.getBoolean("is_paid"));
                    c.setStatus(rs.getString("status"));
                    c.setOrderCode(rs.getString("order_code"));
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

    public List<Order> getUserOrdersByStaff() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Order> orderList = new ArrayList<>();
        try {
            con = connect;

            if (con != null) {
                String sql = "SELECT *\n"
                        + "  FROM [dbo].[order] ";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Order c = new Order();
                    c.setOrderId(rs.getInt("order_id"));
                    c.setCustomerId(rs.getInt("customer_id"));
                    c.setTotalAmount(rs.getDouble("total_amount"));
                    c.setDiscount(rs.getDouble("discount"));
                    c.setIsPaid(rs.getBoolean("is_paid"));
                    c.setStatus(rs.getString("status"));
                    c.setOrderCode(rs.getString("order_code"));
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
    
    public int updateOrderStatus(int orderId, String newStatus) {
        String query = "UPDATE [order] SET status = ? WHERE order_id = ?";
        try (PreparedStatement stmt = connect.prepareStatement(query)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

}
