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

    private String username, password, fbId, fullname;
    int role;

    public RegistrationDTO() {
    }

    public RegistrationDTO(String username, String fullname, int role) {
        this.username = username;
        this.fullname = fullname;
        this.role = role;
    }

    public RegistrationDTO(String username, String password, String fbId, String fullname, int role) {
        this.username = username;
        this.password = password;
        this.fbId = fbId;
        this.fullname = fullname;
        this.role = role;
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

    public String getFbId() {
        return fbId;
    }

    public void setFbId(String fbId) {
        this.fbId = fbId;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

}
