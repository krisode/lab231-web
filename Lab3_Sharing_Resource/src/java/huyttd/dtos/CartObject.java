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

    private String name;
    private HashMap<Integer, ResourceDTO> cart;

    public CartObject(String name) {
        this.name = name;
        this.cart = new HashMap<>();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public HashMap<Integer, ResourceDTO> getCart() {
        return cart;
    }

    public void addToCart(ResourceDTO dto) throws Exception { // If Tour has already existed in "cart", increase the Tour's quantity
        if (this.cart.containsKey(dto.getId()) && this.cart.get(dto.getId()).getBorrowDate().equals(dto.getBorrowDate())) {
            int quantity = this.cart.get(dto.getId()).getQuantityInCart() + dto.getQuantityInCart();
            dto.setQuantityInCart(quantity);
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

    public boolean update(int id, int quantity) throws Exception { // Update Tour's quantity in "cart"
        if (this.cart.containsKey(id)) {
            this.cart.get(id).setQuantity(quantity);
            return true;
        }
        return false;
    }
}
