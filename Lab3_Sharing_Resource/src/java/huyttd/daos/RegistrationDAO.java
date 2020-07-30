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
import java.util.Date;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author KRIS
 */
public class RegistrationDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static final String DICTIONARY_NUMBER = "0123456789";

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

    public boolean register(RegistrationDTO dto) throws Exception {
        boolean check = false;
        int status = 3;
        try {
            String sql = "INSERT INTO Registration(Username, Password, GoogleID, Fullname, StatusID, RoleID, Code, Address, Phone) VALUES(?,?,?,?,?,?,?,?,?)";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getEmail());
            preStm.setString(2, dto.getPassword());
            preStm.setString(3, dto.getId());
            preStm.setString(4, dto.getName());
            if (dto.getId() != null) {
                status = 1;
            }
            preStm.setInt(5, status);
            preStm.setInt(6, 3);
            preStm.setString(7, dto.getCode());
            preStm.setString(8, dto.getAddress());
            preStm.setString(9, dto.getPhone());
            check = preStm.executeUpdate() > 0;

        } finally {
            closeConnection();
        }
        return check;
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

    public boolean checkDuplicate(String username) throws Exception {
        boolean check = false;
        try {
            String sql = "SELECT Username FROM Registration WHERE Username = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, username);
            rs = preStm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public int sendMail(String from, String to, String subject, String message, String code) {
        try {
            Properties props = System.getProperties();
//            props.setProperty("mail.transport.protocol", "smtp");
//            props.setProperty("mail.host", "smtp.gmail.com");
//            // -- Attaching to default Session, or we could start a new one --
//            props.put("mail.transport.protocol", "smtp");
//            props.put("mail.smtp.starttls.enable", "true");
//            props.put("mail.smtp.host", smtpServ);
//            props.put("mail.smtp.auth", "true");
            props.setProperty("mail.transport.protocol", "smtp");
            props.setProperty("mail.host", "smtp.gmail.com");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.port", "465");
            props.put("mail.debug", "true");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.socketFactory.fallback", "false");
            Authenticator auth = new SMTPAuthenticator();
            Session session = Session.getInstance(props, auth);
            // -- Create a new message --
            Message msg = new MimeMessage(session);
            // -- Set the FROM and TO fields --

            msg.setFrom(new InternetAddress(from));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject(subject);
            msg.setText(message + "Please enter the following code to verify your email: " + code);

            // -- Set some other header information --
            msg.setHeader("MyMail", "Mr. XYZ");
            msg.setSentDate(new Date());
            // -- Send the message --
            Transport.send(msg);

            return 0;
        } catch (Exception ex) {
            ex.printStackTrace();
            return -1;
        }
    }

// Also include an inner class that is used for authentication purposes
    private class SMTPAuthenticator extends javax.mail.Authenticator {

        @Override
        public PasswordAuthentication getPasswordAuthentication() {
            String username = "mrsimple14062000@gmail.com";           // specify your email id here (sender's email id)
            String password = "14062000danghuy";                                      // specify your password here
            return new PasswordAuthentication(username, password);
        }
    }

    public static String randoms() {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 6; i++) {
            sb.append(DICTIONARY_NUMBER.charAt(new Random().nextInt(DICTIONARY_NUMBER.length())));
        }
        return sb.toString();
    }

    public int checkStatus(String username) throws Exception {
        int status = 0;
        try {
            String sql = "SELECT StatusID FROM Registration WHERE Username = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, username);
            rs = preStm.executeQuery();
            if (rs.next()) {
                status = rs.getInt("StatusID");
            }
        } finally {
            closeConnection();
        }
        return status;
    }

    public boolean changeStatus(String username) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE Registration SET StatusID = ? WHERE Username = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, 1);
            preStm.setString(2, username);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public String checkCode(String code, String username) throws Exception {
        String result = "failed";
        try {
            String sql = "SELECT Code FROM Registration WHERE Username = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, username);
            rs = preStm.executeQuery();
            if (rs.next()) {
                if (code.equals(rs.getString("Code"))) {
                    result = "success";
                }
            }

        } finally {
            closeConnection();
        }
        return result;
    }
}
