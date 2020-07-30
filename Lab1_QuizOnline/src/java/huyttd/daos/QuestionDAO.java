/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.daos;

import huyttd.dtos.QuestionDTO;
import huyttd.dtos.QuizDTO;
import huyttd.dtos.SubjectDTO;
import huyttd.utils.DBConnection;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 *
 * @author KRIS
 */
public class QuestionDAO implements Serializable {

    private Connection conn;
    private PreparedStatement preStm;
    private ResultSet rs;

    public QuestionDAO() {
    }

    public void closeConnection() throws Exception {
        if (conn != null) {
            conn.close();
        }
        if (preStm != null) {
            preStm.close();
        }
        if (rs != null) {
            rs.close();
        }
    }

    public ArrayList<QuestionDTO> getQuestionByName(String search, int pageCount) throws Exception {
        ArrayList<QuestionDTO> result = new ArrayList<>();
        QuestionDTO dto = null;
        try {
            String sql = "SELECT top(20) q.IdQuestion, q.Question, q.Answer1, q.Answer2, q.Answer3, q.Answer4, q.CorrectAnswer, \n"
                    + "q.[Date], q.IdSubject, q.QuesStatus FROM Question as q\n"
                    + "WHERE q.Question LIKE ? AND q.IdQuestion NOT IN \n"
                    + "(SELECT TOP(?) Question.IdQuestion FROM Question WHERE Question.Question LIKE ? Order by Question.Question)\n"
                    + "order by q.Question";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + search + "%");
            preStm.setInt(2, (pageCount - 1) * 20);
            preStm.setString(3, "%" + search + "%");
            rs = preStm.executeQuery();
            while (rs.next()) {
                String id = rs.getString("IdQuestion");
                String content = rs.getString("Question");
                String ans1 = rs.getString("Answer1");
                String ans2 = rs.getString("Answer2");
                String ans3 = rs.getString("Answer3");
                String ans4 = rs.getString("Answer4");
                String correctAns = rs.getString("CorrectAnswer");
                String subjectId = rs.getString("IdSubject");
                Date date = rs.getDate("Date");
                boolean status = rs.getBoolean("QuesStatus");
                dto = new QuestionDTO(id, content, ans1, ans2, ans3, ans4, correctAns, subjectId, date, status);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public ArrayList<QuestionDTO> getQuestionByStatus(String search, int pageCount) throws Exception {
        ArrayList<QuestionDTO> result = new ArrayList<>();
        QuestionDTO dto = null;
        boolean questStatus;

        if (search.toUpperCase().equals("ACTIVE")) {
            questStatus = true;
        } else if (search.toUpperCase().equals("DEACTIVE")) {
            questStatus = false;
        } else {
            return result = new ArrayList<>();
        }

        try {
            String sql = "SELECT top(20) q.IdQuestion, q.Question, q.Answer1, q.Answer2, q.Answer3, q.Answer4, q.CorrectAnswer, \n"
                    + "q.[Date], q.IdSubject, q.QuesStatus FROM Question as q\n"
                    + "WHERE q.QuesStatus = ? AND q.IdQuestion NOT IN \n"
                    + "(SELECT TOP(?) Question.IdQuestion FROM Question WHERE Question.QuesStatus = ? Order by Question.Question)\n"
                    + "order by q.Question";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setBoolean(1, questStatus);
            preStm.setInt(2, (pageCount - 1) * 20);
            preStm.setBoolean(3, questStatus);
            rs = preStm.executeQuery();
            while (rs.next()) {
                String id = rs.getString("IdQuestion");
                String content = rs.getString("Question");
                String ans1 = rs.getString("Answer1");
                String ans2 = rs.getString("Answer2");
                String ans3 = rs.getString("Answer3");
                String ans4 = rs.getString("Answer4");
                String correctAns = rs.getString("CorrectAnswer");
                String subjectId = rs.getString("IdSubject");
                Date date = rs.getDate("Date");
                boolean status = rs.getBoolean("QuesStatus");
                dto = new QuestionDTO(id, content, ans1, ans2, ans3, ans4, correctAns, subjectId, date, status);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public ArrayList<QuestionDTO> getQuestionBySubject(String search, int pageCount) throws Exception {
        ArrayList<QuestionDTO> result = new ArrayList<>();
        QuestionDTO dto = null;
        try {
            String sql = "SELECT top(20) q.IdQuestion, q.Question, q.Answer1, q.Answer2, q.Answer3, q.Answer4, q.CorrectAnswer, \n"
                    + "q.[Date], q.IdSubject, q.QuesStatus FROM Question as q\n"
                    + "WHERE q.IdSubject LIKE ? AND q.IdQuestion NOT IN \n"
                    + "(SELECT TOP(?) Question.IdQuestion FROM Question WHERE Question.IdSubject LIKE ? Order by Question.Question)\n"
                    + "order by q.Question";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + search + "%");
            preStm.setInt(2, (pageCount - 1) * 20);
            preStm.setString(3, "%" + search + "%");
            rs = preStm.executeQuery();
            while (rs.next()) {
                String id = rs.getString("IdQuestion");
                String content = rs.getString("Question");
                String ans1 = rs.getString("Answer1");
                String ans2 = rs.getString("Answer2");
                String ans3 = rs.getString("Answer3");
                String ans4 = rs.getString("Answer4");
                String correctAns = rs.getString("CorrectAnswer");
                String subjectId = rs.getString("IdSubject");
                Date date = rs.getDate("Date");
                boolean status = rs.getBoolean("QuesStatus");
                dto = new QuestionDTO(id, content, ans1, ans2, ans3, ans4, correctAns, subjectId, date, status);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public double getTotalPage(String search, String category) throws Exception {
        double total = 0;
        String sql = null;
        try {
            if (category.equals("Question Name")) {
                sql = "Select count(Question.IdQuestion) as 'Number' From Question where Question LIKE ?";
            } else if (category.equals("Subject")) {
                sql = "Select count(Question.IdQuestion) as 'Number' From Question where IdSubject LIKE ?";
            } else if (category.equals("Status")) {
                sql = "Select count(Question.IdQuestion) as 'Number' From Question where QuesStatus = ?";
            }
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            if (category.equals("Status")) {
                boolean questStatus = true;
                if (search.toUpperCase().equals("DEACTIVE")) {
                    questStatus = false;
                }
                preStm.setBoolean(1, questStatus);
            } else {
                preStm.setString(1, "%" + search + "%");
            }
            rs = preStm.executeQuery();
            if (rs.next()) {
                total = Math.ceil(rs.getDouble("Number") / 20);
            }
        } finally {
            closeConnection();
        }
        return total;
    }

    public boolean create(QuestionDTO dto) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT INTO Question(IdQuestion, Question, Answer1, Answer2, Answer3, Answer4, CorrectAnswer, IdSubject, QuesStatus) "
                    + "VALUES(?,?,?,?,?,?,?,?,?)";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getId());
            preStm.setString(2, dto.getContent());
            preStm.setString(3, dto.getAns1());
            preStm.setString(4, dto.getAns2());
            preStm.setString(5, dto.getAns3());
            preStm.setString(6, dto.getAns4());
            preStm.setString(7, dto.getCorrectAns());
            preStm.setString(8, dto.getSubjectId());
            preStm.setBoolean(9, dto.getStatus());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean getId(String id) throws Exception {
        boolean check = false;
        try {
            String sql = "SELECT IdQuestion FROM Question WHERE IdQuestion = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, id);
            rs = preStm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public QuestionDTO findQuestion(String id) throws Exception {
        QuestionDTO dto = null;
        try {
            String sql = "SELECT q.IdQuestion, q.Question, q.Answer1, q.Answer2, q.Answer3, q.Answer4, q.CorrectAnswer, \n"
                    + "q.[Date], q.IdSubject, q.QuesStatus FROM Question as q\n"
                    + "WHERE q.IdQuestion = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, id);
            rs = preStm.executeQuery();
            if (rs.next()) {
                String content = rs.getString("Question");
                String ans1 = rs.getString("Answer1");
                String ans2 = rs.getString("Answer2");
                String ans3 = rs.getString("Answer3");
                String ans4 = rs.getString("Answer4");
                String correctAns = rs.getString("CorrectAnswer");
                String subjectId = rs.getString("IdSubject");
                Date date = rs.getDate("Date");
                boolean status = rs.getBoolean("QuesStatus");
                dto = new QuestionDTO(id, content, ans1, ans2, ans3, ans4, correctAns, subjectId, date, status);
            }
        } finally {
            closeConnection();
        }
        return dto;
    }

    public ArrayList<SubjectDTO> getSubject() throws Exception {
        ArrayList<SubjectDTO> result = new ArrayList<>();
        SubjectDTO dto = null;
        try {
            String sql = "SELECT IdSubject, NameSubject FROM Subject";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            while (rs.next()) {
                String id = rs.getString("IdSubject");
                String name = rs.getString("NameSubject");
                dto = new SubjectDTO(id, name);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }

        return result;
    }

    public boolean update(QuestionDTO dto) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE Question SET Question = ? , Answer1 = ?, Answer2 = ?, Answer3 = ?, Answer4 = ?, CorrectAnswer = ?, IdSubject = ?, QuesStatus = ? WHERE IdQuestion = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, dto.getContent());
            preStm.setString(2, dto.getAns1());
            preStm.setString(3, dto.getAns2());
            preStm.setString(4, dto.getAns3());
            preStm.setString(5, dto.getAns4());
            preStm.setString(6, dto.getCorrectAns());
            preStm.setString(7, dto.getSubjectId());
            preStm.setBoolean(8, dto.getStatus());
            preStm.setString(9, dto.getId());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean delete(String id) throws Exception {
        boolean check = false;
        try {
            String sql = "UPDATE Question SET QuesStatus = ? WHERE IdQuestion = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setBoolean(1, false);
            preStm.setString(2, id);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<SubjectDTO> getSubjectList() throws Exception {
        List<SubjectDTO> result = new ArrayList<>();
        SubjectDTO dto = null;
        try {
            String sql = "SELECT IdSubject, NameSubject, NumQuestion, Time FROM Subject WHERE SubStatus = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setBoolean(1, true);
            rs = preStm.executeQuery();
            while (rs.next()) {
                String id = rs.getString("IdSubject");
                String name = rs.getString("NameSubject");
                int number = rs.getInt("NumQuestion");
                Time time = rs.getTime("Time");
                dto = new SubjectDTO(id, name, number, time);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public List<String> getRandomQuestion(String id, int number) throws Exception {
        List<String> result = new ArrayList<>();
        try {
            String sql = "Select TOP(?) Question.IdQuestion FROM Question WHERE QuesStatus = 1 and IdSubject= ? ORDER BY NEWID()";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, number);
            preStm.setString(2, id);
            rs = preStm.executeQuery();
            while (rs.next()) {
                String question = rs.getString("IdQuestion");
                result.add(question);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean startQuiz(String username, String subId) throws Exception {
        boolean check = false;
        try {
            String sql = "INSERT INTO QuizDetail(Email, IdSubject) VALUES(?,?)";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, username);
            preStm.setString(2, subId);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public int getResult(String[] answer, String subId, List<String> question) throws Exception {
        int result = 0;
        try {
            conn = DBConnection.makeConnection();
            for (int i = 0; i < answer.length; i++) {
                String sql = "SELECT CorrectAnswer FROM Question WHERE IdQuestion = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, question.get(i));
                rs = preStm.executeQuery();
                if (rs.next()) {
                    String correctAnswer = rs.getString("CorrectAnswer");
                    if (answer[i].equals(correctAnswer)) {
                        result++;
                    }
                }
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean finishQuiz(String username, float score, String finishTime) throws Exception {
        boolean check = false;
        try {
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            String sql = "UPDATE QuizDetail SET Score = ?, FinishTime = ? WHERE Score IS NULL AND Email = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setFloat(1, score);
            preStm.setTimestamp(2, timestamp);
            preStm.setString(3, username);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<QuizDTO> getQuizHistory(String username, String subId) throws Exception {
        List<QuizDTO> result = new ArrayList<>();
        QuizDTO dto = null;
        try {
            String sql = "SELECT Score, IdQuiz, DoingDate, FinishTime FROM QuizDetail WHERE Email = ? AND IdSubject = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, username);
            preStm.setString(2, subId);
            rs = preStm.executeQuery();
            while (rs.next()) {
                float score = rs.getFloat("Score");
                int id = rs.getInt("IdQuiz");
                Date doingDate = rs.getDate("DoingDate");
                Date finishDate = rs.getDate("FinishTime");
                dto = new QuizDTO(username, score, id, doingDate, subId, finishDate);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public double getDetailTotalPage(String category, String username) throws Exception {
        double total = 0;
        try {
            String sql = "SELECT Count(IdQuiz) as 'Number' FROM QuizDetail  WHERE IdSubject = ? AND Email = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, category);
            preStm.setString(2, username);
            rs = preStm.executeQuery();
            if (rs.next()) {
                total = Math.ceil(rs.getDouble("Number") / 5);
            }
        } finally {
            closeConnection();
        }
        return total;
    }

    public List<QuizDTO> getHistoryBySubject(String username, String subId, int pageCount) throws Exception {
        List<QuizDTO> result = new ArrayList<>();
        QuizDTO dto = null;
        try {
            String sql = "SELECT top(5) q.Email, q.Score, q.IdQuiz, q.DoingDate, q.FinishTime FROM QuizDetail as q\n"
                    + "WHERE q.IdSubject = ? AND q.Email = ?  AND q.IdQuiz NOT IN \n"
                    + "(SELECT TOP(?) IdQuiz FROM QuizDetail WHERE IdSubject = ? AND Email = ? ORDER BY IdQuiz DESC) ORDER BY IdQuiz DESC";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, subId);
            preStm.setString(2, username);
            preStm.setInt(3, (pageCount - 1) * 5);
            preStm.setString(4, subId);
            preStm.setString(5, username);
            rs = preStm.executeQuery();
            while (rs.next()) {
                float score = rs.getFloat("Score");
                int idQuiz = rs.getInt("IdQuiz");
                Date doingDate = rs.getDate("DoingDate");
                Date finishDate = rs.getDate("FinishTime");
                dto = new QuizDTO(username, score, idQuiz, doingDate, subId, finishDate);
                result.add(dto);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public String getQuizTime(String subId) throws Exception {
        String result = "";
        try {
            String sql = "SELECT Time FROM Subject WHERE IdSubject = ?";
            conn = DBConnection.makeConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, subId);
            rs = preStm.executeQuery();
            if (rs.next()) {
                Time time = rs.getTime("Time");
                SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
                String format = sdf.format(time);
                String[] timeString = format.split(":");
                int hour = Integer.parseInt(timeString[0]);
                int minute = Integer.parseInt(timeString[1]);
                int second = Integer.parseInt(timeString[2]);
                int total = hour * 3600 + minute * 60 + second;
                Date current = new Date(System.currentTimeMillis());
                Calendar c = Calendar.getInstance();
                sdf = new SimpleDateFormat("MMMM dd, yyyy HH:mm:ss");
                c.setTime(current);
                c.add(Calendar.SECOND, total);
                java.util.Date afterPlus = c.getTime();
                result = sdf.format(afterPlus);
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
