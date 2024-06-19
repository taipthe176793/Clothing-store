/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAL;

import Models.CartItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class CartItemDAO extends DBContext {

    public List<CartItem> getCartItems(int customerId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<CartItem> cartItems = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT [cart_item_id]\n"
                        + "      ,[customer_id]\n"
                        + "      ,[variant_id]\n"
                        + "      ,[quantity]\n"
                        + "  FROM [dbo].[cart_item]\n"
                        + "  WHERE [customer_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, customerId);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setCustomerId(customerId);
                    item.setCartItemId(rs.getInt("cart_item_id"));
                    item.setProductVariantId(rs.getInt("variant_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    cartItems.add(item);
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
        return cartItems;
    }

    public void updateCartItem(CartItem item) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "UPDATE [dbo].[cart_item]\n"
                        + "   SET [variant_id] = ?\n"
                        + "      ,[quantity] = ?\n"
                        + " WHERE [cart_item_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, item.getProductVariantId());
                stm.setInt(2, item.getQuantity());
                stm.setInt(3, item.getCartItemId());

                stm.executeUpdate();

            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

    public void addNewCartItem(int customerId, CartItem item) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "INSERT INTO [dbo].[cart_item]\n"
                        + "           ([customer_id]\n"
                        + "           ,[variant_id]\n"
                        + "           ,[quantity])\n"
                        + "     VALUES\n"
                        + "           ( ?, ?, ?)";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, customerId);
                stm.setInt(2, item.getProductVariantId());
                stm.setInt(3, item.getQuantity());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }

    }

    public int getCartItemId(CartItem item) throws SQLException {
        int id = 0;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT [cart_item_id]\n"
                        + "  FROM [dbo].[cart_item]\n"
                        + "  WHERE [customer_id] = ?\n"
                        + "  AND [variant_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, item.getCustomerId());
                stm.setInt(2, item.getProductVariantId());

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                if (rs.next()) {
                    id = rs.getInt("cart_item_id");
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
        return id;
    }

    public void updateCartToDatabase(int customerId, List<CartItem> cartItems) throws SQLException {
        CartItemDAO cdDAO = new CartItemDAO();
        for (CartItem cd : cartItems) {
            if (cd.getCartItemId() != 0) {
                cdDAO.updateCartItem(cd);
            } else {
                cdDAO.addNewCartItem(customerId, cd);
            }
        }
    }

    public void deleteCustomerCartItem(int accountId, int cartItemId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "DELETE FROM [dbo].[cart_item]\n"
                        + "      WHERE [customer_id] = ?\n"
                        + "	  AND [cart_item_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, accountId);
                stm.setInt(2, cartItemId);

                stm.executeUpdate();

            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

    public void updateCustomerCartItem(int accountId, int cartItemId, int updateQuantity) throws SQLException {

        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "UPDATE [dbo].[cart_item]\n"
                        + "   SET [quantity] = ?\n"
                        + " WHERE [customer_id] = ? AND [cart_item_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, updateQuantity);
                stm.setInt(2, accountId);
                stm.setInt(3, cartItemId);

                stm.executeUpdate();

            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }

    }

}
