/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package Models;

/**
 *
 * @author admin
 */
public class CustomerAddress {

    private int addressId;
    private int customerId;
    private String phone;
    private String address;
    private boolean isDefault;
    
    public CustomerAddress() {
    }

    public CustomerAddress(int customerId, String phone, String address) {
        this.customerId = customerId;
        this.phone = phone;
        this.address = address;
    }

    public CustomerAddress(int addressId, int customerId, String phone, String address) {
        this.addressId = addressId;
        this.customerId = customerId;
        this.phone = phone;
        this.address = address;
    }

    public CustomerAddress(int addressId, int customerId, String phone, String address, boolean isDefault) {
        this.addressId = addressId;
        this.customerId = customerId;
        this.phone = phone;
        this.address = address;
        this.isDefault = isDefault;
    }
    

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
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

    public boolean isIsDefault() {
        return isDefault;
    }

    public void setIsDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }
    

    @Override
    public String toString() {
        return "Address{" + "addressId=" + addressId + ", customerId=" + customerId + ", phone=" + phone + ", address=" + address + '}';
    }
    
}
