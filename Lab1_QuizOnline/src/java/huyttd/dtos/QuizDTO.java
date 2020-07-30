/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author KRIS
 */
public class QuizDTO implements Serializable {

    private String username;
    private float score;
    private int id;
    private Date doingDate;
    private String subId;
    private Date finishDate;

    public QuizDTO() {
    }

    public QuizDTO(String username, float score, int id, Date doingDate, String subId, Date finishDate) {
        this.username = username;
        this.score = score;
        this.id = id;
        this.doingDate = doingDate;
        this.subId = subId;
        this.finishDate = finishDate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDoingDate() {
        return doingDate;
    }

    public void setDoingDate(Date doingDate) {
        this.doingDate = doingDate;
    }

    public String getSubId() {
        return subId;
    }

    public void setSubId(String subId) {
        this.subId = subId;
    }

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }

}
