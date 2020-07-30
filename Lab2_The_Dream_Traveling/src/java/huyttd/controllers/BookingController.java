/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.controllers;

import huyttd.daos.TourDAO;
import huyttd.dtos.CartObject;
import huyttd.dtos.RegistrationDTO;
import huyttd.dtos.TourDTO;
import java.io.IOException;
import java.sql.Date;
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
public class BookingController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String BOOK = "SearchController";
    private static final Logger LOGGER = Logger.getLogger(BookingController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            CartObject obj = (CartObject) session.getAttribute("cart");
            RegistrationDTO dto = (RegistrationDTO) session.getAttribute("DTO");
            if (obj == null) { // Get "cart": if "cart is null", create new one with User's fullname
                obj = new CartObject(dto.getFullname());
            }
            String id = request.getParameter("txtId");
            String name = request.getParameter("txtName");
            String image = request.getParameter("txtImage");
            String price = request.getParameter("txtPrice");
            String description = request.getParameter("txtDescription");
            String from = request.getParameter("txtFrom");
            String to = request.getParameter("txtTo");
            String place = request.getParameter("txtPlace");
            String quota = request.getParameter("txtQuota");
            int quantity = 1; // Each time when Tour is inserted to cart, default quantity is '1'
            TourDAO dao = new TourDAO();
            int slot = Integer.parseInt(quota) - dao.getBookedSlot(Integer.parseInt(id));
            TourDTO tourDTO = new TourDTO(Integer.parseInt(id), Integer.parseInt(quota), slot, name, image, place, Date.valueOf(from), Date.valueOf(to), Float.parseFloat(price), description);
            tourDTO.setQuantity(quantity); // Set Tour quantity for updating quantity in "cart"
            obj.addToCart(tourDTO); // Add Tour to "cart"
            session.setAttribute("cart", obj);
            url = BOOK;
        } catch (Exception e) {
//            log("ERROR at BookingController: " + e.getMessage());
            LOGGER.error("ERROR at BookingController: " + e.getMessage());
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
