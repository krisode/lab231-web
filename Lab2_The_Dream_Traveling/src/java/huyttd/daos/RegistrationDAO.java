/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.daos;

import huyttd.dtos.RegistrationDTO;
import huyttd.utils.DBConnection;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author KRIS
 */
public class RegistrationDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public RegistrationDAO() {
    }

    public void closeConnection() throws Exception {
        if (rs != null) {
            rs.close();
        }
        if (preStm != null) {
            preStm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    public int checkLogin(String username, String password) throws Exception {
        int role = 0;
        try {
            String sql = "SELECT RoleID FROM Registration WHERE Username = ? AND Password = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, username);
            preStm.setString(2, password);
            rs = preStm.executeQuery();
            if (rs.next()) {
                role = rs.getInt("RoleID");
            }
        } finally {
            closeConnection();
        }
        return role;
    }

    public RegistrationDTO getUser(String username) throws Exception {
        RegistrationDTO dto = null;
        try {
            String sql = "SELECT Fullname, RoleID FROM Registration WHERE Username = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, username);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String fullname = rs.getString("Fullname");
                int role = rs.getInt("RoleID");
                dto = new RegistrationDTO(username, fullname, role);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public int checkStatus(String username) throws Exception {
        int status = 0;
        try {
            String sql = "SELECT Status FROM Registration WHERE Username = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, username);
            rs = preStm.executeQuery();
            if (rs.next()) {
                status = rs.getInt("Status");
            }
        } finally {
            closeConnection();
        }
        return status;
    }
}
