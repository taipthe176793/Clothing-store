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
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT * FROM feedback WHERE product_id = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, productId);

                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    Feedback feedback = new Feedback();
                    feedback.setFeedbackId(rs.getInt("feedback_id"));
                    feedback.setCustomerId(rs.getInt("customer_id"));
                    feedback.setProductId(rs.getInt("product_id"));
                    feedback.setComment(rs.getString("comment"));
                    feedback.setRating(rs.getDouble("rating"));
                    feedback.setCreatedAt(rs.getDate("created_at"));

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
            if (con != null) {
                con.close();
            }
        }
        return feedbackList;
    }
}
