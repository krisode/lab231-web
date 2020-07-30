/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.actions;

import com.opensymphony.xwork2.ActionContext;
import huyttd.daos.ResourceDAO;
import huyttd.dtos.CartObject;
import huyttd.dtos.CategoryDTO;
import huyttd.dtos.RegistrationDTO;
import huyttd.dtos.ResourceDTO;
import java.util.List;
import java.util.Map;
import org.apache.log4j.Logger;

/**
 *
 * @author KRIS
 */
public class BookAction {

    private static final String ERROR = "error";
    private static final String SUCCESS = "success";
    private static final Logger LOGGER = Logger.getLogger(BookAction.class);

    private int id, quantity, role, availableQuantity, quantityInCart;
    private String resourceName, description, color, image, category, nameSearch, pageCount, usingDate;

    public BookAction() {
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

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
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

    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = resourceName;
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getNameSearch() {
        return nameSearch;
    }

    public void setNameSearch(String nameSearch) {
        this.nameSearch = nameSearch;
    }

    public String getPageCount() {
        return pageCount;
    }

    public void setPageCount(String pageCount) {
        this.pageCount = pageCount;
    }

    public String getUsingDate() {
        return usingDate;
    }

    public void setUsingDate(String usingDate) {
        this.usingDate = usingDate;
    }

    public String execute() {
        String label = ERROR;
        try {
            Map session = ActionContext.getContext().getSession();
            RegistrationDTO dto = (RegistrationDTO) session.get("DTO");
            CartObject obj = (CartObject) session.get("cart");
            List<CategoryDTO> listResource = (List<CategoryDTO>) session.get("listCategory");
            ResourceDAO dao = new ResourceDAO();
            if (obj == null) {
                obj = new CartObject(dto.getName());
            }
            int quantityInCart = 1;
            int status = 1;
            int categoryId = 0;
            for (int i = 0; i < listResource.size(); i++) {
                if (listResource.get(i).getName().equals(category)) {
                    categoryId = listResource.get(i).getId();
                }
            }
            if (obj.getCart().isEmpty()) {
                availableQuantity = quantity - dao.getAvailableQuantity(id, usingDate) - quantityInCart;
            } else {
                if (obj.getCart().get(id) != null) {
                    if (obj.getCart().get(id).getBorrowDate().equals(usingDate)) {
                        availableQuantity = quantity - dao.getAvailableQuantity(id, usingDate) - obj.getCart().get(id).getQuantityInCart() - 1;
                    }
                } else {
                    availableQuantity = quantity - dao.getAvailableQuantity(id, usingDate) - quantityInCart;
                }
            }
            ResourceDTO resourceDTO = new ResourceDTO(id, quantity, status, role, categoryId, resourceName, description, color, image, availableQuantity, usingDate);
            resourceDTO.setQuantityInCart(quantityInCart);
            obj.addToCart(resourceDTO);
            session.put("cart", obj);
            label = SUCCESS;
        } catch (Exception e) {
            LOGGER.error("ERROR at BookAction: " + e.getMessage());
        } finally {
            return label;
        }

    }

}
