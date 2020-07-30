/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.controllers;

import huyttd.daos.TourDAO;
import huyttd.dtos.TourDTO;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author KRIS
 */
public class InsertController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "insert.jsp";
    private static final Logger LOGGER = Logger.getLogger(InsertController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            TourDAO dao = new TourDAO();
            String name = request.getParameter("txtName");
            String from = request.getParameter("txtFrom");
            String to = request.getParameter("txtTo");
            String price = request.getParameter("txtPrice");
            String quota = request.getParameter("txtQuota");
            String place = request.getParameter("txtPlace");
            String image = "images/" + request.getParameter("txtImage"); // Store choosen image to Database with the Path 
                                                                         // is an image stored in Image Folder in Project
            int status = 1;

            String description = request.getParameter("txtDescription");
            TourDTO dto = new TourDTO(Integer.parseInt(quota), name, image, place, description, Date.valueOf(from), Date.valueOf(to), Float.parseFloat(price), status);
            // Insert new Tour
            if (dao.insert(dto)) { // If Insert success, back to "insert.jsp" for continuing inserting
                request.setAttribute("NOTIFICATION", "Tour [" + dto.getName() + " - " + dto.getPlace() + "] has been created");
                url = SUCCESS;
            } else { // If Insert failed, foward to Error page
                request.setAttribute("NOTIFICATION", "Can not create Tour [" + dto.getName() + " - " + dto.getPlace() + "]");
                url = ERROR;
            }
        } catch (Exception e) {
//            log("ERROR at InsertController: " + e.getMessage());
            LOGGER.error("ERROR at InsertController: " + e.getMessage());
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
