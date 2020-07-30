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
public class VerifyController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(VerifyController.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "verify.jsp";
        String fullname = null;
        try {
            String username = request.getParameter("txtUsername");
            String code = request.getParameter("txtVerify");
            RegistrationDAO dao = new RegistrationDAO();
            String check = dao.checkCode(code, username);
            if (check.equals("failed")) {
                request.setAttribute("ERROR", "Invalid code! Please reinput code. Please input the sended code in your email");
            } else {
                HttpSession session = request.getSession();
                String password = request.getParameter("txtPassword");
                String role = dao.checkLogin(username, password);
                dao.changeStatus(username);
                fullname = dao.getFullname(username);
                QuestionDAO questDao = new QuestionDAO();
                List<SubjectDTO> subList = questDao.getSubject();
                session.setAttribute("SUBJECT", subList);
                session.setAttribute("Fullname", fullname);
                session.setAttribute("Username", username);
                session.setAttribute("Role", role);
                url = "admin.jsp";
            }
        } catch (Exception e) {
            log("ERROR at VerifyController: " + e.getMessage());
            LOGGER.error("ERROR at VerifyController: " + e.getMessage());
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
