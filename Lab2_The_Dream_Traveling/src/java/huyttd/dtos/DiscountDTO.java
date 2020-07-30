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
public class DiscountDTO implements Serializable {

    private String discountId, name;
    private float percent;
    private Date expiryDate;

    public DiscountDTO() {
    }

    public DiscountDTO(String discountId, String name, float percent, Date expiryDate) {
        this.discountId = discountId;
        this.name = name;
        this.percent = percent;
        this.expiryDate = expiryDate;
    }

    public String getDiscountId() {
        return discountId;
    }

    public void setDiscountId(String discountId) {
        this.discountId = discountId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getPercent() {
        return percent;
    }

    public void setPercent(float percent) {
        this.percent = percent;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

}
