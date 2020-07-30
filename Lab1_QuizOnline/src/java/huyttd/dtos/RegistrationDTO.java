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

    private String username;
    private String password;
    private String fullname;
    private String status;
    private String code;

    public RegistrationDTO() {
    }

    public RegistrationDTO(String username, String password, String fullname) {
        this.username = username;
        this.password = password;
        this.fullname = fullname;
    }

    public RegistrationDTO(String username, String password, String fullname, String code) {
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.code = code;
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

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

}
