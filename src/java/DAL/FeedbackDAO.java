package DAL;

import Models.Feedback;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO extends DBContext {

    public List<Feedback> getFeedbacksByProductId(int productId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Feedback> feedbackList = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT f.*,a.fullname FROM feedback f join account a on f.customer_id = a.account_id WHERE product_id = ?  ";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);

                rs = stm.executeQuery();
                while (rs.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setFeedbackId(rs.getInt("feedback_id"));
                    feedback.setCustomerId(rs.getInt("customer_id"));
                    feedback.setProductId(rs.getInt("product_id"));
                    feedback.setComment(rs.getString("comment"));
                    feedback.setRating(rs.getDouble("rating"));
                    feedback.setCreatedAt(rs.getDate("created_at"));
                    feedback.setUsername(rs.getString("fullname"));
                    feedback.setIsDeleted(rs.getBoolean("is_deleted"));

                    feedbackList.add(feedback);
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
        return feedbackList;
    }

    public Feedback getFeedbackByCustomerIdAndProductId(int customerId, int productId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Feedback feedback = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT f.*, a.username FROM feedback f JOIN account a ON f.customer_id = a.account_id WHERE customer_id = ? AND product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, customerId);
                stm.setInt(2, productId);

                rs = stm.executeQuery();
                if (rs.next()) {
                    feedback = new Feedback();
                    feedback.setFeedbackId(rs.getInt("feedback_id"));
                    feedback.setCustomerId(rs.getInt("customer_id"));
                    feedback.setProductId(rs.getInt("product_id"));
                    feedback.setComment(rs.getString("comment"));
                    feedback.setRating(rs.getDouble("rating"));
                    feedback.setCreatedAt(rs.getDate("created_at"));
                    feedback.setUsername(rs.getString("username"));
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
        return feedback;
    }

    public boolean hasCustomerGivenFeedback(int customerId, int productId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        boolean hasFeedback = false;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT COUNT(*) AS count FROM feedback WHERE customer_id = ? AND product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, customerId);
                stm.setInt(2, productId);

                rs = stm.executeQuery();
                if (rs.next()) {
                    int count = rs.getInt("count");
                    hasFeedback = (count > 0);
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

        return hasFeedback;
    }

    public List<Feedback> getAllFeedbacks() throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Feedback> feedbackList = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT f.*, a.fullname "
                        + "FROM feedback f "
                        + "JOIN account a ON f.customer_id = a.account_id";
                stm = con.prepareStatement(sql);

                rs = stm.executeQuery();
                while (rs.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setFeedbackId(rs.getInt("feedback_id"));
                    feedback.setCustomerId(rs.getInt("customer_id"));
                    feedback.setProductId(rs.getInt("product_id"));
                    feedback.setComment(rs.getString("comment"));
                    feedback.setRating(rs.getDouble("rating"));
                    feedback.setCreatedAt(rs.getDate("created_at"));
                    feedback.setUsername(rs.getString("fullname"));
                    feedback.setIsDeleted(rs.getBoolean("is_deleted"));
                    feedback.setIsReported(rs.getBoolean("is_reported"));

                    feedbackList.add(feedback);
                }
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return feedbackList;
    }

    public List<Feedback> getReportedFeedbacks() throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Feedback> feedbackList = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT f.*, a.username FROM feedback f join account a on f.customer_id = a.account_id\n"
                        + "WHERE is_reported = 1";

                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setFeedbackId(rs.getInt("feedback_id"));
                    feedback.setCustomerId(rs.getInt("customer_id"));
                    feedback.setUsername(rs.getString("username"));
                    feedback.setProductId(rs.getInt("product_id"));
                    feedback.setComment(rs.getString("comment"));
                    feedback.setRating(rs.getDouble("rating"));
                    feedback.setIsDeleted(rs.getBoolean("is_deleted"));
                    feedback.setCreatedAt(rs.getDate("created_at"));
                    feedback.setIsReported(rs.getBoolean("is_reported"));
                    feedbackList.add(feedback);
                }
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stm != null) {
                    stm.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return feedbackList;
    }

    public void updateFeedbackStatus(int feedbackId, boolean isHidden) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "UPDATE feedback SET is_deleted = ?, is_reported = 0 WHERE feedback_id = ?";
                stm = con.prepareStatement(sql);
                stm.setBoolean(1, isHidden);
                stm.setInt(2, feedbackId);

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }

    public boolean saveFeedback(Feedback feedback) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        boolean result = false;

        try {
            con = connect;
            if (con != null) {
                String sql = "INSERT INTO feedback (customer_id, product_id, comment, rating, is_deleted, created_at, is_reported) VALUES (?, ?, ?, ?, ?, GETDATE(), ?)";
                stm = con.prepareStatement(sql);
                stm.setInt(1, feedback.getCustomerId());
                stm.setInt(2, feedback.getProductId());
                stm.setString(3, feedback.getComment());
                stm.setDouble(4, feedback.getRating());
                stm.setBoolean(5, feedback.isIsDeleted());
                stm.setBoolean(6, feedback.isIsReported());

                result = stm.executeUpdate() > 0;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
        return result;
    }

    public Feedback getFeedbackById(int feedbackId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Feedback feedback = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT * FROM feedback WHERE feedback_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, feedbackId);

                rs = stm.executeQuery();
                if (rs.next()) {
                    feedback = new Feedback();
                    feedback.setFeedbackId(rs.getInt("feedback_id"));
                    feedback.setCustomerId(rs.getInt("customer_id"));
                    feedback.setProductId(rs.getInt("product_id"));
                    feedback.setComment(rs.getString("comment"));
                    feedback.setRating(rs.getDouble("rating"));
                    feedback.setCreatedAt(rs.getDate("created_at"));
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
        return feedback;
    }

    public void updateFeedback(Feedback feedback) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "UPDATE feedback SET comment = ?, rating = ?, created_at = ? WHERE feedback_id = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, feedback.getComment());
                stm.setDouble(2, feedback.getRating());
                stm.setDate(3, new java.sql.Date(feedback.getCreatedAt().getTime()));
                stm.setInt(4, feedback.getFeedbackId());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

    public void cancelReport(int feedbackId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "UPDATE feedback SET is_reported = 0 WHERE feedback_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, feedbackId);

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

    public void reportFeedback(int feedbackId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "UPDATE feedback SET is_reported = 1 WHERE feedback_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, feedbackId);

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }
    }

    public void deleteCustomerFeedbacksForProduct(int productId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "DELETE FROM feedback WHERE customer_id IS NOT NULL AND product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);
                stm.executeUpdate();
            }
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
            } finally {

            }
        }
    }

    public double getAverageRating(int productId) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        double averageRating = 0;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT AVG(rating) AS avg_rating FROM feedback WHERE product_id = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);

                rs = stm.executeQuery();

                if (rs.next()) {
                    averageRating = rs.getDouble("avg_rating");
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
        return averageRating;
    }

    public List<Feedback> getFeedbacksByProductIdAndRating(int productId, int starFilter) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<Feedback> feedbackList = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT f.*, a.username FROM feedback f JOIN account a ON f.customer_id = a.account_id WHERE product_id = ? AND rating = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);
                stm.setInt(2, starFilter);

                rs = stm.executeQuery();
                while (rs.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setFeedbackId(rs.getInt("feedback_id"));
                    feedback.setCustomerId(rs.getInt("customer_id"));
                    feedback.setProductId(rs.getInt("product_id"));
                    feedback.setComment(rs.getString("comment"));
                    feedback.setRating(rs.getDouble("rating"));
                    feedback.setCreatedAt(rs.getDate("created_at"));
                    feedback.setUsername(rs.getString("username"));
                    feedback.setIsDeleted(rs.getBoolean("is_deleted"));

                    feedbackList.add(feedback);
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
        return feedbackList;
    }

    public List<Feedback> searchFeedbacksByProduct(String productName) throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Feedback> feedbackList = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT f.*, a.username, p.name as product_name FROM feedback f "
                        + "JOIN account a ON f.customer_id = a.account_id "
                        + "JOIN product p ON f.product_id = p.product_id "
                        + "WHERE p.name LIKE ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + productName + "%");

                rs = stm.executeQuery();
                while (rs.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setFeedbackId(rs.getInt("feedback_id"));
                    feedback.setCustomerId(rs.getInt("customer_id"));
                    feedback.setProductId(rs.getInt("product_id"));
                    feedback.setComment(rs.getString("comment"));
                    feedback.setRating(rs.getDouble("rating"));
                    feedback.setCreatedAt(rs.getDate("created_at"));
                    feedback.setUsername(rs.getString("username"));
                    feedback.setIsDeleted(rs.getBoolean("is_deleted"));

                    feedbackList.add(feedback);
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
        return feedbackList;
    }

    public List<Feedback> getFeedbacksSortedByDateDescending() throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Feedback> feedbackList = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT f.*, a.username, p.name as product_name FROM feedback f "
                        + "JOIN account a ON f.customer_id = a.account_id "
                        + "JOIN product p ON f.product_id = p.product_id "
                        + "ORDER BY f.created_at DESC";
                stm = con.prepareStatement(sql);

                rs = stm.executeQuery();
                while (rs.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setFeedbackId(rs.getInt("feedback_id"));
                    feedback.setCustomerId(rs.getInt("customer_id"));
                    feedback.setProductId(rs.getInt("product_id"));
                    feedback.setComment(rs.getString("comment"));
                    feedback.setRating(rs.getDouble("rating"));
                    feedback.setCreatedAt(rs.getDate("created_at"));
                    feedback.setUsername(rs.getString("username"));
                    feedback.setIsDeleted(rs.getBoolean("is_deleted"));

                    feedbackList.add(feedback);
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
        return feedbackList;
    }

    public List<Feedback> getFeedbacksSortedByDateAscending() throws SQLException, ClassNotFoundException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Feedback> feedbackList = new ArrayList<>();

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT f.*, a.username, p.name as product_name FROM feedback f "
                        + "JOIN account a ON f.customer_id = a.account_id "
                        + "JOIN product p ON f.product_id = p.product_id "
                        + "ORDER BY f.created_at ASC";
                stm = con.prepareStatement(sql);

                rs = stm.executeQuery();
                while (rs.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setFeedbackId(rs.getInt("feedback_id"));
                    feedback.setCustomerId(rs.getInt("customer_id"));
                    feedback.setProductId(rs.getInt("product_id"));
                    feedback.setComment(rs.getString("comment"));
                    feedback.setRating(rs.getDouble("rating"));
                    feedback.setCreatedAt(rs.getDate("created_at"));
                    feedback.setUsername(rs.getString("username"));
                    feedback.setIsDeleted(rs.getBoolean("is_deleted"));

                    feedbackList.add(feedback);
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
        return feedbackList;
    }

    public boolean checkIfCustomerPurchasedProduct(int customerId, int productId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = connect;
            if (con != null) {
                String sql = "SELECT od.order_id FROM [order] od\n"
                        + "JOIN order_detail o\n"
                        + "ON od.order_id = o.order_id\n"
                        + "JOIN product_variants v \n"
                        + "ON o.product_variant_id = v.product_variant_id\n"
                        + "JOIN product p ON v.product_id = p.product_id\n"
                        + "JOIN account a ON od.customer_id = a.account_id\n"
                        + "WHERE a.account_id = ?\n"
                        + "AND p.product_id = ? AND a.role_id != 2";
                stm = con.prepareStatement(sql);
                stm.setInt(1, customerId);
                stm.setInt(2, productId);
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

}
