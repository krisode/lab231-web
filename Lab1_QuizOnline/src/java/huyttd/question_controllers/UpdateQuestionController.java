/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.question_controllers;

import huyttd.daos.QuestionDAO;
import huyttd.dtos.QuestionDTO;
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
public class UpdateQuestionController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UpdateQuestionController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String id = request.getParameter("txtId");
            String content = request.getParameter("txtContent");
            String ans1 = request.getParameter("txtAnswer1");
            String ans2 = request.getParameter("txtAnswer2");
            String ans3 = request.getParameter("txtAnswer3");
            String ans4 = request.getParameter("txtAnswer4");
            String correct = request.getParameter("txtCorrect");
            String correctAns = "";
            if (correct.equals("Answer 1")) {
                correctAns = ans1;
            } else if (correct.equals("Answer 2")) {
                correctAns = ans2;
            } else if (correct.equals("Answer 3")) {
                correctAns = ans3;
            } else if (correct.equals("Answer 4")) {
                correctAns = ans4;
            }
            String subjectId = request.getParameter("txtSubject");
            String status = request.getParameter("txtStatus");
            boolean questStatus = true;
            if (status.equals("DeActive")) {
                questStatus = false;
            }
            QuestionDTO dto = new QuestionDTO(id, content, ans1, ans2, ans3, ans4, correctAns, subjectId, questStatus);
            QuestionDAO dao = new QuestionDAO();
            if (dao.update(dto)) {
                request.setAttribute("SUCCESS", "Question: " + id + " updated successfully");
            } else {
                request.setAttribute("ERROR", "Update failed");
            }
        } catch (Exception e) {
            log("ERROR at UpdateQuestionController: " + e.getMessage());
            LOGGER.error("ERROR at UpdateQuestionController: " + e.getMessage());
        } finally {
            request.getRequestDispatcher("SearchQuestionController").forward(request, response);
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
