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
public class EditQuestionController extends HttpServlet {

    private static final String CREATE = "createQuiz.jsp";
    private static final String EDIT = "updateQuiz.jsp";
    private static final String ERROR = "error.jsp";
    private static final Logger LOGGER = Logger.getLogger(EditQuestionController.class);
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String action = request.getParameter("action");
            if (action.equals("Insert")) {
                QuestionDAO dao = new QuestionDAO();
                List<SubjectDTO> subjectList = dao.getSubject(); // Get a list of all Subject in the whole system to "Change Question Subject"
                request.setAttribute("LIST", subjectList); // Send the list to "updateQuiz.jsp"
                url = CREATE;
            } else if (action.equals("Edit")) {
                // Get PARAMETER from "userlist.jsp"
                String search = request.getParameter("txtSearch");
                String category = request.getParameter("txtChoice");
                String id = request.getParameter("txtId");
                QuestionDAO dao = new QuestionDAO();
                QuestionDTO dto = dao.findQuestion(id);
                List<SubjectDTO> subjectList = dao.getSubject(); // Get a list of all Subject in the whole system to "Change Question Subject"
                request.setAttribute("QUESTION", dto); // Send "DTO" contains Question's Information to "updateQuiz.jsp" to fill Question's information
                request.setAttribute("LIST", subjectList); // Send the list to "updateQuiz.jsp"
                request.setAttribute("Search", search);
                request.setAttribute("Category", category);
                if (dto.getAns1().equals(dto.getCorrectAns())) {
                    request.setAttribute("Correct", "Answer1");
                } else if (dto.getAns2().equals(dto.getCorrectAns())) {
                    request.setAttribute("Correct", "Answer2");
                } else if (dto.getAns3().equals(dto.getCorrectAns())) {
                    request.setAttribute("Correct", "Answer3");
                } else if (dto.getAns4().equals(dto.getCorrectAns())) {
                    request.setAttribute("Correct", "Answer4");
                }
                url = EDIT;
            }

        } catch (Exception e) {
            log("ERROR at EditQuestionController: " + e.getMessage());
            LOGGER.error("ERROR at EditQuestionController: " + e.getMessage());
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
