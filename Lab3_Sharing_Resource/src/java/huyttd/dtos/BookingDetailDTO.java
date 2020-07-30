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

    private int detailId, bookingId, resourceId, amount;
    private String resourceName;
    private Date borrowDate, returnDate;

    public BookingDetailDTO() {
    }

    public BookingDetailDTO(int detailId, int bookingId, int resourceId, int amount, Date borrowDate, Date returnDate, String resourceName) {
        this.detailId = detailId;
        this.bookingId = bookingId;
        this.resourceId = resourceId;
        this.amount = amount;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.resourceName = resourceName;
    }

    public int getDetailId() {
        return detailId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getResourceId() {
        return resourceId;
    }

    public void setResourceId(int resourceId) {
        this.resourceId = resourceId;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
    }

}
