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
public class BookingDTO implements Serializable {

    private String bookingId, username, discountId;
    private float total;
    private int status;

    public BookingDTO() {
    }

    public BookingDTO(String username, String discountId, float total) {
        this.username = username;
        this.discountId = discountId;
        this.total = total;
    }

    public BookingDTO(String bookingId, String username, String discountId, float total, int status) {
        this.bookingId = bookingId;
        this.username = username;
        this.discountId = discountId;
        this.total = total;
        this.status = status;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getDiscountId() {
        return discountId;
    }

    public void setDiscountId(String discountId) {
        this.discountId = discountId;
    }

    public float getTotal() {
        return total;
    }

    public void setTotal(float total) {
        this.total = total;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
