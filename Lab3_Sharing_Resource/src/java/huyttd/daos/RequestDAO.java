/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.daos;

import huyttd.dtos.BookingDTO;
import huyttd.dtos.BookingDetailDTO;
import huyttd.utils.DBConnection;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author KRIS
 */
public class RequestDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

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

    public List<Integer> searchBookingId(String name, String from, String to) throws Exception {
        List<Integer> result = new ArrayList<>();
        String sql = "SELECT BookingID FROM BookingDetail"
                + " WHERE ResourceName LIKE ? ";
        String fromSql = " AND UsingDate >= ? ";
        String toSql = " AND ReturnDate <= ? ";
        String sortSql = " ORDER BY BookingID";
        if (!from.isEmpty()) {
            sql += fromSql;
        }
        if (!to.isEmpty()) {
            sql += toSql;
        }
        sql += sortSql;
        try {
            int i = 0;
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(++i, "%" + name + "%");
            if (!from.isEmpty()) {
                preStm.setString(++i, from);
            }
            if (!to.isEmpty()) {
                preStm.setString(++i, to);
            }
            rs = preStm.executeQuery();
            while (rs.next()) {
                int bookingId = rs.getInt("BookingID");
                result.add(bookingId);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<Integer> searchBookingIdBasedOnStatus(String username, int status) throws Exception {
        List<Integer> result = new ArrayList<>();
        String sql = "SELECT BookingID FROM Booking WHERE Name LIKE ? AND StatusID != 2 ";
        String statusSql = " AND StatusID = ? ";
        String sortSQL = "ORDER BY BookingDate DESC";
        try {
            int i = 0;
            conn = DBConnection.makeConnection();
            if (status != 0) {
                sql += statusSql;
            }
            sql += sortSQL;
            preStm = conn.prepareStatement(sql);
            preStm.setString(++i, "%" + username + "%");
            if (status != 0) {
                preStm.setInt(++i, status);
            }
            rs = preStm.executeQuery();
            while (rs.next()) {
                int bookingId = rs.getInt("BookingID");
                for (int j = 0; j < result.size(); j++) {
                    if (result.get(j).equals(bookingId)) {
                        result.remove(j);
                    }
                }
                result.add(bookingId);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public BookingDTO getBooking(int bookingId) throws Exception {
        BookingDTO dto = null;
        try {
            String sql = "SELECT BookingDate, StatusID, Username, Name FROM Booking WHERE BookingID = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, bookingId);
            rs = preStm.executeQuery();
            while (rs.next()) {
                Date bookingDate = rs.getDate("BookingDate");
                int status = rs.getInt("StatusID");
                String username = rs.getString("Username");
                String name = rs.getString("Name");
                dto = new BookingDTO(bookingId, status, username, name, bookingDate);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

//    public double getTotal(int bookingId) throws Exception {
//        double total = 0;
//        try {
//            String sql = "SELECT COUNT(BookingID) as 'Number' FROM Booking WHERE BookingID = ?";
//            conn = DBConnection.makeConnection();
//            preStm = conn.prepareStatement(sql);
//            preStm.setInt(1, bookingId);
//            rs = preStm.executeQuery();
//            if (rs.next()) {
//                total = Math.ceil(rs.getDouble("Number") / ROWS);
//            }
//        } finally {
//            closeConnection();
//        }
//        return total;
//    }
    public List<BookingDetailDTO> getBookingDetail(int bookingId) throws Exception {
        List<BookingDetailDTO> result = new ArrayList<>();
        BookingDetailDTO dto = null;
        try {
            String sql = "SELECT BookingDetailID, Amount, UsingDate, ReturnDate, ResourceID, ResourceName FROM BookingDetail WHERE BookingID = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, bookingId);
            rs = preStm.executeQuery();
            while (rs.next()) {
                int bookingDetailId = rs.getInt("BookingDetailID");
                int amount = rs.getInt("Amount");
                Date usingDate = rs.getDate("UsingDate");
                Date returnDate = rs.getDate("ReturnDate");
                int resourceId = rs.getInt("ResourceID");
                String resourceName = rs.getString("ResourceName");
                dto = new BookingDetailDTO(bookingDetailId, bookingId, resourceId, amount, usingDate, returnDate, resourceName);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean processRequest(int status, int bookingId) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE Booking SET StatusID = ? WHERE BookingID = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, status);
            preStm.setInt(2, bookingId);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<Integer> getRequest(String resourceName, String bookingDate, String username) throws Exception {
        List<Integer> result = new ArrayList<>();
        try {
            String sql = "SELECT Booking.BookingID FROM Booking INNER JOIN BookingDetail ON Booking.BookingID = BookingDetail.BookingID WHERE BookingDetail.ResourceName LIKE ? AND Booking.Username = ? AND Booking.StatusID != 2 ";
            String bookingDateSql = " AND BookingDate = ? ";
            String sortSql = "ORDER BY Booking.BookingDate DESC";
            if (!bookingDate.isEmpty()) {
                sql += bookingDateSql;
            }
            sql += sortSql;
            int i = 0;
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(++i, "%" + resourceName + "%");
            preStm.setString(++i, username);
            if (!bookingDate.isEmpty()) {
                preStm.setString(++i, bookingDate);
            }
            rs = preStm.executeQuery();
            while (rs.next()) {
                int bookingId = rs.getInt("BookingID");
                result.add(bookingId);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
