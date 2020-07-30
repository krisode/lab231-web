/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.dtos;

import java.io.Serializable;
import java.sql.Time;

/**
 *
 * @author KRIS
 */
public class SubjectDTO implements Serializable {

    private String id;
    private String name;
    private boolean status;
    private int noQuestion;
    private Time timeTaken;

    public SubjectDTO() {
    }

    public SubjectDTO(String id, String name) {
        this.id = id;
        this.name = name;
    }

    public SubjectDTO(String id, String name, int noQuestion, Time timeTaken) {
        this.id = id;
        this.name = name;
        this.noQuestion = noQuestion;
        this.timeTaken = timeTaken;
    }

    public SubjectDTO(String id, String name, boolean status, int noQuestion, Time timeTaken) {
        this.id = id;
        this.name = name;
        this.status = status;
        this.noQuestion = noQuestion;
        this.timeTaken = timeTaken;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getNoQuestion() {
        return noQuestion;
    }

    public void setNoQuestion(int noQuestion) {
        this.noQuestion = noQuestion;
    }

    public Time getTimeTaken() {
        return timeTaken;
    }

    public void setTimeTaken(Time timeTaken) {
        this.timeTaken = timeTaken;
    }

    @Override
    public String toString() {
        return id + "-" + name;
    }

}
