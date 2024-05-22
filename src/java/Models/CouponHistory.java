/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Timestamp;

/**
 *
 * @author caoqu
 */
public class CouponHistory {
    private int couponId;
    private int customerId;
    private Timestamp usedAt;

    public CouponHistory() {
    }

    public CouponHistory(int couponId, int customerId, Timestamp usedAt) {
        this.couponId = couponId;
        this.customerId = customerId;
        this.usedAt = usedAt;
    }

    public int getCouponId() {
        return couponId;
    }

    public void setCouponId(int couponId) {
        this.couponId = couponId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public Timestamp getUsedAt() {
        return usedAt;
    }

    public void setUsedAt(Timestamp usedAt) {
        this.usedAt = usedAt;
    }

    @Override
    public String toString() {
        return "CouponHistory{" + "couponId=" + couponId + ", customerId=" + customerId + ", usedAt=" + usedAt + '}';
    }
    
    
}
