/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 *
 * @author admin
 */
public class Product {

    private int productId;
    private String name;
    private String description;
    private double price;
    private String img1;
    private String img2;
    private String img3;
    private int categoryId;
    private boolean isDelete;
    private double rating;
    private List<ProductVariant> variantList = new ArrayList<>();

    public List<ProductVariant> getVariantList() {
        return variantList;
    }

    public void setVariantList(List<ProductVariant> variantList) {
        this.variantList = variantList;
    }

    public Product() {
    }

    public Product(String name, String description, double price, String img1, String img2, String img3, int categoryId, boolean isDelete, double rating) {
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

    public Product(int productId, String name, String description, double price, String img1, String img2, String img3, int categoryId, boolean isDelete, double rating) {
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
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

    public List<String> getSortedVariantColors() {
        List<String> colors = new ArrayList<>();
        for (ProductVariant pv : this.getVariantList()) {
            if (!colors.contains(pv.getColor())) {
                colors.add(pv.getColor());
            }
        }
        Collections.sort(colors);
        return colors;
    }

    public List<String> getSortedVariantSizes() {
        List<String> sizes = new ArrayList<>();
        for (ProductVariant pv : this.getVariantList()) {
            if (!sizes.contains(pv.getSize())) {
                sizes.add(pv.getSize());
            }
        }
        Collections.sort(sizes);
        Collections.reverse(sizes);

        if (sizes.contains("XL")) {
            sizes.remove("XL");
            sizes.add("XL");
        }
        return sizes;
    }

    @Override
    public String toString() {
        return "Product{" + "productId=" + productId + ", name=" + name + ", description=" + description + ", price=" + price + ", img1=" + img1 + ", img2=" + img2 + ", img3=" + img3 + ", categoryId=" + categoryId + ", isDelete=" + isDelete + ", rating=" + rating + '}';
    }

}
