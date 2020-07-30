/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.quiz_controllers;

import huyttd.daos.QuestionDAO;
import huyttd.dtos.QuestionDTO;
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
public class QuizController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(QuizController.class);
    private static final String DOING = "takeQuiz.jsp";
    private static final String DONE = "ResultController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = DOING;
        List<String> result = null;
//        List<String> answerList = null;
//        List<String> answer = null;
        String[] answer = null;
        try {
            String id = request.getParameter("txtId");
            String name = request.getParameter("txtName");
            String number = request.getParameter("txtNo");
            String action;
            QuestionDAO dao = new QuestionDAO();
            HttpSession session = request.getSession();
            String page = request.getParameter("txtCount");
            if (page == null) {
                String username = (String) session.getAttribute("Username");
                String time = dao.getQuizTime(id);
                result = dao.getRandomQuestion(id, Integer.parseInt(number));
                dao.startQuiz(username, id);
                session.setAttribute("LIST", result);
                int pageCount = 1;
                request.setAttribute("Count", pageCount);
                QuestionDTO dto = dao.findQuestion(result.get(pageCount - 1));
                request.setAttribute("QUESTION", dto);
                answer = new String[Integer.parseInt(number)];
                session.setAttribute("Correct", answer);
                session.setAttribute("Time", time);
                request.setAttribute("SubName", name);
                request.setAttribute("Id", id);
                request.setAttribute("Done", 0);
                request.setAttribute("Total", Integer.parseInt(number));
            } else {
                String subName = request.getParameter("txtSubName");
                int pageCount = Integer.parseInt(page);
                action = request.getParameter("action");
                result = (List<String>) session.getAttribute("LIST");
                answer = (String[]) session.getAttribute("Correct");
                int total = result.size();
                if (action.equals("Back")) {
                    pageCount -= 1;
                    if (pageCount <= 0) {
                        pageCount = total;

                    }
                } else if (action.equals("Next")) {
                    pageCount += 1;
                    if (pageCount > total) {
                        pageCount = 1;
                    }
                }

//                 Calculate completion of Quiz
                String ans = request.getParameter("txtAns");
                if (action.equals("Next")) {
                    if (ans != null) {
                        answer[pageCount - 2] = ans;
                    } else {
                        answer[pageCount - 2] = "";
                    }
                } else if (action.equals("Back")) {
                    if (ans != null) {
                        answer[pageCount] = ans;
                    } else {
                        answer[pageCount] = "";
                    }
                }

                int count = 0;
                for (int i = 0; i < answer.length; i++) {
                    if (answer[i] != "" && answer[i] != null) {
                        count++;
                    }
                }
                request.setAttribute("Done", count);
                request.setAttribute("Total", total);
                request.setAttribute("SubName", subName);
                QuestionDTO dto = dao.findQuestion(result.get(pageCount - 1));
                request.setAttribute("QUESTION", dto);
                request.setAttribute("Count", pageCount);
                request.setAttribute("Answer", answer);
                request.setAttribute("Id", id);
                if (action.equals("Submit")) {
                    if (ans != null) {
                        answer[pageCount - 1] = ans;
                    } else {
                        answer[pageCount - 1] = "";
                    }
                    for (int i = 0; i < answer.length; i++) {
                        if (answer[i] == null) {
                            answer[i] = "";
                        }
                    }
                    subName = request.getParameter("txtSubName");
                    total = answer.length;
                    request.setAttribute("SubId", id);
                    request.setAttribute("SubName", subName);
                    request.setAttribute("RESULT", answer);
                    request.setAttribute("LIST", result);
                    request.setAttribute("Total", total);
                    url = DONE;
                }

            }
        } catch (Exception e) {
            log("ERROR at QuizController: " + e.getMessage());
            LOGGER.error("ERROR at QuizController: " + e.getMessage());
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
