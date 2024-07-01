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

}
