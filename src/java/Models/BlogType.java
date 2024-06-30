/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author caoqu
 */
public class BlogType {
    private int blogTypeId;
    private String Name;

    public BlogType() {
    }

    public BlogType(int blogTypeId, String Name) {
        this.blogTypeId = blogTypeId;
        this.Name = Name;
    }

    public int getBlogTypeId() {
        return blogTypeId;
    }

    public void setBlogTypeId(int blogTypeId) {
        this.blogTypeId = blogTypeId;
    }

    public String getName() {
        return Name;
    }

    public void setName(String Name) {
        this.Name = Name;
    }

    @Override
    public String toString() {
        return "BlogType{" + "blogTypeId=" + blogTypeId + ", Name=" + Name + '}';
    }

 
    
}
