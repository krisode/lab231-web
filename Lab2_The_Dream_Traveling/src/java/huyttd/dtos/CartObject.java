/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.dtos;

import java.io.Serializable;
import java.util.HashMap;

/**
 *
 * @author KRIS
 */
public class CartObject implements Serializable {

    private String customerName;
    private HashMap<Integer, TourDTO> cart;

    public CartObject(String customerName) {
        this.customerName = customerName;
        this.cart = new HashMap<>();
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public HashMap<Integer, TourDTO> getCart() {
        return cart;
    }

    public void addToCart(TourDTO dto) throws Exception { // If Tour has already existed in "cart", increase the Tour's quantity
        if (this.cart.containsKey(dto.getId())) {
            int quantity = this.cart.get(dto.getId()).getQuantity() + dto.getQuantity();
            dto.setQuantity(quantity);
        }
        this.cart.put(dto.getId(), dto); // If Tour hasn't existed, create new one in "cart"
    }

    public boolean delete(int id) throws Exception { // Remove Tour from "cart"
        if (this.cart.containsKey(id)) {
            this.cart.remove(id);
            return true;
        }
        return false;
    }

    public int getTotal() throws Exception { // Get total of Tour in "cart"
        int result = 0;
        for (TourDTO dto : this.cart.values()) {
            result += dto.getPrice() * dto.getQuantity();
        }
        return result;
    }

    public boolean update(int id, int quantity) throws Exception { // Update Tour's quantity in "cart"
        if (this.cart.containsKey(id)) {
            this.cart.get(id).setQuantity(quantity);
            return true;
        }
        return false;
    }

}
