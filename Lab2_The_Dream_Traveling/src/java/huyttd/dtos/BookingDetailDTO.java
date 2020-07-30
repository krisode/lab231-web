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
public class BookingDetailDTO implements Serializable {

    private String detailId, bookingId, tourId;
    private Date fromDate, toDate;
    private int amount;

    public BookingDetailDTO() {
    }

    public BookingDetailDTO(String detailId, String bookingId, String tourId, Date fromDate, Date toDate, int amount) {
        this.detailId = detailId;
        this.bookingId = bookingId;
        this.tourId = tourId;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.amount = amount;
    }

    public String getDetailId() {
        return detailId;
    }

    public void setDetailId(String detailId) {
        this.detailId = detailId;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getTourId() {
        return tourId;
    }

    public void setTourId(String tourId) {
        this.tourId = tourId;
    }

    public Date getFromDate() {
        return fromDate;
    }

    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    public Date getToDate() {
        return toDate;
    }

    public void setToDate(Date toDate) {
        this.toDate = toDate;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

}
