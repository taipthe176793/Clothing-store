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
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class CartDetailsDAO extends DBContext {

    public List<CartDetails> getCartDetails(int cartId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        List<CartDetails> items = new ArrayList<>();

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT [cart_detail_id]\n"
                        + "      ,[cart_id]\n"
                        + "      ,[quantity]\n"
                        + "      ,[product_variant_id]\n"
                        + "  FROM [dbo].[cart_detail]\n"
                        + "  WHERE [cart_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, cartId);

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                while (rs.next()) {
                    CartDetails cd = new CartDetails();
                    cd.setCartId(cartId);
                    cd.setCartDetailId(Integer.parseInt(rs.getString("cart_detail_id")));
                    cd.setProductVariantId(Integer.parseInt(rs.getString("product_variant_id")));
                    cd.setQuantity(Integer.parseInt(rs.getString("quantity")));
                    items.add(cd);
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
        return items;
    }

    public void updateCartDetails(CartDetails item) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "UPDATE [dbo].[cart_detail]\n"
                        + "   SET [quantity] = ?\n"
                        + "      ,[product_variant_id] = ?\n"
                        + " WHERE [cart_detail_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, item.getQuantity());
                stm.setInt(2, item.getProductVariantId());
                stm.setInt(3, item.getCartDetailId());

                stm.executeUpdate();

            }
        } finally {
            if (stm != null) {
                stm.close();
            }

        }
    }

    public void addNewCartDetails(Cart cart, CartDetails item) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "INSERT INTO [dbo].[cart_detail]\n"
                        + "           ([cart_id]\n"
                        + "           ,[quantity]\n"
                        + "           ,[product_variant_id])\n"
                        + "     VALUES\n"
                        + "           (?, ?, ?)";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, cart.getCartId());
                stm.setInt(2, item.getQuantity());
                stm.setInt(3, item.getProductVariantId());

                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
        }

    }

    public int getCartDetailId(CartDetails cd) throws SQLException {
        int id = 0;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1. Connect DB
            con = connect;
            if (con != null) {
                //2. Create SQL String
                String sql = "SELECT [cart_detail_id]\n"
                        + "  FROM [dbo].[cart_detail]\n"
                        + "  WHERE [cart_id] = ? \n"
                        + "  AND [product_variant_id] = ?";
                //3. Create Statement
                stm = con.prepareStatement(sql);
                stm.setInt(1, cd.getCartId());
                stm.setInt(2, cd.getProductVariantId());

                //4. Excute Query
                rs = stm.executeQuery();
                //5. Process Result
                if (rs.next()) {
                    id = rs.getInt("cart_detail_id");
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
}
