/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author admin
 */
public class CartDetails {
    private int cartDetailId;
    private int cartId;
    private int productVariantId;
    private int quantity;

    public CartDetails() {
    }

    public CartDetails(int cartDetailId, int cartId, int productVariantId, int quantity) {
        this.cartDetailId = cartDetailId;
        this.cartId = cartId;
        this.productVariantId = productVariantId;
        this.quantity = quantity;
    }

    public int getCartDetailId() {
        return cartDetailId;
    }

    public void setCartDetailId(int cartDetailId) {
        this.cartDetailId = cartDetailId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
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
        return "CartDetails{" + "cartDetailId=" + cartDetailId + ", cartId=" + cartId + ", productVariantId=" + productVariantId + ", quantity=" + quantity + '}';
    }

    
    
}
