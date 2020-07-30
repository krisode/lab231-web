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
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author KRIS
 */
public class LoginController extends HttpServlet {

    private static final String INVALID = "login.jsp";
    private static final String LOGIN = "places.jsp";
    private static final String ERROR = "error.jsp";
    private static final Logger LOGGER = Logger.getLogger(LoginController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = INVALID;
        try {
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            RegistrationDAO dao = new RegistrationDAO();
            int role = dao.checkLogin(username, password); // Check role of user
            int status = dao.checkStatus(username); // Check status of user
            RegistrationDTO dto = dao.getUser(username); // Get user's information
            if (role == 0) { // If user doesn't have an account, default role is '0'
                request.setAttribute("ERROR", "Invalid username or password!!!");
                request.setAttribute("Username", username);
            } else if (role != 0) { // Role is not '0' means user have account
                if (status == 1) { // Status '1' means user's account is Activating 
                    HttpSession session = request.getSession();
                    session.setAttribute("DTO", dto);
                    url = LOGIN;
                } else { // Status is not '1' means user's account is Disabled
                    request.setAttribute("ERROR", "Your account has been disabled");
                    url = ERROR;
                }
            } else {
                request.setAttribute("ERROR", "Your role is invalid");
                url = ERROR;
            }
        } catch (Exception e) {
//            log("ERROR at LoginController: " + e.getMessage());
            LOGGER.error("ERROR at LoginController: " + e.getMessage());
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
