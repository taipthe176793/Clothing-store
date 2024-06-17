/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author caoqu
 */
public class Wishlist {
    private int wishlist_id; 
    private int customer_id;
    private int product_id;

    public Wishlist() {
    }

    public Wishlist(int wishlist_id, int customer_id, int product_id) {
        this.wishlist_id = wishlist_id;
        this.customer_id = customer_id;
        this.product_id = product_id;
    }

    public int getWishlist_id() {
        return wishlist_id;
    }

    public void setWishlist_id(int wishlist_id) {
        this.wishlist_id = wishlist_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    @Override
    public String toString() {
        return "Wishlist{" + "wishlist_id=" + wishlist_id + ", customer_id=" + customer_id + ", product_id=" + product_id + '}';
    }
    
}
