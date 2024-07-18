/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;

/**
 *
 * @author admin
 */
public class Coupon {
    private int couponId;
    private String code;
    private String description;
    private int discount;
    private Date expiresAt;
    private Date startAt;
    private int quantity;
    private Date usedAt;

    public Coupon() {
    }

    public Coupon(String code, String description, int discount, Date expiresAt, Date startAt, int quantity) {
        this.code = code;
        this.description = description;
        this.discount = discount;
        this.expiresAt = expiresAt;
        this.startAt = startAt;
        this.quantity = quantity;
    }
    
    
    public Coupon(int couponId, String code, String description, int discount, Date expiresAt, Date startAt, int quantity) {
        this.couponId = couponId;
        this.code = code;
        this.description = description;
        this.discount = discount;
        this.expiresAt = expiresAt;
        this.startAt = startAt;
        this.quantity = quantity;
    }

    public int getCouponId() {
        return couponId;
    }

    public void setCouponId(int couponId) {
        this.couponId = couponId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public Date getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(Date expiresAt) {
        this.expiresAt = expiresAt;
    }

    public Date getStartAt() {
        return startAt;
    }

    public void setStartAt(Date startAt) {
        this.startAt = startAt;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Coupon{" + "couponId=" + couponId + ", code=" + code + ", description=" + description + ", discount=" + discount + ", expiresAt=" + expiresAt + ", startAt=" + startAt + ", quantity=" + quantity + '}';
    }

    public Date getUsedAt() {
        return usedAt;
    }

    public void setUsedAt(Date usedAt) {
        this.usedAt = usedAt;
    }
}
