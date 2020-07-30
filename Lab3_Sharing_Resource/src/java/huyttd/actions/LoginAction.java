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
import huyttd.utils.GoogleUtils;
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
public class LoginAction {

    private static final String ERROR = "error";
    private static final String SUCCESS = "success";
    private static final String VERIFY = "verify";
    private static final Logger LOGGER = Logger.getLogger(LoginAction.class);

    private String username, password, code, recaptchaResult;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getRecaptchaResult() {
        return recaptchaResult;
    }

    public void setRecaptchaResult(String recaptchaResult) {
        this.recaptchaResult = recaptchaResult;
    }

    public LoginAction() {
    }

    public String execute() throws Exception {
        String label = ERROR;
        try {
            HttpServletRequest req = ServletActionContext.getRequest();
            RegistrationDAO dao = new RegistrationDAO();
            ResourceDAO resourceDAO = new ResourceDAO();
            List<CategoryDTO> result = new ArrayList<>();
            RegistrationDTO dto = dao.getUser(username);
            int role = dao.checkLogin(username, password);
            int status = dao.checkStatus(username);
            if (code != null) {
                String accessToken = GoogleUtils.getToken(code);
                RegistrationDTO googleDTO = GoogleUtils.getUserInfo(accessToken);
                if (!dao.checkDuplicate(googleDTO.getEmail())) {
                    dao.register(googleDTO);
                }
                googleDTO = dao.getUser(googleDTO.getEmail());
                result = resourceDAO.getCategory(googleDTO.getRole());
                Map session = ActionContext.getContext().getSession();
                session.put("DTO", googleDTO);
                session.put("listCategory", result);
                label = SUCCESS;
            } else {
                if (recaptchaResult.equals("False")) {
                    req.setAttribute("ERROR", "ReCaptcha is missing");
                    return ERROR;
                }
                if (role == 0) {
                    req.setAttribute("ERROR", "Invalid username or password!!!");
                    req.setAttribute("Username", username);
                } else if (role != 0) {
                    if (status == 1) {
                        if (role != 1) {
                            result = resourceDAO.getCategory(dto.getRole());
                        }
                        Map session = ActionContext.getContext().getSession();
                        session.put("DTO", dto);
                        session.put("listCategory", result);
                        label = SUCCESS;
                    } else if (status == 2) {
                        req.setAttribute("ERROR", "Your account has been disabled");
                    } else if (status == 3) {
                        Map session = ActionContext.getContext().getSession();
                        session.put("Username", username);
                        session.put("Password", password);
                        label = VERIFY;
                    }
                } else {
                    req.setAttribute("ERROR", "Your role is invalid");
                }
            }
        } catch (Exception e) {
            LOGGER.error("ERROR at LoginAction: " + e.getMessage());
        } finally {
            return label;
        }
    }
}
