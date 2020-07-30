/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.actions;

import huyttd.daos.RegistrationDAO;
import huyttd.dtos.RegistrationDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author KRIS
 */
public class RegisterAction {

    private static final String ERROR = "error";
    private static final String SUCCESS = "success";
    private static final Logger LOGGER = Logger.getLogger(RegisterAction.class);

    private String username, password, name, address, phone;

    public RegisterAction() {
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String execute() throws Exception {
        String label = ERROR;
        try {
            RegistrationDAO dao = new RegistrationDAO();
            String code = dao.randoms();
            RegistrationDTO dto = new RegistrationDTO(username, password, name, code, address, phone);
            dao.register(dto);
            dao.sendMail("Java.Mail.CA@gmail.com", username, "Welcome to The Company", "Welcome to The Company. ", code);
            label = SUCCESS;
        } catch (Exception e) {
            LOGGER.error("ERROR at RegisterAction: " + e.getMessage());
        } finally {
            return label;
        }
    }

}
