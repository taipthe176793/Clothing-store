/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author admin
 */
public class ProductVariant {
    
    private int productVariantId;
    private int productId;
    private String color;
    private String size;
    private int quantity;

    public ProductVariant() {
    }

    public ProductVariant(int productId, String color, String size, int quantity) {
        this.productId = productId;
        this.color = color;
        this.size = size;
        this.quantity = quantity;
    }
    
    public ProductVariant(int productVariantId, int productId, String color, String size, int quantity) {
        this.productVariantId = productVariantId;
        this.productId = productId;
        this.color = color;
        this.size = size;
        this.quantity = quantity;
    }

    public int getProductVariantId() {
        return productVariantId;
    }

    public void setProductVariantId(int productVariantId) {
        this.productVariantId = productVariantId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public int getQuantity() {
        return quantity;
    }

    @Override
    public String toString() {
        return "ProductVariant{" + "productVariantId=" + productVariantId + ", productId=" + productId + ", color=" + color + ", size=" + size + ", quantity=" + quantity + '}';
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
    
}
