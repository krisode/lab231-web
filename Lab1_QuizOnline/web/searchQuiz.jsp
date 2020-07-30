<%-- 
    Document   : searchQuiz
    Created on : May 26, 2020, 3:04:21 PM
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
    <body onload="callTable(); checkStatus()">
        <div class="s013">
            <form action="QuestionMainController" method="POST">
                <fieldset>
                    <legend>QUICK FIND QUESTION</legend>
                    <a href="admin.jsp" style="padding-left: 350px; font-size: 20px; color: #FFF" onmouseover="this.style.color = 'black'" onmouseout="this.style.color = '#FFF'"><< Back to Home Page >></a>
                </fieldset>
                <div class="inner-form">
                    <div class="left">
                        <div class="input-wrap first">
                            <div class="input-field first">
                                <label>WHAT</label>
                                <input id="input" type="text" name="txtSearch" value="${requestScope.Search}" placeholder="ex: name, status, subject" />
                            </div>
                        </div>
                        <div class="input-wrap second">
                            <div class="input-field second">
                                <label>CATEGORIES</label>
                                <div class="input-select">
                                    <select id="select" data-trigger="" name="txtChoice">
                                        <c:if test="${requestScope.category != null}" var="check">
                                            <c:if test="${requestScope.category == 'Question Name'}">
                                                <option selected="">Question Name</option>
                                                <option>Status</option>
                                                <option>Subject</option>
                                            </c:if>
                                            <c:if test="${requestScope.category == 'Status'}">
                                                <option>Question Name</option>
                                                <option selected="">Status</option>
                                                <option>Subject</option>
                                            </c:if>
                                            <c:if test="${requestScope.category == 'Subject'}">
                                                <option>Question Name</option>
                                                <option>Status</option>
                                                <option selected="">Subject</option>
                                            </c:if>

                                        </c:if>
                                        <c:if test="${!check}">
                                            <option selected="">Question Name</option>
                                            <option>Status</option>
                                            <option>Subject</option>
                                        </c:if>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <input id="search" class="btn-search" type="submit" name="action" value="Search"/>
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
                                            <th class="column1">ID</th>
                                            <th class="column1">Content</th>
                                            <th class="column1">Answer 1</th>
                                            <th class="column4">Answer 2</th>
                                            <th class="column4">Answer 3</th>
                                            <th class="column4">Answer 4</th>
                                            <th class="column1">Correct Answer</th>
                                            <th class="column1">Subject ID</th>
                                            <th class="column1" style="width: 90px">Date</th>
                                            <th class="column1">Status</th>
                                            <th class="column1">Edit</th>
                                            <th class="column1">Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requestScope.LIST}" var="dto">
                                            <tr>
                                                <td style="text-align: center">${dto.id}</td>
                                                <td style="text-align: center;">${dto.content}</td>
                                                <td style="text-align: center">${dto.ans1}</td>
                                                <td style="text-align: center">${dto.ans2}</td>
                                                <td style="text-align: center">${dto.ans3}</td>
                                                <td style="text-align: center">${dto.ans4}</td>
                                                <td style="text-align: center">${dto.correctAns}</td>
                                                <td style="text-align: center">${dto.subjectId}</td>
                                                <td style="text-align: center;">${dto.date}</td>
                                                <td style="text-align: center">
                                                    <c:if test="${dto.status == 'true'}" var="status">
                                                        Active
                                                    </c:if> 
                                                    <c:if test="${!status}">
                                                        DeActive
                                                    </c:if>    
                                                </td>
                                                <td>
                                                    <div style="padding: 50px 0px;" >
                                                        <form action="EditQuestionController" method="POST" onsubmit="return confirm('Do you want to update this Question?')">
                                                            <input type="hidden" name="txtSearch" value="${requestScope.Search}"/>
                                                            <input type="hidden" name="txtChoice" value="${requestScope.category}"/>
                                                            <input type="hidden" name="txtId" value="${dto.id}"/>
                                                            <input type="submit" name="action" value="Edit" style="color:#FFF; padding: 8px 15px 8px 15px; cursor: pointer; background-color: blueviolet; -webkit-border-radius: 3px;
                                                                   -moz-border-radius: 3px;
                                                                   border-radius: 3px;"/>
                                                        </form>
                                                    </div>
                                                </td>

                                                <td>

                                                    <div style="padding: 50px 4px;" >

                                                        <form action="QuestionMainController" method="POST" onsubmit="return confirm('Do you want to change status of this Question?')" >
                                                            <c:if test="${dto.status == 'true'}" var="status">
                                                                <input type="hidden" name="txtSearch" value="${requestScope.Search}"/>
                                                                <input type="hidden" name="txtChoice" value="${requestScope.category}"/>
                                                                <input type="hidden" name="txtId" value="${dto.id}"/>
                                                                <input type="submit" name="action" value="Delete" style="color: #FFF; padding: 10px 8px 8px 5px; cursor: pointer; background-color: blueviolet; -webkit-border-radius: 3px;
                                                                       -moz-border-radius: 3px;
                                                                       border-radius: 3px;"/>
                                                            </c:if>
                                                            <c:if test="${!status}">
                                                                <input type="hidden" name="txtSearch" value="${requestScope.Search}"/>
                                                                <input type="hidden" name="txtChoice" value="${requestScope.category}"/>
                                                                <input type="hidden" name="txtId" value="${dto.id}"/>
                                                            </c:if>    
                                                        </form>

                                                    </div>

                                                </td>

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
                                                        <li class="page-pre"><a href="SearchQuestionController?txtCount=${requestScope.Count}&txtChoice=${requestScope.category}&txtSearch=${requestScope.Search}&txtPrevious=previous" style="color: #FFF">‹</a></li>
                                                    <c:forEach var="i" begin="1" end="${requestScope.Total}">
                                                    <li style="padding-right: 5px; padding-left: 5px" class="page-number active"><a  style="color: #FFF" href="SearchQuestionController?txtCount=${i}&txtChoice=${requestScope.category}&txtSearch=${requestScope.Search}">${i}</a></li>
                                                    </c:forEach>
                                                <li class="page-next"><a href="SearchQuestionController?txtCount=${requestScope.Count}&txtChoice=${requestScope.category}&txtSearch=${requestScope.Search}&txtNext=next" style="color: #FFF">›</a></li>
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
        <c:if test="${requestScope.LIST != null and fn:length(LIST) == 0}">
            <div id="table" class="limiter">
                <div class="container-table100">
                    <div class="wrap-table100">
                        <div class="table100">
                            <table>
                                <thead>
                                    <tr class="table100-head" style="text-align: center">
                                        <th class="column1">Notice</th>
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
            <c:if test="${requestScope.LIST != null}">
                                                                var table = document.getElementById("table");
                                                                table.scrollIntoView({behavior: 'smooth', block: 'center'});
            </c:if>
                                                            }

                                                            function checkStatus() {
            <c:if test="${requestScope.SUCCESS != null}">
                                                                alert('${requestScope.SUCCESS}');
            </c:if>
            <c:if test="${requestScope.ERROR != null}">
                                                                alert('${requestScope.ERROR}');
            </c:if>
                                                            }

                                                            $("#select").change(function () {
                                                                if (document.getElementById("select").value === 'Question Name') {
                                                                    document.getElementById("input").placeholder = "Enter question name...";
                                                                }
                                                                if (document.getElementById("select").value === 'Status') {
                                                                    document.getElementById("input").placeholder = "Enter active/deactive...";
                                                                }
                                                                if (document.getElementById("select").value === 'Subject') {
                                                                    document.getElementById("input").placeholder = "Enter subject id...";
                                                                }
                                                            });



        </script>
    </body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>
