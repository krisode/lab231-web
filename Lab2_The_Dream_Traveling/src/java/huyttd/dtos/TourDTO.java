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
public class TourDTO implements Serializable {

    int id, quota, status;
    String name, image, place, description;
    Date from, to;
    float price;
    int quantity, slot;

    public TourDTO() {
    }

    public TourDTO(int quota, String name, String image, String place, String description, Date from, Date to, float price, int status) {
        this.quota = quota;
        this.status = status;
        this.name = name;
        this.image = image;
        this.place = place;
        this.description = description;
        this.from = from;
        this.to = to;
        this.price = price;
    }

    public TourDTO(int id, int quota, String name, String image, String place, Date from, Date to, float price, String description) {
        this.id = id;
        this.quota = quota;
        this.name = name;
        this.image = image;
        this.place = place;
        this.from = from;
        this.to = to;
        this.price = price;
        this.description = description;
    }

    public TourDTO(int id, int quota, int slot, String name, String image, String place, Date from, Date to, float price, String description) {
        this.id = id;
        this.quota = quota;
        this.slot = slot;
        this.name = name;
        this.image = image;
        this.place = place;
        this.from = from;
        this.to = to;
        this.price = price;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuota() {
        return quota;
    }

    public void setQuota(int quota) {
        this.quota = quota;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getPlace() {
        return place;
    }

    public void setPlace(String place) {
        this.place = place;
    }

    public Date getFrom() {
        return from;
    }

    public void setFrom(Date from) {
        this.from = from;
    }

    public Date getTo() {
        return to;
    }

    public void setTo(Date to) {
        this.to = to;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getSlot() {
        return slot;
    }

    public void setSlot(int slot) {
        this.slot = slot;
    }

}
