/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.controllers;

import huyttd.daos.TourDAO;
import huyttd.dtos.CartObject;
import huyttd.dtos.TourDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
public class SearchController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SEARCH = "places.jsp";
    private static final Logger LOGGER = Logger.getLogger(SearchController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        int total = 0;
        List<TourDTO> result = new ArrayList<>();
        try {
            HttpSession session = request.getSession();
            String place = request.getParameter("places");
            String from = request.getParameter("dateFrom");
            String to = request.getParameter("dateTo");
            String low = request.getParameter("lower");
            String high = request.getParameter("higher");
            String pageCount = request.getParameter("txtCount");

            int slot = 0;
            int page = 1;
            if (pageCount != null) {
                page = Integer.parseInt(pageCount);
            }
            String next = request.getParameter("btnNext");
            String previous = request.getParameter("btnPrevious");
            TourDAO dao = new TourDAO();
            total = (int) dao.getTotal(place, from, to, low, high, page);
            if (next != null && next != "") {
                page += 1;
                if (page > total) {
                    page = 1;
                }
            } else if (previous != null && previous != "") {
                page -= 1;
                if (page <= 0) {
                    page = total;
                }
            }

            // Change Tour status if Tour FromDate is lower than the current date
//            dao.changeTourStatus();
            result = dao.search(place, from, to, low, high, page);
            for (int i = 0; i < result.size(); i++) {
                slot = dao.getBookedSlot(result.get(i).getId());
                result.get(i).setSlot(slot);
            }

            CartObject obj = (CartObject) session.getAttribute("cart");
            if (obj != null) {
                for (int j = 0; j < result.size(); j++) {
                    if (obj.getCart().containsKey(result.get(j).getId())) {
                        slot = obj.getCart().get(result.get(j).getId()).getQuantity() + dao.getBookedSlot(result.get(j).getId());
                        result.get(j).setSlot(slot);
                    }
                }
            }

            request.setAttribute("LIST", result);
            request.setAttribute("Count", page);
            request.setAttribute("Total", total);
            if (!place.isEmpty()) {
                request.setAttribute("Place", place);
            }
            if (!from.isEmpty()) {
                request.setAttribute("From", from);
            }
            if (!to.isEmpty()) {
                request.setAttribute("To", to);
            }
            if (!low.isEmpty()) {
                request.setAttribute("Low", low);
            }
            if (!high.isEmpty()) {
                request.setAttribute("High", high);
            }

            url = SEARCH;
        } catch (Exception e) {
//            log("ERROR at SearchController: " + e.getMessage());
            LOGGER.error("ERROR at SearchController: " + e.getMessage());
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
