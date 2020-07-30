<%-- 
    Document   : verify
    Created on : May 21, 2020, 9:04:16 PM
    Author     : KRIS
--%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body onload="checkCode()">
        <h1>Verify</h1>
        <form action="VerifyAction" method="POST">
            Verify: <input type="text" name="code"/>
            <input type="submit" value="Verify"/>
        </form>
    </body>
</html>

<script>
    function checkCode() {
    <s:if test="%{#request.ERROR != null}">
        alert('<s:property value="%{#request.ERROR}"/>');
    </s:if>
    }

</script>

