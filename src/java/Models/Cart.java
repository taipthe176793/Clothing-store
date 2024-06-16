/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

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
        List<CartDetails> items = new ArrayList<>();
        if (txt != null && txt.length() > 0) {
            String[] s = txt.split("/");
            for (String i : s) {
                String[] item = i.split(":");
                int variantId = Integer.parseInt(item[0]);
                int quantity = Integer.parseInt(item[1]);
                CartDetails cartDetail = new CartDetails();
                cartDetail.setProductVariantId(variantId);
                cartDetail.setQuantity(quantity);
                items.add(cartDetail);
            }
            setCartDetailsList(items);
        }
    }

}
