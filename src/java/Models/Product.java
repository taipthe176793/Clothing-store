/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author admin
 */
public class Product {

    private int productId;
    private String name;
    private String description;
    private int price;
    private String img1;
    private String img2;
    private String img3;
    private int categoryId;
    private boolean isDelete;
    private double rating;

    public Product() {
    }

    public Product(String name, String description, int price, String img1, String img2, String img3, int categoryId, boolean isDelete, double rating) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.img1 = img1;
        this.img2 = img2;
        this.img3 = img3;
        this.categoryId = categoryId;
        this.isDelete = isDelete;
        this.rating = rating;
    }

    public Product(int productId, String name, String description, int price, String img1, String img2, String img3, int categoryId, boolean isDelete, double rating) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.img1 = img1;
        this.img2 = img2;
        this.img3 = img3;
        this.categoryId = categoryId;
        this.isDelete = isDelete;
        this.rating = rating;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getImg1() {
        return img1;
    }

    public void setImg1(String img1) {
        this.img1 = img1;
    }

    public String getImg2() {
        return img2;
    }

    public void setImg2(String img2) {
        this.img2 = img2;
    }

    public String getImg3() {
        return img3;
    }

    public void setImg3(String img3) {
        this.img3 = img3;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public boolean isIsDelete() {
        return isDelete;
    }

    public void setIsDelete(boolean isDelete) {
        this.isDelete = isDelete;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    @Override
    public String toString() {
        return "Product{" + "productId=" + productId + ", name=" + name + ", description=" + description + ", price=" + price + ", img1=" + img1 + ", img2=" + img2 + ", img3=" + img3 + ", categoryId=" + categoryId + ", isDelete=" + isDelete + ", rating=" + rating + '}';
    }

}
