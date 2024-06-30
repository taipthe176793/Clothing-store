/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.util.Date;

/**
 *
 * @author caoqu
 */
public class Blog {
    private int blogId;
    private String title;
    private String image;
    private String body;
    private int blogTypeId;
    private Date createdAt;
    private boolean status;
    
    public Blog() {
    }

    public Blog(String title, String image, String body, int blogTypeId, boolean status) {
        this.title = title;
        this.image = image;
        this.body = body;
        this.blogTypeId = blogTypeId;
        this.status = status;
    }

    public Blog(int blogId, String title, String image, String body, int blogTypeId, Date createdAt, boolean status) {
        this.blogId = blogId;
        this.title = title;
        this.image = image;
        this.body = body;
        this.blogTypeId = blogTypeId;
        this.createdAt = createdAt;
        this.status = status;
    }

    public Blog(int blogId, String title, String image, String body, int blogTypeId, boolean status) {
        this.blogId = blogId;
        this.title = title;
        this.image = image;
        this.body = body;
        this.blogTypeId = blogTypeId;
        this.status = status;
    }
    

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public int getBlogTypeId() {
        return blogTypeId;
    }

    public void setBlogTypeId(int blogTypeId) {
        this.blogTypeId = blogTypeId;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Blog{" + "blogId=" + blogId + ", title=" + title + ", image=" + image + ", body=" + body + ", blogTypeId=" + blogTypeId + ", createdAt=" + createdAt + ", status=" + status + '}';
    }

    
    
    
    
}
