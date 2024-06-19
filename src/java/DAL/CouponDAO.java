/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Coupon;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class CouponDAO extends DBContext {

    public List<Coupon> getAllCoupons()
            throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Coupon> couponList = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[coupon]";
                //3. Create Statement
                stm = con.prepareStatement(sql);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {

                    Coupon c = new Coupon();

                    c.setCouponId(rs.getInt("coupon_id"));
                    c.setCode(rs.getString("code"));
                    c.setDescription(rs.getString("description"));
                    c.setDiscount(rs.getInt("discount"));
                    c.setExpiresAt(rs.getDate("expires_at"));
                    c.setStartAt(rs.getDate("starts_at"));
                    c.setQuantity(rs.getInt("quantity"));

                    couponList.add(c);

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
        return couponList;
    }
    
    public void addCoupon(Coupon coupon) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "INSERT INTO coupon (code, description, discount, expires_at, starts_at, quantity) VALUES (?, ?, ?, ?, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, coupon.getCode());
                stm.setString(2, coupon.getDescription());
                stm.setInt(3, coupon.getDiscount());
                stm.setDate(4, new java.sql.Date(coupon.getExpiresAt().getTime()));
                stm.setDate(5, new java.sql.Date(coupon.getStartAt().getTime()));
                stm.setInt(6, coupon.getQuantity());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }

    public boolean checkCouponExisted(String code) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT * FROM [dbo].[coupon] WHERE [code] = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, code);

                rs = stm.executeQuery();
                return rs.next();
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

    public void updateCoupon(Coupon coupon) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        String info = coupon.toString();
        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "UPDATE [dbo].[coupon]\n"
                        + "   SET [code] = ? \n"
                        + "      ,[description] = ? \n"
                        + "      ,[discount] = ? \n"
                        + "      ,[expires_at] = ? \n"
                        + "      ,[starts_at] = ? \n"
                        + "      ,[quantity] = ? \n"
                        + " WHERE [coupon_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setString(1, coupon.getCode());
                stm.setString(2, coupon.getDescription());
                stm.setInt(3, coupon.getDiscount());
                stm.setDate(4, new java.sql.Date(coupon.getExpiresAt().getTime()));
                stm.setDate(5, new java.sql.Date(coupon.getStartAt().getTime()));
                stm.setInt(6, coupon.getQuantity());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }

    }
    
}
