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
public class ResourceDTO implements Serializable {

    private int id, quantity, status, role, categoryId, availableQuantity, quantityInCart;
    private String name, description, color, image, borrowDate, returnDate;

    public ResourceDTO() {
    }

    public ResourceDTO(int id, int quantity, int status, int role, int categoryId, String name, String description, String color, String image, int availableQuantity) {
        this.id = id;
        this.quantity = quantity;
        this.status = status;
        this.role = role;
        this.categoryId = categoryId;
        this.name = name;
        this.description = description;
        this.color = color;
        this.image = image;
        this.availableQuantity = availableQuantity;
    }

    public ResourceDTO(int id, int quantity, int status, int role, int categoryId, String name, String description, String color, String image, int availableQuantity, String borrowDate) {
        this.id = id;
        this.quantity = quantity;
        this.status = status;
        this.role = role;
        this.categoryId = categoryId;
        this.name = name;
        this.description = description;
        this.color = color;
        this.image = image;
        this.availableQuantity = availableQuantity;
        this.borrowDate = borrowDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getAvailableQuantity() {
        return availableQuantity;
    }

    public void setAvailableQuantity(int availableQuantity) {
        this.availableQuantity = availableQuantity;
    }

    public int getQuantityInCart() {
        return quantityInCart;
    }

    public void setQuantityInCart(int quantityInCart) {
        this.quantityInCart = quantityInCart;
    }

    public String getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(String borrowDate) {
        this.borrowDate = borrowDate;
    }

    public String getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(String returnDate) {
        this.returnDate = returnDate;
    }

}
