/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.daos;

import huyttd.dtos.BookingDTO;
import huyttd.dtos.CartObject;
import huyttd.dtos.DiscountDTO;
import huyttd.utils.DBConnection;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author KRIS
 */
public class BookingDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public BookingDAO() {
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

    public int confirm(BookingDTO dto) throws Exception {
        int bookingId = 0;
        String sql = "";
        try {
            if (dto.getDiscountId() != null) {
                sql = "INSERT INTO Booking(Total, Username, DiscountID, Status) OUTPUT inserted.BookingID VALUES(?,?,?,?)";
            } else if (dto.getDiscountId() == null) {
                sql = "INSERT INTO Booking(Total, Username, Status) OUTPUT inserted.BookingID VALUES(?,?,?)";
            }
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setFloat(1, dto.getTotal());
            preStm.setString(2, dto.getUsername());
            if (dto.getDiscountId() != null) {
                preStm.setString(3, dto.getDiscountId());
                preStm.setInt(4, 4);
            } else if (dto.getDiscountId() == null) {
                preStm.setInt(3, 4);
            }
            rs = preStm.executeQuery();
            if (rs.next()) {
                bookingId = rs.getInt("BookingID");
            }
        } finally {
            closeConnection();
        }
        return bookingId;
    }

    public boolean confirmDetail(CartObject obj, int bookingId) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT INTO BookingDetails(FromDate, ToDate, Amount, TourID, BookingID) VALUES(?,?,?,?,?)";
            conn = DBConnection.makeConnection();
            for (int key : obj.getCart().keySet()) {
                preStm = conn.prepareStatement(sql);
                int id = key;
                preStm.setDate(1, obj.getCart().get(id).getFrom());
                preStm.setDate(2, obj.getCart().get(id).getTo());
                preStm.setInt(3, obj.getCart().get(id).getQuantity());
                preStm.setInt(4, obj.getCart().get(id).getId());
                preStm.setInt(5, bookingId);
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public int changeCouponStatus() throws Exception {
        int change = 0;
        try {
            String sql = "UPDATE Discount SET Status = 2 WHERE ExpiredDate < getDate()";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            change = preStm.executeUpdate();
        } finally {
            closeConnection();
        }
        return change;
    }

    public boolean checkCoupon(String coupon) throws Exception {
        boolean check = false;
        try {
            String sql = "SELECT DiscountID FROM Discount WHERE DiscountID = ? AND Status = 1";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, coupon);
            rs = preStm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean checkAlreadyUsed(String coupon, String username) throws Exception {
        boolean check = true;
        try {
            String sql = "SELECT TOP(1) DiscountID FROM Booking WHERE DiscountID = ? AND Username = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, coupon);
            preStm.setString(2, username);
            rs = preStm.executeQuery();
            if (rs.next()) {
                check = false;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public DiscountDTO getCoupon(String coupon) throws Exception {
        DiscountDTO dto = null;
        try {
            String sql = "SELECT Name, [Percent], ExpiredDate FROM Discount WHERE DiscountID = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, coupon);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String name = rs.getString("Name");
                float percent = rs.getFloat("Percent");
                Date expiredDate = rs.getDate("ExpiredDate");
                dto = new DiscountDTO(coupon, name, percent, expiredDate);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

//    public String getCouponId(String coupon) throws Exception {
//        int result = 0;
//        try {
//            String sql = "SELECT DiscountID FROM Discount WHERE Name = ?";
//            conn = DBConnection.makeConnection();
//            preStm = conn.prepareStatement(sql);
//            preStm.setString(1, coupon);
//            rs = preStm.executeQuery();
//            if (rs.next()) {
//                result = rs.getInt("DiscountID");
//            }
//        } finally {
//            closeConnection();
//        }
//        return result;
//    }
}
