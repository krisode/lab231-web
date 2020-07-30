/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package huyttd.filters;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 *
 * @author KRIS
 */
public class RoleFilter implements Filter {

    private static final boolean debug = true;
    private static final String LOGIN = "/index.jsp";
    private static final String HOME = "/admin.jsp";
//    private static final String
//    private static final String
//    private static final String
//    private static final String
//    private static final String

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public RoleFilter() {
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("RoleFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("RoleFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        String url = "";
        HttpServletRequest req = (HttpServletRequest) request;
        HttpSession session = req.getSession();
        boolean dispatcher = false;
        String role = (String) session.getAttribute("Role");
        String uri = req.getRequestURI();
        String resource = uri.substring(uri.lastIndexOf("/") + 1);
        String action = req.getParameter("action");
        if (role == null) {
            if (action == null) {
                dispatcher = true;
                url = LOGIN;
            } else if (resource.length() > 0 && resource.contains("MainController")) {
                if (!action.equals("Login") && !(action.equals("Register")) && !(action.equals("Verify"))) {
                    dispatcher = true;
                    url = LOGIN;
                }
            } else if (resource.length() > 0 && !resource.contains("LoginController")
                    && !resource.contains("RegisterController")) {
                dispatcher = true;
                url = LOGIN;
            }
        } else if (role.equals("admin")) {
            if (resource.contains("quiz.jsp") || resource.contains("result.jsp") || resource.contains("takeQuiz.jsp")
                    || resource.contains("QuizController") || resource.contains("QuizDetailController")
                    || resource.contains("QuizMainController") || resource.contains("ResultController")
                    || resource.contains("TakeQuizController") || resource.contains("VerifyController")
                    || resource.contains("verify.jsp") || resource.contains("index.jsp")) {
                dispatcher = true;
                url = HOME;
            }
        } else if (role.equals("student")) {
            if (resource.contains("CreateQuestionController") || resource.contains("DeleteQuestionController")
                    || resource.contains("EditQuestionController") || resource.contains("QuestionMainController")
                    || resource.contains("SearchQuestionController") || resource.contains("UpdateQuestionController")
                    || resource.contains("searchQuiz.jsp") || resource.contains("createQuiz.jsp") || resource.contains("verify.jsp")
                    || resource.contains("updateQuiz.jsp") || resource.contains("index.jsp") || resource.contains("VerifyController")) {
                dispatcher = true;
                url = HOME;
            }
        }

        if (resource.lastIndexOf(".jsp") > 0 || resource.lastIndexOf(".css") > 0 || resource.lastIndexOf(".js") > 0
                || resource.lastIndexOf(".fonts") > 0
                || resource.lastIndexOf(".images") > 0 || resource.lastIndexOf(".vendor") > 0
                || resource.lastIndexOf(".jpg") > 0
                || resource.lastIndexOf(".png") > 0 || resource.lastIndexOf(".ico") > 0
                || resource.lastIndexOf(".scss") > 0
                || resource.lastIndexOf(".eot") > 0 || resource.lastIndexOf(".svg") > 0
                || resource.lastIndexOf(".ttf") > 0
                || resource.lastIndexOf(".woff") > 0 || resource.lastIndexOf(".html") > 0) {
            url = resource;
        }
        if (!dispatcher) {
            chain.doFilter(request, response);
        } else {
            request.getRequestDispatcher(url).forward(request, response);

        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("RoleFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("RoleFilter()");
        }
        StringBuffer sb = new StringBuffer("RoleFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
