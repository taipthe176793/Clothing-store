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
public class Content {
    private int id;
    private String title;
    private String img;
    private String body;
    private int contentTypeId;
    private Timestamp createdAt;

    public Content() {
    }

    public Content(String title, String img, String body, int contentTypeId, Timestamp createdAt) {
        this.title = title;
        this.img = img;
        this.body = body;
        this.contentTypeId = contentTypeId;
        this.createdAt = createdAt;
    }
    

    public Content(int id, String title, String img, String body, int contentTypeId, Timestamp createdAt) {
        this.id = id;
        this.title = title;
        this.img = img;
        this.body = body;
        this.contentTypeId = contentTypeId;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public int getContentTypeId() {
        return contentTypeId;
    }

    public void setContentTypeId(int contentTypeId) {
        this.contentTypeId = contentTypeId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Content{" + "id=" + id + ", title=" + title + ", img=" + img + ", body=" + body + ", contentTypeId=" + contentTypeId + ", createdAt=" + createdAt + '}';
    }
    
    
}
