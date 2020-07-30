/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.actions;

import com.opensymphony.xwork2.ActionContext;
import java.util.Map;
import org.apache.log4j.Logger;

/**
 *
 * @author KRIS
 */
public class LogoutAction {

    private static final String ERROR = "error";
    private static final String SUCCESS = "success";
    private static final Logger LOGGER = Logger.getLogger(LogoutAction.class);

    public LogoutAction() {
    }

    public String execute() throws Exception {
        String label = ERROR;
        try {
            Map session = ActionContext.getContext().getSession();
            session.clear();
            label = SUCCESS;
        } catch (Exception e) {
            LOGGER.error("ERROR at LogoutAction: " + e.getMessage());
        } finally {
            return label;
        }
    }

}
