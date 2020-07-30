/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.actions;

import com.opensymphony.xwork2.ActionContext;
import huyttd.daos.RequestDAO;
import huyttd.dtos.BookingDTO;
import huyttd.dtos.BookingDetailDTO;
import huyttd.dtos.RegistrationDTO;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author KRIS
 */
public class HistoryAction {

    private static final String ERROR = "error";
    private static final String SUCCESS = "success";
    private static final Logger LOGGER = Logger.getLogger(HistoryAction.class);

    private String nameSearch, bookedDate, viewDetail, cancel, id;
    private List<BookingDTO> listBooking;
    private List<BookingDetailDTO> listBookingDetail;

    public HistoryAction() {
    }

    public String getNameSearch() {
        return nameSearch;
    }

    public void setNameSearch(String nameSearch) {
        this.nameSearch = nameSearch;
    }

    public String getBookedDate() {
        return bookedDate;
    }

    public void setBookedDate(String bookedDate) {
        this.bookedDate = bookedDate;
    }

    public String getViewDetail() {
        return viewDetail;
    }

    public void setViewDetail(String viewDetail) {
        this.viewDetail = viewDetail;
    }

    public String getCancel() {
        return cancel;
    }

    public void setCancel(String cancel) {
        this.cancel = cancel;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public List<BookingDTO> getListBooking() {
        return listBooking;
    }

    public void setListBooking(List<BookingDTO> listBooking) {
        this.listBooking = listBooking;
    }

    public List<BookingDetailDTO> getListBookingDetail() {
        return listBookingDetail;
    }

    public void setListBookingDetail(List<BookingDetailDTO> listBookingDetail) {
        this.listBookingDetail = listBookingDetail;
    }

    public String execute() throws Exception {
        String label = ERROR;
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            RequestDAO dao = new RequestDAO();
            if (cancel != null) {
                if (!dao.processRequest(2, Integer.parseInt(id))) {
                    label = ERROR;
                }
            }
            Map session = ActionContext.getContext().getSession();
            RegistrationDTO registrationDto = (RegistrationDTO) session.get("DTO");
            listBooking = new ArrayList<>();
            List<Integer> listBookingId = dao.getRequest(nameSearch, bookedDate, registrationDto.getEmail());

            if (!listBookingId.isEmpty()) {
                Set<Integer> set = new LinkedHashSet<>(listBookingId);
                listBookingId.clear();
                listBookingId.addAll(set);
                for (int i = 0; i < listBookingId.size(); i++) {
                    listBooking.add(dao.getBooking(listBookingId.get(i)));
                }
            }
            if (viewDetail != null) {
                listBookingDetail = dao.getBookingDetail(Integer.parseInt(id));
                BookingDTO dto = dao.getBooking(Integer.parseInt(id));
                request.setAttribute("bookingStatus", dto.getStatusId());
            }
            label = SUCCESS;
        } catch (Exception e) {
            LOGGER.error("ERROR at HistoryAction: " + e.getMessage());
        } finally {
            return label;
        }
    }

}
