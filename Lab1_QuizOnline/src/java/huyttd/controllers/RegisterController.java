/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.controllers;

import huyttd.daos.RegistrationDAO;
import huyttd.dtos.RegistrationDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author KRIS
 */
public class RegisterController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(RegisterController.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        RegistrationDTO dto = null;
        try {
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            String fullname = request.getParameter("txtFullname");
            RegistrationDAO dao = new RegistrationDAO();
            String code = dao.randoms();
            dto = new RegistrationDTO(username, password, fullname, code);
            dao.register(dto);
            dao.sendMail("Java.Mail.CA@gmail.com", username, "Welcome to QuizOn", "Welcome to QuizOn. ", code);
        } catch (Exception e) {
            log("ERROR at RegisterController: " + e.getMessage());
            if (e.getMessage().contains("duplicate")) { // IF Username of Registed User has existed, send "DUPLICATE MESSAGE" to ("index.jsp" or LOGIN PAGE)
                request.setAttribute("ERROR", "Email has already existed");
                request.setAttribute("DTO", dto); // Create a "DTO" => "REFILL" element boxes at ("index.jsp" or LOGIN PAGE)
            }
            LOGGER.error("ERROR at RegisterController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("index.jsp").forward(request, response);
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
