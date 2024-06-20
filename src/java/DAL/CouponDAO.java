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
import java.time.Instant;
import java.util.ArrayList;
import java.util.Date;
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

    public Coupon getCouponByCode(String couponCode) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Coupon coupon = null;

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

                    coupon = new Coupon();

                    coupon.setCouponId(rs.getInt("coupon_id"));
                    coupon.setCode(rs.getString("code"));
                    coupon.setDescription(rs.getString("description"));
                    coupon.setDiscount(rs.getInt("discount"));
                    coupon.setExpiresAt(rs.getDate("expires_at"));
                    coupon.setStartAt(rs.getDate("starts_at"));
                    coupon.setQuantity(rs.getInt("quantity"));

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
        return coupon;
    }

    public boolean checkCouponExpiration(Coupon coupon) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean valid = false;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM [dbo].[coupon] WHERE [coupon_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, coupon.getCouponId());

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                if (rs.next()) {

                    coupon = new Coupon();
                    Date today = new Date();

                    coupon.setExpiresAt(rs.getDate("expires_at"));
                    if (coupon.getExpiresAt().after(today)) {
                        valid = true;
                    }

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
        return valid;

    }

    public boolean checkUsedCoupon(int userId, int couponId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean valid = false;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT *\n"
                        + "  FROM [dbo].[coupon_history]\n"
                        + "  WHERE [customer_id] = ? AND [coupon_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, userId);
                stm.setInt(2, couponId);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                if (rs.next()) {
                    valid = true;
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
        return valid;
    }

}
