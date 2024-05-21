/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author admin
 */
public class ContentType {
    private int contentTypeId;
    private String name;

    public ContentType() {
    }

    public ContentType(int contentTypeId, String name) {
        this.contentTypeId = contentTypeId;
        this.name = name;
    }

    public int getContentTypeId() {
        return contentTypeId;
    }

    public void setContentTypeId(int contentTypeId) {
        this.contentTypeId = contentTypeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "ContentType{" + "contentTypeId=" + contentTypeId + ", name=" + name + '}';
    }
    
    
}
