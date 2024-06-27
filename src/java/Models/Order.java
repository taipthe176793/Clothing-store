/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class Order {

    private int orderId;
    private int customerId;
    private int totalAmount;
    private int discount;
    private boolean isPaid;
    private Timestamp createdAt;
    private String status;
    private String trackingCode;
    private int addressId;
    private String email;
    private String fullname;
    private String phone;
    List<OrderDetails> listOrderDetails = new ArrayList<>();

    public Order() {
    }

    public Order(int customerId, int totalAmount, int discount, boolean isPaid, Timestamp createdAt, String status, String trackingCode, int addressId, String email, String fullname, String phone) {
        this.customerId = customerId;
        this.totalAmount = totalAmount;
        this.discount = discount;
        this.isPaid = isPaid;
        this.createdAt = createdAt;
        this.status = status;
        this.trackingCode = trackingCode;
        this.addressId = addressId;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
    }

    public Order(int orderId, int customerId, int totalAmount, int discount, boolean isPaid, Timestamp createdAt, String status, String trackingCode, int addressId, String email, String fullname, String phone) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.totalAmount = totalAmount;
        this.discount = discount;
        this.isPaid = isPaid;
        this.createdAt = createdAt;
        this.status = status;
        this.trackingCode = trackingCode;
        this.addressId = addressId;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(int totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public boolean isIsPaid() {
        return isPaid;
    }

    public void setIsPaid(boolean isPaid) {
        this.isPaid = isPaid;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getStatus() {
        return status;
    }

    public List<OrderDetails> getListOrderDetails() {
        return listOrderDetails;
    }

    public void setListOrderDetails(List<OrderDetails> listOrderDetails) {
        this.listOrderDetails = listOrderDetails;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTrackingCode() {
        return trackingCode;
    }

    public void setTrackingCode(String trackingCode) {
        this.trackingCode = trackingCode;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
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

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", customerId=" + customerId + ", totalAmount=" + totalAmount + ", discount=" + discount + ", isPaid=" + isPaid + ", createdAt=" + createdAt + ", status=" + status + ", trackingCode=" + trackingCode + ", addressId=" + addressId + ", email=" + email + ", fullname=" + fullname + ", phone=" + phone + ", listOrderDetails=" + listOrderDetails + '}';
    }

}
