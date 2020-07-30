/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.question_controllers;

import huyttd.daos.QuestionDAO;
import huyttd.dtos.QuestionDTO;
import huyttd.dtos.SubjectDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author KRIS
 */
public class CreateQuestionController extends HttpServlet {

    private static final String ERROR = "createQuiz.jsp";
    private static final String SUCCESS = "SearchQuestionController";
    private static final Logger LOGGER = Logger.getLogger(CreateQuestionController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            QuestionDAO dao = new QuestionDAO();
            String id = request.getParameter("txtId");
            String subjectId = request.getParameter("txtSubject");
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
            String status = request.getParameter("txtStatus");
            boolean questStatus = true;
            if (status.equals("DeActive")) {
                questStatus = false;
            }

            if (dao.getId(subjectId + id)) {
                QuestionDTO dto = new QuestionDTO(id, content, ans1, ans2, ans3, ans4, correctAns, subjectId, questStatus);
                List<SubjectDTO> result = dao.getSubject();
                request.setAttribute("ERROR", "Question ID duplicated");
                request.setAttribute("QUESTION", dto);
                request.setAttribute("LIST", result);
            } else {
                QuestionDTO dto = new QuestionDTO(subjectId + id, content, ans1, ans2, ans3, ans4, correctAns, subjectId, questStatus);
                if (dao.create(dto)) {
                    request.setAttribute("SUCCESS", "Question[" + subjectId + id + "] has been created");
                    url = SUCCESS;
                } else {
                    request.setAttribute("ERROR", "Create failed");
                }
            }

        } catch (Exception e) {
            log("ERROR at CreateQuestionController: " + e.getMessage());
            LOGGER.error("ERROR at CreateQuestionController: " + e.getMessage());
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
