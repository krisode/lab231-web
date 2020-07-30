/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.quiz_controllers;

import huyttd.daos.QuestionDAO;
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
public class ResultController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ResultController.class);
    private static final String ERROR = "error.jsp";
    private static final String SUBMIT = "result.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            String[] answer = (String[]) request.getAttribute("RESULT");
            List<String> question = (List<String>) request.getAttribute("LIST");
            String username = (String) session.getAttribute("Username");
            String subId = (String) request.getAttribute("SubId");
            String subName = (String) request.getAttribute("SubName");
            QuestionDAO dao = new QuestionDAO();
            int noCorrect = dao.getResult(answer, subId, question);
            float score = (((float) noCorrect / answer.length) * 10);
            if (dao.finishQuiz(username, score, subId)) {
                url = SUBMIT;
                request.setAttribute("SubId", subId);
                request.setAttribute("SubName", subName);
                request.setAttribute("NoCorrect", noCorrect);
                request.setAttribute("Score", score);
                request.setAttribute("Total", answer.length);
            }
        } catch (Exception e) {
            log("ERROR at ResultController: " + e.getMessage());
            LOGGER.error("ERROR at ResultController: " + e.getMessage());
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
