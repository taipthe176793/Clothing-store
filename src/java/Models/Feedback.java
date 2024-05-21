/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Timestamp;

/**
 *
 * @author admin
 */
public class Feedback {
    private int feedbackId;
    private int customerId;
    private int productId;
    private String comment;
    private double rating;
    private Timestamp createdAt;

    public Feedback() {
    }

    public Feedback(int feedbackId, int customerId, int productId, String comment, double rating, Timestamp createdAt) {
        this.feedbackId = feedbackId;
        this.customerId = customerId;
        this.productId = productId;
        this.comment = comment;
        this.rating = rating;
        this.createdAt = createdAt;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Feedback{" + "feedbackId=" + feedbackId + ", customerId=" + customerId + ", productId=" + productId + ", comment=" + comment + ", rating=" + rating + ", createdAt=" + createdAt + '}';
    }
    
    
    
}
