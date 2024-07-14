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
public class Feedback {
    private int feedbackId;
    private int customerId;
    private String username;
    private int productId;
    private String comment;
    private double rating;
    private boolean isDeleted;
    private Date createdAt;
    private boolean isReported;

    public Feedback() {
    }

    public Feedback(int customerId, int productId, String comment, double rating, Date createdAt) {
        this.customerId = customerId;
        this.productId = productId;
        this.comment = comment;
        this.rating = rating;
        this.createdAt = createdAt;
    }

    public Feedback(int feedbackId, int customerId, int productId, String comment, double rating, Date createdAt, boolean isReported) {
        this.feedbackId = feedbackId;
        this.customerId = customerId;
        this.productId = productId;
        this.comment = comment;
        this.rating = rating;
        this.createdAt = createdAt;
        this.isReported = isReported;
    }
    
    
    public Feedback(int feedbackId, int customerId, int productId, String comment, double rating, Date createdAt) {
        this.feedbackId = feedbackId;
        this.customerId = customerId;
        this.productId = productId;
        this.comment = comment;
        this.rating = rating;
        this.createdAt = createdAt;
    }

    public Feedback(int feedbackId, int customerId, int productId, String comment, double rating, boolean isDeleted, Date createdAt, boolean isReported) {
        this.feedbackId = feedbackId;
        this.customerId = customerId;
        this.productId = productId;
        this.comment = comment;
        this.rating = rating;
        this.isDeleted = isDeleted;
        this.createdAt = createdAt;
        this.isReported = isReported;
    }

    public Feedback(int feedbackId, int customerId, String username, int productId, String comment, double rating, boolean isDeleted, Date createdAt, boolean isReported) {
        this.feedbackId = feedbackId;
        this.customerId = customerId;
        this.username = username;
        this.productId = productId;
        this.comment = comment;
        this.rating = rating;
        this.isDeleted = isDeleted;
        this.createdAt = createdAt;
        this.isReported = isReported;
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

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isIsReported() {
        return isReported;
    }

    public void setIsReported(boolean isReported) {
        this.isReported = isReported;
    }

    public boolean isIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(boolean isDelete) {
        this.isDeleted = isDelete;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    

    @Override
    public String toString() {
        return "Feedback{" + "feedbackId=" + feedbackId + ", customerId=" + customerId + ", productId=" + productId + ", comment=" + comment + ", rating=" + rating + ", createdAt=" + createdAt + '}';
    }
    
    
    
}
