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
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author KRIS
 */
public class SearchAction {

    private static final String ERROR = "error";
    private static final String SUCCESS = "success";
    private static final Logger LOGGER = Logger.getLogger(SearchAction.class);


//    private String lastw
    private String nameSearch, usingDate, category, pageCount, next, previous;
    private List<ResourceDTO> listResource;

    public SearchAction() {
    }

    public String getNameSearch() {
        return nameSearch;
    }

    public void setNameSearch(String nameSearch) {
        this.nameSearch = nameSearch;
    }

    public String getUsingDate() {
        return usingDate;
    }

    public void setUsingDate(String usingDate) {
        this.usingDate = usingDate;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public List<ResourceDTO> getListResource() {
        return listResource;
    }

    public void setListResource(List<ResourceDTO> listResource) {
        this.listResource = listResource;
    }

    public String getPageCount() {
        return pageCount;
    }

    public void setPageCount(String pageCount) {
        this.pageCount = pageCount;
    }

    public String getNext() {
        return next;
    }

    public void setNext(String next) {
        this.next = next;
    }

    public String getPrevious() {
        return previous;
    }

    public void setPrevious(String previous) {
        this.previous = previous;
    }

    public String execute() throws Exception {
        String label = ERROR;
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
        int total = 0;
        int page = 1;

        if (pageCount != null) {
            page = Integer.parseInt(pageCount);
        }
        Map session = ActionContext.getContext().getSession();
        List<CategoryDTO> listCategory = (List<CategoryDTO>) session.get("listCategory");
        RegistrationDTO registDTO = (RegistrationDTO) session.get("DTO");
        int role = registDTO.getRole();
        int categoryId = 0;
        for (int i = 0; i < listCategory.size(); i++) {
            if (listCategory.get(i).getName().equals(category)) {
                categoryId = listCategory.get(i).getId();
            }
        }
        ResourceDAO resourceDAO = new ResourceDAO();
        total = (int) resourceDAO.getTotal(nameSearch, categoryId, role, page);
        if (next != null) {
            page += 1;
            if (page > total) {
                page = 1;
            }
        } else if (previous != null) {
            page -= 1;
            if (page <= 0) {
                page = total;
            }
        }
        listResource = resourceDAO.getResource(nameSearch, categoryId, role, page);
        int availableQuantity = 0;
        for (int i = 0; i < listResource.size(); i++) {
            availableQuantity = resourceDAO.getAvailableQuantity(listResource.get(i).getId(), usingDate);
            availableQuantity = listResource.get(i).getQuantity() - availableQuantity;
            listResource.get(i).setAvailableQuantity(availableQuantity);
        }
        CartObject obj = (CartObject) session.get("cart");
        if (obj != null) {
            for (int j = 0; j < listResource.size(); j++) {
                if (obj.getCart().containsKey(listResource.get(j).getId()) && obj.getCart().get(listResource.get(j).getId()).getBorrowDate().equals(usingDate)) {
                    availableQuantity = listResource.get(j).getAvailableQuantity() - obj.getCart().get(listResource.get(j).getId()).getQuantityInCart();
                    listResource.get(j).setAvailableQuantity(availableQuantity);
                } else {
                    obj.delete(listResource.get(j).getId());
                }
            }
        }
        request.setAttribute("Count", page);
        request.setAttribute("Total", total);
        label = SUCCESS;
        } catch (Exception e) {
            LOGGER.error("ERROR at SearchAction: " + e.getMessage());
        } finally {
            return label;
        }
    }

}
