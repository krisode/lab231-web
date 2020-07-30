/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.question_controllers;

import huyttd.daos.QuestionDAO;
import huyttd.dtos.QuestionDTO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

public class SearchQuestionController extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(SearchQuestionController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "searchQuiz.jsp";
        int count = 1;
        ArrayList<QuestionDTO> result = new ArrayList<>();
        try {
            String search = request.getParameter("txtSearch");
            String category = request.getParameter("txtChoice");
            String pageCount = request.getParameter("txtCount");
            int page = 1;
            if (pageCount != null) {
                page = Integer.parseInt(pageCount);
            }
            String next = request.getParameter("txtNext");
            String previous = request.getParameter("txtPrevious");
            QuestionDAO dao = new QuestionDAO();
            int total = (int) dao.getTotalPage(search, category);

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
                if (category.equals("Question Name")) {
                    result = dao.getQuestionByName(search, page);
                } else if (category.equals("Status")) {
                    result = dao.getQuestionByStatus(search, page);
                } else if (category.equals("Subject")) {
                    result = dao.getQuestionBySubject(search, page);
                }
            } else {
                if (category.equals("Question Name")) {
                    result = dao.getQuestionByName(search, count);
                } else if (category.equals("Status")) {
                    result = dao.getQuestionByStatus(search, count);
                } else if (category.equals("Subject")) {
                    result = dao.getQuestionBySubject(search, count);
                }
            }
            request.setAttribute("LIST", result);
            if (pageCount != null) {
                request.setAttribute("Count", page);
            } else {
                request.setAttribute("Count", 1);
            }
            request.setAttribute("Total", total);
            request.setAttribute("Search", search);
            request.setAttribute("category", category);
        } catch (Exception e) {
            log("ERROR at SearchQuestionController: " + e.getMessage());
            LOGGER.error("ERROR at SearchQuestionController: " + e.getMessage());
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
