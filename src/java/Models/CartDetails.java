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

    public CartDetails() {
    }

    public CartDetails(int cartDetailId, int cartId) {
        this.cartDetailId = cartDetailId;
        this.cartId = cartId;
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

    @Override
    public String toString() {
        return "CartDetails{" + "cartDetailId=" + cartDetailId + ", cartId=" + cartId + '}';
    }
    
    
}
