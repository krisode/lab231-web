/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.daos;

import huyttd.dtos.TourDTO;
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
public class TourDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;
    private static final int ROWS = 5;

    public TourDAO() {
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

    public int changeTourStatus() throws Exception {
        int change = 0;
        try {
            String sql = "UPDATE Tour SET StatusID = 2 WHERE FromDate < getDate()";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            change = preStm.executeUpdate();
        } finally {
            closeConnection();
        }
        return change;
    }

    public List<TourDTO> search(String place, String from, String to, String low, String high, int page) throws Exception {
        List<TourDTO> result = new ArrayList<>();
        TourDTO dto = null;
        String sql = "SELECT TourID, TourName, FromDate, ToDate, Price, Quota, Place, Image, Description FROM Tour"
                + " WHERE StatusID = 1 ";

        String sortSql = "Order by FromDate ";
        String subSql = "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        String placeSql = "AND Place LIKE ? ";
        String fromDateSql = "AND FromDate >= ? ";
        String toDateSql = "AND ToDate <= ? ";
        String lowPriceSql = "AND Price >= ? ";
        String highPriceSql = "AND Price <= ? ";
        int lowPrice = 0;
        int highPrice = 0;

        if (!place.isEmpty()) {
            //SELECT TOP(5) TourID, TourName, FromDate, ToDate, Price, Quota, Place, Image FROM Tour
            //    WHERE Status = 1 AND Place LIKE ? Order by FromDate OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
            sql += placeSql;
        }
        if (!from.isEmpty()) {
            sql += fromDateSql;
        }
        if (!to.isEmpty()) {
            sql += toDateSql;
        }
        if (!low.isEmpty()) {
            sql += lowPriceSql;
            lowPrice = Integer.parseInt(low);
        }
        if (!high.isEmpty()) {
            sql += highPriceSql;
            highPrice = Integer.parseInt(high);
        }

        if (!low.isEmpty() && !high.isEmpty() && lowPrice > highPrice) {
            int temp = lowPrice;
            lowPrice = highPrice;
            highPrice = temp;
        }

        String exeSql = sql + sortSql + subSql;
        try {
            int top = (page - 1) * ROWS;
            int i = 0;
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(exeSql);
            if (!place.isEmpty()) {
                preStm.setString(++i, "%" + place + "%");
            }
            if (!from.isEmpty()) {
                preStm.setString(++i, from);
            }
            if (!to.isEmpty()) {
                preStm.setString(++i, to);
            }
            if (!low.isEmpty()) {
                preStm.setInt(++i, lowPrice);
            }
            if (!high.isEmpty()) {
                preStm.setInt(++i, highPrice);
            }
            preStm.setInt(++i, top);
            preStm.setInt(++i, ROWS);
            rs = preStm.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("TourID");
                String name = rs.getString("TourName");
                Date fromDate = rs.getDate("FromDate");
                Date toDate = rs.getDate("ToDate");
                float price = rs.getFloat("Price");
                int quota = rs.getInt("Quota");
                String des = rs.getString("Place");
                String image = rs.getString("Image");
                String description = rs.getString("Description");
                dto = new TourDTO(id, quota, name, image, des, fromDate, toDate, price, description);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public double getTotal(String place, String from, String to, String low, String high, int page) throws Exception {
        double total = 0;
        String sql = "SELECT COUNT(TourID) as 'Number' FROM Tour"
                + " WHERE StatusID = 1 ";

        String placeSql = "AND Place LIKE ? ";
        String fromDateSql = "AND FromDate >= ? ";
        String toDateSql = "AND ToDate <= ? ";
        String lowPriceSql = "AND Price >= ? ";
        String highPriceSql = "AND Price <= ? ";
        int lowPrice = 0;
        int highPrice = 0;

        if (!place.isEmpty()) {
            //SELECT TOP(5) TourID, TourName, FromDate, ToDate, Price, Quota, Place, Image FROM Tour
            //    WHERE Status = 1 AND Place LIKE ? Order by FromDate OFFSET ? ROWS FETCH NEXT ? ROWS ONLY
            sql += placeSql;
        }
        if (!from.isEmpty()) {
            sql += fromDateSql;
        }
        if (!to.isEmpty()) {
            sql += toDateSql;
        }
        if (!low.isEmpty()) {
            sql += lowPriceSql;
            lowPrice = Integer.parseInt(low);
        }
        if (!high.isEmpty()) {
            sql += highPriceSql;
            highPrice = Integer.parseInt(high);
        }
        if (!low.isEmpty() && !high.isEmpty() && lowPrice > highPrice) {
            int temp = lowPrice;
            lowPrice = highPrice;
            highPrice = temp;
        }

        try {
            int i = 0;
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            if (!place.isEmpty()) {
                preStm.setString(++i, "%" + place + "%");
            }
            if (!from.isEmpty()) {
                preStm.setString(++i, from);
            }
            if (!to.isEmpty()) {
                preStm.setString(++i, to);
            }

            if (!low.isEmpty()) {
                preStm.setInt(++i, lowPrice);
            }
            if (!high.isEmpty()) {
                preStm.setInt(++i, highPrice);
            }
            rs = preStm.executeQuery();
            if (rs.next()) {
                total = Math.ceil(rs.getDouble("Number") / ROWS);
            }
        } finally {
            closeConnection();
        }
        return total;
    }

    public int getBookedSlot(int tourId) throws Exception {
        int result = 0;
        try {
            String sql = "SELECT Amount FROM BookingDetails WHERE TourID = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, tourId);
            rs = preStm.executeQuery();
            while (rs.next()) {
                result += rs.getInt("Amount");
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean insert(TourDTO dto) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT INTO Tour(TourName, FromDate, ToDate, Price, Quota, Image, Place, StatusID, Description) "
                    + "VALUES(?,?,?,?,?,?,?,?,?)";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getName());
            preStm.setDate(2, dto.getFrom());
            preStm.setDate(3, dto.getTo());
            preStm.setFloat(4, dto.getPrice());
            preStm.setInt(5, dto.getQuota());
            preStm.setString(6, dto.getImage());
            preStm.setString(7, dto.getPlace());
            preStm.setInt(8, dto.getStatus());
            preStm.setString(9, dto.getDescription());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

}
