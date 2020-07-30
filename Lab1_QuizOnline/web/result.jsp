<%-- 
    Document   : result
    Created on : May 31, 2020, 12:31:14 PM
    Author     : KRIS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="CSS/util.css">
        <link rel="stylesheet" type="text/css" href="CSS/mainTable.css">
    </head>
    <body onload="callTable()">
        <div id="table" class="limiter">
            <div class="container-table100">
                <h2 style="font-size: 30px; color: #FFF"> RESULT </h2>
                <div class="wrap-table100" style="margin-top: -500px">
                    <div class="table100">
                        <table>
                            <thead>
                                <tr class="table100-head" style="text-align: center">
                                    <th class="column1">Subject ID</th>
                                    <th class="column1">Subject Name</th>
                                    <th class="column1">Correct</th>
                                    <th class="column1">Score</th>
                                    <th class="column1"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td style="text-align: center">${requestScope.SubId}</td>
                                    <td style="text-align: center">${requestScope.SubName}</td>
                                    <td style="text-align: center">${requestScope.NoCorrect}/${requestScope.Total}</td>
                                    <td style="text-align: center">${requestScope.Score}</td>
                                    <td>
                                        <a href="quiz.jsp">Back to Home Page</a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>   
                    </div>
                </div>
            </div>
        </div>

        <script>
            function callTable() {
                var table = document.getElementById("table");
                table.scrollIntoView({behavior: 'smooth', block: 'center'});
            }
        </script>
    </body>
</html>
