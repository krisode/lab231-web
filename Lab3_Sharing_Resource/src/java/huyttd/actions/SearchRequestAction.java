/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.actions;

import huyttd.daos.RequestDAO;
import huyttd.dtos.BookingDTO;
import huyttd.dtos.BookingDetailDTO;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author KRIS
 */
public class SearchRequestAction {

    private static final String ERROR = "error";
    private static final String SUCCESS = "success";
    private static final int ROWS = 5;
    private static final Logger LOGGER = Logger.getLogger(SearchRequestAction.class);

    private String nameSearch, usernameSearch, from, to, status, viewDetail, accept, deny, id, pageCount, next, previous;
    private List<BookingDTO> listBooking;
    private List<BookingDetailDTO> listBookingDetail;

    public SearchRequestAction() {
    }

    public String getNameSearch() {
        return nameSearch;
    }

    public void setNameSearch(String nameSearch) {
        this.nameSearch = nameSearch;
    }

    public String getUsernameSearch() {
        return usernameSearch;
    }

    public void setUsernameSearch(String usernameSearch) {
        this.usernameSearch = usernameSearch;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public String getViewDetail() {
        return viewDetail;
    }

    public void setViewDetail(String viewDetail) {
        this.viewDetail = viewDetail;
    }

    public String getAccept() {
        return accept;
    }

    public void setAccept(String accept) {
        this.accept = accept;
    }

    public String getDeny() {
        return deny;
    }

    public void setDeny(String deny) {
        this.deny = deny;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
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
            int statusId = 0;
            RequestDAO dao = new RequestDAO();
            if (accept != null) {
                if (!dao.processRequest(5, Integer.parseInt(id))) {
                    label = ERROR;
                }
            }

            if (deny != null) {
                if (!dao.processRequest(4, Integer.parseInt(id))) {
                    label = ERROR;
                }
            }
            List<Integer> listBookingId = dao.searchBookingId(nameSearch, from, to);

            if (status.equals("New")) {
                statusId = 3;
            } else if (status.equals("Delete")) {
                statusId = 4;
            } else if (status.equals("Accept")) {
                statusId = 5;
            }

            int page = 1;
            int total = 0;
            if (pageCount != null) {
                page = Integer.parseInt(pageCount);
            }

            // Forget using INNER JOIN
            List<Integer> listBookingIdBasedOnStatus = dao.searchBookingIdBasedOnStatus(usernameSearch, statusId);
            List<Integer> listId = new ArrayList<>();
            for (int i = 0; i < listBookingId.size(); i++) {
                for (int j = 0; j < listBookingIdBasedOnStatus.size(); j++) {
                    if (listBookingIdBasedOnStatus.get(j).equals(listBookingId.get(i))) {
                        int bookingId = listBookingIdBasedOnStatus.get(j);
                        for (int k = 0; k < listId.size(); k++) {
                            if (listId.get(k).equals(bookingId)) {
                                listId.remove(k);
                            }
                        }
                        listId.add(bookingId);
                    }
                }
            }
            listBooking = new ArrayList<>();
            Collections.reverse(listId);
            total = (int) Math.ceil((double) listId.size() / ROWS);
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

            for (int i = (page - 1) * ROWS; i < page * ROWS; i++) {
                if (i == listId.size()) {
                    break;
                } else {
                    listBooking.add(dao.getBooking(listId.get(i)));
                }
            }
            request.setAttribute("Count", page);
            request.setAttribute("Total", total);
//            for (int i = 0; i < listId.size(); i++) {
//                listBooking.add(dao.getBooking(listId.get(i)));
//            }
            if (viewDetail != null) {
                listBookingDetail = dao.getBookingDetail(Integer.parseInt(id));
                BookingDTO dto = dao.getBooking(Integer.parseInt(id));
                request.setAttribute("bookingStatus", dto.getStatusId());
            }
            label = SUCCESS;
        } catch (Exception e) {
            LOGGER.error("ERROR at SearchRequestAction: " + e.getMessage());
        } finally {
            return label;
        }
    }
}
