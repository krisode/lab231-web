/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.dtos;

import java.io.Serializable;

/**
 *
 * @author KRIS
 */
public class RegistrationDTO implements Serializable {

    private String email, password, id, name, code, address, phone;
    int role;

    public RegistrationDTO() {
    }

    public RegistrationDTO(String email, String name, int role) {
        this.email = email;
        this.name = name;
        this.role = role;
    }

    public RegistrationDTO(String email, String password, String name, String code) {
        this.email = email;
        this.password = password;
        this.name = name;
        this.code = code;
    }

    public RegistrationDTO(String email, String password, String id, String name, int role) {
        this.email = email;
        this.password = password;
        this.id = id;
        this.name = name;
        this.role = role;
    }

    public RegistrationDTO(String email, String password, String name, String code, String address, String phone) {
        this.email = email;
        this.password = password;
        this.name = name;
        this.code = code;
        this.address = address;
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "RegistrationDTO{" + "email=" + email + ", password=" + password + ", id=" + id + ", name=" + name + ", role=" + role + '}';
    }

}
