<%-- 
    Document   : verify
    Created on : May 21, 2020, 9:04:16 PM
    Author     : KRIS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body onload="checkCode()">
        <h1>Verify</h1>
        <form action="MainController" method="POST">
            Verify: <input type="text" name="txtVerify"/>
            <input type="submit" name="action" value="Verify"/>
            <input type="hidden" name="txtUsername" value="${param.txtUsername}"/>
            <input type="hidden" name="txtPassword" value="${param.txtPassword}"/>
        </form>
    </body>
</html>

<script>
    function checkCode() {
    <% String error = (String) request.getAttribute("ERROR");
        if (error != null) {
    %>
        alert('<%= error%>');
    <%
        }
    %>


    }

</script>

