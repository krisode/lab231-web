/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.daos;

import huyttd.dtos.BookingDTO;
import huyttd.dtos.CartObject;
import huyttd.dtos.CategoryDTO;
import huyttd.dtos.ResourceDTO;
import huyttd.utils.DBConnection;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author KRIS
 */
public class ResourceDAO implements Serializable {
    
    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static final int ROWS = 1;
    
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
    
    public List<CategoryDTO> getCategory(int role) throws Exception {
        List<CategoryDTO> result = new ArrayList<>();
        CategoryDTO dto = null;
        String sql = "";
        try {
            if (role == 2) {
                sql = "SELECT CategoryID, Name FROM Category";
            } else if (role == 3) {
                sql = "SELECT CategoryID, Name FROM Category WHERE RoleID = ?";
            }
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            if (role == 3) {
                preStm.setInt(1, role);
            }
            
            rs = preStm.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("CategoryID");
                String name = rs.getString("Name");
                dto = new CategoryDTO(id, name);
                result.add(dto);
            }
            
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public List<ResourceDTO> getResource(String name, int categoryId, int role, int page) throws Exception {
        List<ResourceDTO> result = new ArrayList<>();
        ResourceDTO dto = null;
        String sql = "";
        String sortSql = "Order by Name ";
        String nameSql = "AND Name LIKE ? ";
        String categorySql = "AND CategoryID = ? ";
        String subSql = "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        
        if (role == 2) {
            sql = "SELECT ResourceID, Name, Description, Color, Quantity, Image FROM Resource WHERE StatusID = 1 ";
        } else if (role == 3) {
            sql = "SELECT ResourceID, Name, Description, Color, Quantity, Image FROM Resource WHERE StatusID = 1 AND RoleID = 3 ";
        }
        if (!name.isEmpty()) {
            sql += nameSql;
        }
        String executeSql = sql + categorySql + sortSql + subSql;
        try {
            int top = (page - 1) * ROWS;
            int i = 0;
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(executeSql);
            if (!name.isEmpty()) {
                preStm.setString(++i, "%" + name + "%");
            }
            preStm.setInt(++i, categoryId);
            preStm.setInt(++i, top);
            preStm.setInt(++i, ROWS);
            rs = preStm.executeQuery();
            while (rs.next()) {
                // Name, Description, Color, Quantity, Image, CategoryID
                int id = rs.getInt("ResourceID");
                String resourceName = rs.getString("Name");
                String description = rs.getString("Description");
                String color = rs.getString("Color");
                int quantity = rs.getInt("Quantity");
                String image = rs.getString("Image");
//                List<Integer> listBookingId = getBookingIdByUsingDate(usingDate);
//                int availableQuantity = 0;
//                for (Integer bookingId : listBookingId) {
//                    availableQuantity += getAvailableQuantity(id, bookingId);
//                }
                dto = new ResourceDTO(id, quantity, 1, role, categoryId, resourceName, description, color, image, 0);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public double getTotal(String name, int categoryId, int role, int page) throws Exception {
        double total = 0;
        String sql = "";
        String nameSql = "AND Name LIKE ? ";
        String categorySql = "AND CategoryID = ? ";
        
        if (role == 2) {
            sql = "SELECT COUNT(ResourceID) as 'Number' FROM Resource WHERE StatusID = 1 ";
        } else if (role == 3) {
            sql = "SELECT COUNT(ResourceID) as 'Number' FROM Resource WHERE StatusID = 1 AND RoleID = 3 ";
        }
        if (!name.isEmpty()) {
            sql += nameSql;
        }
        String executeSql = sql + categorySql;
        try {
            int i = 0;
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(executeSql);
            if (!name.isEmpty()) {
                preStm.setString(++i, "%" + name + "%");
            }
            preStm.setInt(++i, categoryId);
            rs = preStm.executeQuery();
            if (rs.next()) {
                total = Math.ceil(rs.getDouble("Number") / ROWS);
            }
        } finally {
            closeConnection();
        }
        return total;
    }
    
    public int getAvailableQuantity(int resourceId, String usingDate) throws Exception {
        int result = 0;
        try {
            String sql = "SELECT Amount FROM BookingDetail INNER JOIN Booking ON BookingDetail.BookingID = Booking.BookingID WHERE BookingDetail.ResourceID = ? AND BookingDetail.UsingDate <= ? AND BookingDetail.ReturnDate >= ? AND Booking.StatusID != 4";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, resourceId);
            preStm.setString(2, usingDate);
            preStm.setString(3, usingDate);
            rs = preStm.executeQuery();
            while (rs.next()) {
                result += rs.getInt("Amount");
           }
        } finally {
            closeConnection();
        }
        return result;
    }
    
    public int sendRequest(BookingDTO dto) throws Exception {
        int bookingId = 0;
        String sql = "";
        try {
            sql = "INSERT INTO Booking(StatusID, Username, Name) OUTPUT inserted.BookingID VALUES(?,?,?)";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, dto.getStatusId());
            preStm.setString(2, dto.getUsername());
            preStm.setString(3, dto.getName());
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
            String sql = "INSERT INTO BookingDetail(UsingDate, ReturnDate, Amount, ResourceID, ResourceName, BookingID) VALUES(?,?,?,?,?,?)";
            conn = DBConnection.makeConnection();
            for (int key : obj.getCart().keySet()) {
                preStm = conn.prepareStatement(sql);
                int id = key;
                preStm.setString(1, obj.getCart().get(id).getBorrowDate());
                preStm.setString(2, obj.getCart().get(id).getReturnDate());
                preStm.setInt(3, obj.getCart().get(id).getQuantityInCart());
                preStm.setInt(4, obj.getCart().get(id).getId());
                preStm.setString(5, obj.getCart().get(id).getName());
                preStm.setInt(6, bookingId);
                check = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }
}
