/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.actions;

import com.opensymphony.xwork2.ActionContext;
import huyttd.daos.ResourceDAO;
import huyttd.dtos.BookingDTO;
import huyttd.dtos.CartObject;
import huyttd.dtos.RegistrationDTO;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author KRIS
 */
public class RequestAction {

    private static final String ERROR = "error";
    private static final String SUCCESS = "success";
    private static final String DELETE = "delete";
    private static final Logger LOGGER = Logger.getLogger(RequestAction.class);

    private String send, delete, id;

    public RequestAction() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getSend() {
        return send;
    }

    public void setSend(String send) {
        this.send = send;
    }

    public String getDelete() {
        return delete;
    }

    public void setDelete(String delete) {
        this.delete = delete;
    }

    public String execute() throws Exception {
        String label = ERROR;
        try {
            if (send != null) {
                HttpServletRequest request = ServletActionContext.getRequest();
                String[] listId = request.getParameterValues("id");
                String[] listReturnDate = request.getParameterValues("returnDate");
                Map session = ActionContext.getContext().getSession();
                CartObject obj = (CartObject) session.get("cart");
                for (int i = 0; i < listId.length; i++) {
                    obj.getCart().get(Integer.parseInt(listId[i])).setReturnDate(listReturnDate[i]);
                }
                RegistrationDTO registrationDTO = (RegistrationDTO) session.get("DTO");
                BookingDTO dto = new BookingDTO(3, registrationDTO.getEmail(), registrationDTO.getName());
                ResourceDAO dao = new ResourceDAO();
                int bookingId = dao.sendRequest(dto);
                if (dao.confirmDetail(obj, bookingId)) {
                    label = SUCCESS;
                    session.remove("cart");
                }
            } else if (delete != null) {
                Map session = ActionContext.getContext().getSession();
                CartObject obj = (CartObject) session.get("cart");
                obj.delete(Integer.parseInt(id));
                label = DELETE;
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at RequestAction: " + e.getMessage());
        } finally {
            return label;
        }
    }
}
