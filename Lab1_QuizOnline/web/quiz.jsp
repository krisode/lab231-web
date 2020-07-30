<%-- 
    Document   : quiz
    Created on : May 29, 2020, 9:10:48 PM
    Author     : KRIS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="author" content="colorlib.com">
        <link href="https://fonts.googleapis.com/css?family=Poppins:400,500,700" rel="stylesheet" />
        <link href="CSS/main.css" rel="stylesheet" />

        <link rel="icon" type="image/png" href="Image/icons/favicon.ico"/>

        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="CSS/util.css">
        <link rel="stylesheet" type="text/css" href="CSS/mainTable.css">
    </head>
    <body onload="callTable()">
        <div class="s013">
            <form action="QuizMainController" method="POST">
                <fieldset>
                    <legend>QUIZ MANAGEMENT</legend>
                    <a href="admin.jsp" style="padding-left: 350px; font-size: 20px; color: #FFF" onmouseover="this.style.color = 'black'" onmouseout="this.style.color = '#FFF'"><< Back to Home Page >></a>
                </fieldset>
                <div class="inner-form">
                    <input style="min-width: 300px;" id="search" class="btn-search" type="submit" name="action" value="Take Quiz"/>
                    <input id="view" style="min-width: 300px;" class="btn-search" type="button" value="View Quiz History"/>
                    <input id="submit" style="display: none" type="submit" name="action" value="View"/>
                    <select id="select" name="txtChoice" style=" display: none; margin-top: 50px;padding-left: 10px;padding-right: 10px;margin-left: 10px;">Choose:
                        <option></option>
                        <c:forEach items="${sessionScope.SUBJECT}" var="dto">
                            <option>${dto.id}</option>
                        </c:forEach>
                    </select>
                </div>

            </form>
        </div>

        <c:if test="${requestScope.LIST != null}" var="check">
            <c:if test="${not empty requestScope.LIST}" var="checkList">
                <div id="table" class="limiter">
                    <div class="container-table100">
                        <div class="wrap-table100">
                            <div class="table100">
                                <table>
                                    <thead>
                                        <tr class="table100-head" style="text-align: center">
                                            <th class="column1">No</th>
                                            <th class="column1">ID</th>
                                            <th class="column1">Name</th>
                                            <th class="column1">Number of question</th>
                                            <th class="column1">Time taken</th>
                                            <th class="column1"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.LIST}" var="dto" varStatus="counter">
                                            <tr>
                                                <td style="text-align: center">${counter.count}</td>
                                                <td style="text-align: center">${dto.id}</td>
                                                <td style="text-align: center;">${dto.name}</td>
                                                <td style="text-align: center">${dto.noQuestion}</td>
                                                <td style="text-align: center">${dto.timeTaken}</td>
                                                <td>

                                                    <form action="QuizMainController" method="POST" style="text-align: -webkit-center;">
                                                        <input type="hidden" name="txtId" value="${dto.id}"/>
                                                        <input type="hidden" name="txtName" value="${dto.name}"/>
                                                        <input type="hidden" name="txtNo" value="${dto.noQuestion}"/>
                                                        <input type="submit" name="action" value="Start Quiz" style="color:#FFF; padding: 8px 15px 8px 15px; cursor: pointer; background-color: blueviolet; -webkit-border-radius: 3px;
                                                               -moz-border-radius: 3px;
                                                               border-radius: 3px;"/>
                                                    </form>

                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>   
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${requestScope.LIST != null and fn:length(LIST) == 0}">
            <div id="table" class="limiter">
                <div class="container-table100">
                    <div class="wrap-table100">
                        <div class="table100">
                            <table>
                                <thead>
                                    <tr class="table100-head" style="text-align: center">
                                        <th class="column1">AVAILABLE QUIZ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td style="text-align: center">NO RECORD</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>  
        <c:if test="${requestScope.HISTORY != null}">
            <c:if test="${not empty requestScope.HISTORY}" var="checkHistory">
                <div id="table" class="limiter">
                    <div class="container-table100">
                        <div class="wrap-table100">
                            <div class="table100">
                                <table>
                                    <thead>
                                        <tr class="table100-head" style="text-align: center">
                                            <th class="column1">No</th>
                                            <th class="column1">Email</th>
                                            <th class="column1">Subject ID</th>
                                            <th class="column1">Taken Date</th>
                                            <th class="column1">Finish</th>
                                            <th class="column1">Score</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.HISTORY}" var="dto" varStatus="counter">
                                            <tr>
                                                <td style="text-align: center">${counter.count}</td>
                                                <td style="text-align: center">${dto.username}</td>
                                                <td style="text-align: center;">${dto.subId}</td>
                                                <td style="text-align: center">${dto.doingDate}</td>
                                                <td style="text-align: center">${dto.finishDate}</td>
                                                <td style="text-align: center">${dto.score}</td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <form>
                                    <div class="fixed-table-pagination">
                                        <div class="pull-left pagination-detail">
                                            <span class="pagination-info" style="color: #FFF">Showing <c:if test="${requestScope.Count != null}" var="checkCount">${requestScope.Count}</c:if> <c:if test="${!checkCount}">1</c:if> out of ${requestScope.Total} total pages</span>
                                            </div>
                                            <div class="pull-right pagination">
                                                <ul class="pagination">
                                                        <li class="page-pre"><a href="QuizDetailController?txtCount=${requestScope.Count}&txtChoice=${requestScope.category}&txtPrevious=previous" style="color: #FFF">‹</a></li>
                                                    <c:forEach var="i" begin="1" end="${requestScope.Total}">
                                                    <li style="padding-right: 5px; padding-left: 5px" class="page-number active"><a  style="color: #FFF" href="QuizDetailController?txtCount=${i}&txtChoice=${requestScope.category}">${i}</a></li>
                                                    </c:forEach>
                                                <li class="page-next"><a href="QuizDetailController?txtCount=${requestScope.Count}&txtChoice=${requestScope.category}&txtNext=next" style="color: #FFF">›</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${requestScope.HISTORY != null and fn:length(HISTORY) == 0}">
            <div id="table" class="limiter">
                <div class="container-table100">
                    <div class="wrap-table100">
                        <div class="table100">
                            <table>
                                <thead>
                                    <tr class="table100-head" style="text-align: center">
                                        <th class="column1">HISTORY</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td style="text-align: center">NO RECORD</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>



        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="js/mainTable.js"></script>

        <script src="js/extention/choices.js"></script>
        <script>
                        const choices = new Choices('[data-trigger]',
                                {
                                    searchEnabled: false,
                                    itemSelectText: '',
                                });

                        function callTable() {
                            var table = document.getElementById("table");
                            table.scrollIntoView({behavior: 'smooth', block: 'center'});
                        }

                        $("#view").click(function () {
                            $("#select").css("display", "block");
                        });

                        $("#select").change(function () {
                            $("#submit").trigger('click');
                        });






        </script>
    </body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>
