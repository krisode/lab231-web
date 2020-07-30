/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.controllers;

import huyttd.daos.BookingDAO;
import huyttd.daos.TourDAO;
import huyttd.dtos.BookingDTO;
import huyttd.dtos.CartObject;
import huyttd.dtos.DiscountDTO;
import huyttd.dtos.RegistrationDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author KRIS
 */
public class UpdateController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String UPDATE = "book.jsp";
    private static final String CONTINUE = "SearchController";
    private static final Logger LOGGER = Logger.getLogger(UpdateController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String update = request.getParameter("btnUpdate");
            String conti = request.getParameter("btnContinue");
            String delete = request.getParameter("btnDelete");
            String discount = request.getParameter("btnDiscount");
            String confirm = request.getParameter("btnConfirm");
            if (update != null) {
                String[] listId = request.getParameterValues("txtId");
                String[] listQuantity = request.getParameterValues("txtQuantity");
                HttpSession session = request.getSession();
                CartObject obj = (CartObject) session.getAttribute("cart");
                TourDAO dao = new TourDAO();
                int slot = 0;
                for (int i = 0; i < listId.length; i++) {
                    // Get available slot in Tour
                    slot = obj.getCart().get(Integer.parseInt(listId[i])).getQuota() - dao.getBookedSlot(obj.getCart().get(Integer.parseInt(listId[i])).getId());
                    obj.getCart().get(Integer.parseInt(listId[i])).setSlot(slot);
                    if (Integer.parseInt(listQuantity[i]) > slot) {
                        // If user wants to book more than Available slot, notify error
                        request.setAttribute("ERROR", "Please choose Tour " + obj.getCart().get(Integer.parseInt(listId[i])).getPlace() + " below " + slot + " slots");
                    } else {
                        // If user wants to book less than Available slot, update Tour quantity
                        obj.update(Integer.parseInt(listId[i]), Integer.parseInt(listQuantity[i]));
                    }
                }
                session.setAttribute("cart", obj);
                url = UPDATE;
            } else if (conti != null) {
                url = CONTINUE;
            } else if (delete != null) {
                String deleteId = request.getParameter("txtDelete");
                HttpSession session = request.getSession();
                CartObject obj = (CartObject) session.getAttribute("cart");
                obj.delete(Integer.parseInt(deleteId));
                session.setAttribute("cart", obj);
                url = UPDATE;
            } else if (discount != null) {
                String coupon = request.getParameter("txtDiscount");
                BookingDAO dao = new BookingDAO();
                HttpSession session = request.getSession();
                RegistrationDTO registrationDTO = (RegistrationDTO) session.getAttribute("DTO");
                CartObject obj = (CartObject) session.getAttribute("cart");
                
                dao.changeCouponStatus(); // Change Discount's status if ExpiredDate is lower than current date
                                          // If lower, change status to '2' means Deactivated
                if (dao.checkCoupon(coupon)) { // Checking whether Discount is existing 
                    if (dao.checkAlreadyUsed(coupon, registrationDTO.getUsername())) { // Checking whether user used this Discount or hasn''t
                        DiscountDTO dto = dao.getCoupon(coupon);
                        request.setAttribute("Discount", dto.getDiscountId());
                        request.setAttribute("Percent", dto.getPercent());
                        request.setAttribute("DiscountPrice", (int) (obj.getTotal() * dto.getPercent()));
                        request.setAttribute("FinalPrice", (int) (obj.getTotal() - obj.getTotal() * dto.getPercent()));
                    } else {
                        request.setAttribute("ERROR", "This coupon has already used");
                    }
                } else {
                    request.setAttribute("ERROR", "Your coupon is not valid");
                }
                url = UPDATE;
            } else if (confirm != null) {
                String[] listId = request.getParameterValues("txtId");
                String[] listQuantity = request.getParameterValues("txtQuantity");
                HttpSession session = request.getSession();
                BookingDAO dao = new BookingDAO();
                TourDAO tourDAO = new TourDAO();
                int slot = 0;
                boolean available = false;
                BookingDTO bookingDTO;
                CartObject obj = (CartObject) session.getAttribute("cart");
                RegistrationDTO registDTO = (RegistrationDTO) session.getAttribute("DTO");
                String coupon = request.getParameter("txtDiscount");

                for (int i = 0; i < listId.length; i++) {
                    slot = obj.getCart().get(Integer.parseInt(listId[i])).getQuota() - tourDAO.getBookedSlot(obj.getCart().get(Integer.parseInt(listId[i])).getId());
                    obj.getCart().get(Integer.parseInt(listId[i])).setSlot(slot);
                    // Checking if there is a Tour in "cart" has quantity larger than available slot 
                    if (Integer.parseInt(listQuantity[i]) > slot) {
                        request.setAttribute("ERROR", "Please choose Tour " + obj.getCart().get(Integer.parseInt(listId[i])).getPlace() + " below " + slot + " slots");
                        available = false;
                        break;
                    } else {
                        available = true;
                    }
                }
                if (available) { // If Tour's quantity is valid
                    if (!coupon.isEmpty()) { // If user uses Discount
                        if (dao.checkAlreadyUsed(coupon, registDTO.getUsername())) { // If user hasn't used Discount
                            DiscountDTO discountDTO = dao.getCoupon(coupon);
                            bookingDTO = new BookingDTO(registDTO.getUsername(), coupon, obj.getTotal() - (obj.getTotal() * discountDTO.getPercent()));
                            int bookingId = dao.confirm(bookingDTO);
                            if (dao.confirmDetail(obj, bookingId)) {
                                session.setAttribute("cart", null);
                                url = CONTINUE;
                            }
                        } else { // If user used Discount before
                            request.setAttribute("ERROR", "This coupon has already used");
                            url = UPDATE;
                        }
                    } else if (coupon.isEmpty()) { // If user don't use Discount
                        bookingDTO = new BookingDTO(registDTO.getUsername(), null, obj.getTotal());
                        int bookingId = dao.confirm(bookingDTO);
                        if (dao.confirmDetail(obj, bookingId)) {
                            session.setAttribute("cart", null);
                            url = CONTINUE;
                        }
                    }
                } else { // If Tour's quantity is not valid, foward back to "book.jsp"
                    url = UPDATE;
                }
            }

        } catch (Exception e) {
//            log("ERROR at UpdateController: " + e.getMessage());
            LOGGER.error("ERROR at UpdateController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
