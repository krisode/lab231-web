/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.quiz_controllers;

import huyttd.daos.QuestionDAO;
import huyttd.dtos.QuizDTO;
import java.io.IOException;
import java.util.ArrayList;
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
public class QuizDetailController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(QuizDetailController.class);
    private static final String SUCCESS = "quiz.jsp";
    private static final String ERROR = "error.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        List<QuizDTO> result = new ArrayList<>();
        try {
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("Username");
            String choice = request.getParameter("txtChoice");

            if (choice != null) {
                String pageCount = request.getParameter("txtCount");
                int page = 1;
                if (pageCount != null) {
                    page = Integer.parseInt(pageCount);
                }
                String next = request.getParameter("txtNext");
                String previous = request.getParameter("txtPrevious");

                QuestionDAO dao = new QuestionDAO();
                int total = (int) dao.getDetailTotalPage(choice, username);
                if (pageCount != null) {
                    if (next != null) {
                        page += 1;
                        if (page > total) {
                            page = 1;
                        }
                    } else if (previous != null) {
                        page -= 1;
                        if (page <= 0) {
                            page = total;
                        }
                    }
                    result = dao.getHistoryBySubject(username, choice, page);
                } else {
                    result = dao.getHistoryBySubject(username, choice, 1);
                }
                if (pageCount != null) {
                    request.setAttribute("Count", page);
                } else {
                    request.setAttribute("Count", page);
                }
//                long timeTaken = (result.get(page).getDoingDate().getTime() - result.get(page).getFinishDate().getTime());
//                int hours = (int) (timeTaken % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60);
//                int minutes = (int) (timeTaken % (1000 * 60 * 60)) / (1000 * 60);
//                int seconds = (int) ((timeTaken % (1000 * 60)) / 1000);
//                String time = (hours + ":" + minutes + ":" + seconds);
//                
//                request.setAttribute("TimeTaken", time);
                request.setAttribute("HISTORY", result);
                request.setAttribute("Total", total);
                request.setAttribute("category", choice);
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("ERROR at QuizDetailController: " + e.getMessage());
            LOGGER.error("ERROR at QuizDetailController: " + e.getMessage());
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
