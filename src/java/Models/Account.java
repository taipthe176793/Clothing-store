/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author admin
 */
public class Account {
    private int accountId;
    private String username;
    private String password;
    private int roleId;
    private String email;
    private String fullname;
    private String phone;
    private String address;

    public Account() {
    }

    public Account(String username, String password, int roleId) {
        this.username = username;
        this.password = password;
        this.roleId = roleId;
    }

    public Account(String username, String password, int roleId, String email, String fullname, String phone) {
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
    }

    public Account(int accountId, String username, String password, int roleId, String email, String fullname, String phone, String address) {
        this.accountId = accountId;
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.email = email;
        this.fullname = fullname;
        this.phone = phone;
        this.address = address;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Account{" + "accountId=" + accountId + ", username=" + username + ", password=" + password + ", roleId=" + roleId + ", email=" + email + ", fullname=" + fullname + ", phone=" + phone + ", address=" + address + '}';
    }
    
    
    
}
