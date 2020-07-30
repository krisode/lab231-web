/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author KRIS
 */
public class BookingDTO implements Serializable {

    private int bookingId, statusId;
    private String username, name;
    private Date bookingDate;

    public BookingDTO() {
    }

    public BookingDTO(int statusId, String username, String name) {
        this.statusId = statusId;
        this.username = username;
        this.name = name;
    }

    public BookingDTO(int bookingId, int statusId, String username, String name, Date bookingDate) {
        this.bookingId = bookingId;
        this.statusId = statusId;
        this.username = username;
        this.name = name;
        this.bookingDate = bookingDate;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

}
