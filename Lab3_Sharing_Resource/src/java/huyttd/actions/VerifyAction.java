/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.actions;

import com.opensymphony.xwork2.ActionContext;
import huyttd.daos.RegistrationDAO;
import huyttd.daos.ResourceDAO;
import huyttd.dtos.CategoryDTO;
import huyttd.dtos.RegistrationDTO;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author KRIS
 */
public class VerifyAction {

    private static final String ERROR = "error";
    private static final String SUCCESS = "success";
    private static final Logger LOGGER = Logger.getLogger(VerifyAction.class);

    private String username, code;

    public VerifyAction() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String execute() throws Exception {
        String label = ERROR;
        try {
            HttpServletRequest request = ServletActionContext.getRequest();
            Map session = ActionContext.getContext().getSession();
            setUsername((String) session.get("Username"));
            RegistrationDAO dao = new RegistrationDAO();
            ResourceDAO resourceDAO = new ResourceDAO();
            List<CategoryDTO> result = new ArrayList<>();
            String check = dao.checkCode(code, username);
            if (check.equals("failed")) {
                request.setAttribute("ERROR", "Invalid code! Please reinput code the sended code in your email");
            } else if (check.equals("success")) {
                dao.changeStatus(username);
                RegistrationDTO dto = dao.getUser(username);
                result = resourceDAO.getCategory(dto.getRole());
                session.put("DTO", dto);
                session.put("listCategory", result);
                label = SUCCESS;
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at VerifyAction: " + e.getMessage());
        } finally {
            return label;
        }
    }

}
