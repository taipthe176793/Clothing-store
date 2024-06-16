/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import DAL.CartDetailsDAO;
import DAL.ProductVariantDAO;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class Cart {

    private int cartId;
    private int customerId;

    public List<CartDetails> getCartDetailsList() {
        return cartDetailsList;
    }

    public void setCartDetailsList(List<CartDetails> cartDetailsList) {
        this.cartDetailsList = cartDetailsList;
    }
    private List<CartDetails> cartDetailsList = new ArrayList<>();

    public Cart() {
    }

    public Cart(int cartId, int customerId) {
        this.cartId = cartId;
        this.customerId = customerId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    @Override
    public String toString() {
        return "Cart{" + "cartId=" + cartId + ", customerId=" + customerId + '}';
    }

    public void setCartFromCookie(String txt) {
        this.cartDetailsList.clear();
        if (txt != null && txt.length() > 0) {
            String[] s = txt.split("/");
            for (String i : s) {
                String[] item = i.split(":");
                int variantId = Integer.parseInt(item[0]);
                int quantity = Integer.parseInt(item[1]);
                CartDetails cartDetail = new CartDetails();
                cartDetail.setProductVariantId(variantId);
                cartDetail.setQuantity(quantity);
                this.cartDetailsList.add(cartDetail);
            }
        }
    }

    public String cartToCookieValue() {
        String txt = "";
        for (CartDetails item : this.cartDetailsList) {
            if (txt.isBlank()) {
                txt = item.getProductVariantId() + ":" + item.getQuantity();
            } else {
                txt += "/" + item.getProductVariantId() + ":" + item.getQuantity();
            }
        }
        return txt;
    }

    public void mergeCart(Cart cart, Cart cookieCart) throws SQLException {

        for (CartDetails cookieItem : cookieCart.getCartDetailsList()) {
            boolean itemExists = false;
            ProductVariantDAO pvDAO = new ProductVariantDAO();
            ProductVariant pv = pvDAO.findProductVariantById(cookieItem.getProductVariantId());

            for (CartDetails cartItem : cart.getCartDetailsList()) {
                if (cartItem.getProductVariantId() == cookieItem.getProductVariantId()) {
                    cartItem.setQuantity((cartItem.getQuantity() + cookieItem.getQuantity())
                            > pv.getQuantity() ? pv.getQuantity()
                            : (cartItem.getQuantity() + cookieItem.getQuantity()));
                    itemExists = true;
                    break;
                }
            }

            if (!itemExists) {
                cart.getCartDetailsList().add(cookieItem);
            }
        }
    }

    public static void main(String[] args) {
        String txt = "2:4/4:3";
        Cart cart = new Cart();
        cart.setCartId(1);
        cart.setCustomerId(1);
        List<CartDetails> items = new ArrayList<>();
        items.add(new CartDetails(1, 1, 2, 5));
        items.add(new CartDetails(2, 1, 5, 2));
        cart.setCartDetailsList(items);
        for (CartDetails cd : cart.getCartDetailsList()) {
            System.out.print(cd.toString() + " /");
        }
        System.out.println("");
        System.out.println("After setCookie");
        cart.setCartFromCookie(txt);
        for (CartDetails cd : cart.getCartDetailsList()) {
            System.out.print(cd.toString() + " /");
        }
    }

}
