/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author admin
 */
public class Order {

    private int orderId;
    private int customerId;
    private double totalAmount;
    private double discount;
    private boolean isPaid;
    private Date createdAt;
    private String status;
    private String orderCode;
    private String email;
    private String fullname;
    private String phone;
    private String deliveryAddress;
    List<OrderDetails> listOrderDetails = new ArrayList<>();

    public Order() {
    }

    public Order(int customerId, int totalAmount, int discount, boolean isPaid, Date createdAt, String status, String orderCode, String email, String fullname, String phone, String deliveryAddress) {
        this.customerId = customerId;
        this.totalAmount = totalAmount;
        this.discount = discount;
        this.isPaid = isPaid;
        this.createdAt = createdAt;
        this.status = status;
        this.orderCode = orderCode;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
        this.deliveryAddress = deliveryAddress;
    }

    public Order(int orderId, int customerId, int totalAmount, int discount, boolean isPaid, Date createdAt, String status, String orderCode, String email, String fullname, String phone, String deliveryAddress) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.totalAmount = totalAmount;
        this.discount = discount;
        this.isPaid = isPaid;
        this.createdAt = createdAt;
        this.status = status;
        this.orderCode = orderCode;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
        this.deliveryAddress = deliveryAddress;
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

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public boolean isIsPaid() {
        return isPaid;
    }

    public void setIsPaid(boolean isPaid) {
        this.isPaid = isPaid;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
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

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
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

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    @Override
    public String toString() {
        return "Order{" + "orderId=" + orderId + ", customerId=" + customerId + ", totalAmount=" + totalAmount + ", discount=" + discount + ", isPaid=" + isPaid + ", createdAt=" + createdAt + ", status=" + status + ", orderCode=" + orderCode + ", email=" + email + ", fullname=" + fullname + ", phone=" + phone + ", deliveryAddress=" + deliveryAddress + ", listOrderDetails=" + listOrderDetails + '}';
    }

}
