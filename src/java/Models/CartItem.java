/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author admin
 */
public class CartItem {
    private int cartItemId;
    private int customerId;
    private int productVariantId;
    private int quantity;

    public CartItem() {
    }

    public CartItem(int cartItemId, int customerId, int productVariantId, int quantity) {
        this.cartItemId = cartItemId;
        this.customerId = customerId;
        this.productVariantId = productVariantId;
        this.quantity = quantity;
    }

    public int getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(int cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(int productVariantId) {
        this.productVariantId = productVariantId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "CartDetails{" + "cartItemId=" + cartItemId + ", customerId=" + customerId + ", productVariantId=" + productVariantId + ", quantity=" + quantity + '}';
    }

    
    
}
