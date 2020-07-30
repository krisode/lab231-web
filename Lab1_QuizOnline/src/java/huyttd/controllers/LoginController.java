/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.controllers;

import huyttd.daos.QuestionDAO;
import huyttd.daos.RegistrationDAO;
import huyttd.dtos.SubjectDTO;
import java.io.IOException;
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
public class LoginController extends HttpServlet {

    private static final String ERROR = "index.jsp";
    private static final String ADMIN = "admin.jsp";

    private static final String VERIFY = "verify.jsp";
    private static final Logger LOGGER = Logger.getLogger(LoginController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        String fullname = null;
        try {
            String username = request.getParameter("txtUsername");
            String password = request.getParameter("txtPassword");
            RegistrationDAO dao = new RegistrationDAO();
            String role = dao.checkLogin(username, password);
            String status = dao.checkStatus(username);
            if (role.equals("failed")) {
                url = ERROR;
                request.setAttribute("ERROR", "Invalid Username or Password!!!");
                request.setAttribute("Username", username);
            } else if (role.equals("admin")) {
                HttpSession session = request.getSession();
                fullname = dao.getFullname(username);
                QuestionDAO questDao = new QuestionDAO();
                List<SubjectDTO> subList = questDao.getSubject();
                session.setAttribute("SUBJECT", subList);
                session.setAttribute("Fullname", fullname);
                session.setAttribute("Username", username);
                session.setAttribute("Role", role);
                url = ADMIN;
            } else if (role.equals("student")) {
                if (status.equals("Active")) {
                    HttpSession session = request.getSession();
                    fullname = dao.getFullname(username);
                    QuestionDAO questDao = new QuestionDAO();
                    List<SubjectDTO> subList = questDao.getSubject();
                    session.setAttribute("SUBJECT", subList);
                    session.setAttribute("Username", username);
                    session.setAttribute("Fullname", fullname);
                    session.setAttribute("Role", role);
                    url = ADMIN;
                } else if (status.equals("New")) {
                    url = VERIFY;
                } else {
                    url = "error.jsp";
                }
            } else {
                request.setAttribute("ERROR", "Your role is invalid");
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
