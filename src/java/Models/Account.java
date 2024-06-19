/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import DAL.ProductVariantDAO;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author admin
 */
public class Account {

    private int accountId;
    private String username;
    private String password;
    private int roleId;
    private String email;
    private String fullname;
    private String phone;
    private List<CustomerAddress> addresses;
    private List<CartItem> cartItems = new ArrayList<>();
    private Map<Integer, Integer> wishlist;

    public Account(int accountId, String username, String password, int roleId, String email, String fullname, String phone) {
        this.accountId = accountId;
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
    }



    public Account(String username, String password, int roleId, String email, String fullname, String phone) {
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
    }

    public Account(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public Account(int accountId, String username, String password, int roleId,
            String email, String fullname, String phone,
            List<CustomerAddress> addresses, List<CartItem> cartItems) {
        this.accountId = accountId;
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
        this.addresses = addresses;
        this.cartItems = cartItems;
    }

    public Account(int accountId, String username, String password, int roleId, String email, String fullname, String phone, List<CustomerAddress> addresses, Map<Integer, Integer> wishlist) {
        this.accountId = accountId;
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
        this.addresses = addresses;
        this.wishlist = wishlist;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getUsername() {
        return username;
    }

    public List<CustomerAddress> getAddresses() {
        return addresses;
    }

    public void setAddresses(List<CustomerAddress> addresses) {
        this.addresses = addresses;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public List<CartItem> getCartItems() {
        return cartItems;
    }

    public void setCartItems(List<CartItem> cartItems) {
        this.cartItems = cartItems;
    }

    @Override
    public String toString() {
        return "Account{" + "accountId=" + accountId + ", username=" + username + ", password=" + password + ", roleId=" + roleId + ", email=" + email + ", fullname=" + fullname + ", phone=" + phone + ", addresses=" + addresses + '}';
    }

    public void setCartFromCookie(String txt) {
        this.getCartItems().clear();
        if (txt != null && txt.length() > 0) {
            String[] s = txt.split("/");
            for (String i : s) {
                String[] item = i.split(":");
                int variantId = Integer.parseInt(item[0]);
                int quantity = Integer.parseInt(item[1]);
                CartItem cartDetail = new CartItem();
                cartDetail.setProductVariantId(variantId);
                cartDetail.setQuantity(quantity);
                this.getCartItems().add(cartDetail);
            }
        }
    }

    public String cartToCookieValue() {
        String txt = "";
        for (CartItem item : this.getCartItems()) {
            if (txt.isBlank()) {
                txt = item.getProductVariantId() + ":" + item.getQuantity();
            } else {
                txt += "/" + item.getProductVariantId() + ":" + item.getQuantity();
            }
        }
        return txt;
    }

    public static void mergeCart(Account customer, List<CartItem> cookieCart) throws SQLException {

        if (cookieCart.isEmpty()) {
            return;
        }

        for (CartItem cookieItem : cookieCart) {
            boolean itemExists = false;
            ProductVariantDAO pvDAO = new ProductVariantDAO();
            ProductVariant pv = pvDAO.findProductVariantById(cookieItem.getProductVariantId());

            for (CartItem cartItem : customer.getCartItems()) {
                if (cartItem.getProductVariantId() == cookieItem.getProductVariantId()) {
                    cartItem.setQuantity((cartItem.getQuantity() + cookieItem.getQuantity())
                            > pv.getQuantity() ? pv.getQuantity()
                            : (cartItem.getQuantity() + cookieItem.getQuantity()));
                    itemExists = true;
                    break;
                }
            }

            if (!itemExists) {
                customer.getCartItems().add(cookieItem);
            }
        }
    }

       public Account() {
        wishlist = new HashMap<>();
    }
       

    public Map<Integer, Integer> getWishlist() {
        return wishlist;
    }

    public void setWishlist(Map<Integer, Integer> wishlist) {
        this.wishlist = wishlist;
    }

    public void addToWishlist(int productId) {
        wishlist.put(productId, productId);
    }

    public void removeFromWishlist(int productId) {
        wishlist.remove(productId);
    }

    public boolean isInWishlist(int productId) {
        return wishlist.containsKey(productId);
    }

}
