/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.Cart;
import Models.CartDetails;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author admin
 */
public class CartDAO extends DBContext {

    public Cart getCartByUserId(int accountId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        Cart cart = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT [cart_id]\n"
                        + "      ,[customer_id]\n"
                        + "  FROM [dbo].[cart]\n"
                        + "  WHERE [customer_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, accountId);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                if (rs.next()) {

                    cart = new Cart();
                    cart.setCartId(Integer.parseInt(rs.getString("cart_id")));
                    cart.setCustomerId(accountId);

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
        if (cart != null) {
            CartDetailsDAO cdDAO = new CartDetailsDAO();
            cart.setCartDetailsList(cdDAO.getCartDetails(cart.getCartId()));
        }

        return cart;
    }

    public void updateCartToDatabase(Cart cart) throws SQLException {
        CartDetailsDAO cdDAO = new CartDetailsDAO();
        for (CartDetails cd : cart.getCartDetailsList()) {
            if (cd.getCartDetailId() != 0) {
                cdDAO.updateCartDetails(cd);
            } else {
                cdDAO.addNewCartDetails(cart, cd);
            }
        }
    }

    public void insertCartByAccountId(int accountId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "INSERT INTO [dbo].[cart]\n"
                        + "           ([customer_id])\n"
                        + "     VALUES\n"
                        + "           (?)";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, accountId);

                //4. Excute Query
                stm.executeUpdate();

            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

}
