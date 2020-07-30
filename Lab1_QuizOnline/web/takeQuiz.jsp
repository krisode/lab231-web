<%-- 
    Document   : takeQuiz
    Created on : May 29, 2020, 11:47:08 PM
    Author     : KRIS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="CSS/Quiz.css" rel="stylesheet" />
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <style>

        </style>

    </head>
    <body>
        <div class="container-fluid bg-info" style="height: 790px">
            <h5>User: ${sessionScope.Fullname}</h5>
            <h5>Subject: ${requestScope.SubName}</h5>
            <h5>Finished: ${requestScope.Done}/${requestScope.Total}</h5>
            <h5 id="remain"></h5>
            <input id="time" type="hidden" value="${sessionScope.Time}"/>
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3><span class="label label-warning" id="qid">${requestScope.Count}</span> ${requestScope.QUESTION.content}</h3>
                    </div>
                    <form id="myForm" action="QuizController" method="POST">
                        <div class="modal-body">
                            <div class="quiz" id="quiz" data-toggle="buttons">
                                <label ${(requestScope.QUESTION.ans1 eq requestScope.Answer[requestScope.Count-1]) ? 'style="background: green"' : ''} id="label1" class="element-animation1 btn btn-lg btn-primary btn-block"><span class="btn-label"><i class="glyphicon glyphicon-chevron-right"></i></span> <input onclick="isChecked1()" ${(requestScope.QUESTION.ans1 eq requestScope.Answer[requestScope.Count-1]) ? 'checked=""' : ''} type="radio" name="txtAns" value="${requestScope.QUESTION.ans1}">${requestScope.QUESTION.ans1}</label>
                                <label ${(requestScope.QUESTION.ans2 eq requestScope.Answer[requestScope.Count-1]) ? 'style="background: green"' : ''} id="label2" class="element-animation2 btn btn-lg btn-primary btn-block"><span class="btn-label"><i class="glyphicon glyphicon-chevron-right"></i></span> <input onclick="isChecked2()" ${(requestScope.QUESTION.ans2 eq requestScope.Answer[requestScope.Count-1]) ? 'checked=""' : ''} type="radio" name="txtAns" value="${requestScope.QUESTION.ans2}">${requestScope.QUESTION.ans2}</label>
                                <label ${(requestScope.QUESTION.ans3 eq requestScope.Answer[requestScope.Count-1]) ? 'style="background: green"' : ''} id="label3" class="element-animation3 btn btn-lg btn-primary btn-block"><span class="btn-label"><i class="glyphicon glyphicon-chevron-right"></i></span> <input onclick="isChecked3()" ${(requestScope.QUESTION.ans3 eq requestScope.Answer[requestScope.Count-1]) ? 'checked=""' : ''} type="radio" name="txtAns" value="${requestScope.QUESTION.ans3}">${requestScope.QUESTION.ans3}</label>
                                <label ${(requestScope.QUESTION.ans4 eq requestScope.Answer[requestScope.Count-1]) ? 'style="background: green"' : ''} id="label4" class="element-animation4 btn btn-lg btn-primary btn-block"><span class="btn-label"><i class="glyphicon glyphicon-chevron-right"></i></span> <input onclick="isChecked4()" ${(requestScope.QUESTION.ans4 eq requestScope.Answer[requestScope.Count-1]) ? 'checked=""' : ''} type="radio" name="txtAns" value="${requestScope.QUESTION.ans4}">${requestScope.QUESTION.ans4}</label>
                            </div>
                        </div>
                        <div class="modal-footer text-muted" style="padding: 0px;">
                            <span id="answer"></span>
                        </div>

                        <input type="hidden" name="txtCount" value="${requestScope.Count}"/>
                        <input type="hidden" name="txtSubName" value="${requestScope.SubName}"/>
                        <input type="hidden" name="txtId" value="${requestScope.Id}"/>

                        <c:set var="Total" value="${requestScope.Total}"/>
                        <c:if test="${requestScope.Count > 1}" var="check">
                            <input id="back" style="margin: 10px; padding: 5px 20px 5px 20px" type="submit" name="action" value="Back"/>
                            <input hidden="" id="submit" style="float: right; margin: 10px; padding: 5px 20px 5px 20px" type="submit" name="action" value="Submit"/>
                        </c:if>
                        <c:if test="${requestScope.Count < Total}">
                            <input id="next" style="margin:10px; float: right; padding: 5px 20px 5px 20px" type="submit" name="action" value="Next"/>
                            <input hidden="" id="submit" style="float: right; margin: 10px; padding: 5px 20px 5px 20px" type="submit" name="action" value="Submit"/>
                        </c:if>
                        <c:if test="${requestScope.Count >= Total}">
                            <input id="submit" style="float: right; margin: 10px; padding: 5px 20px 5px 20px" type="submit" name="action" value="Submit"/>
                        </c:if>


                    </form>


                    <script>
//                        const btn = document.querySelector('#label');
//                        // handle click button
//                        btn.onclick = function () {
//                            const rbs = document.querySelectorAll('input[name="txtAns"]');
//                            let selectedValue;
//                            for (const rb of rbs) {
//                                if (rb.checked) {
//                                    selectedValue = rb.value;
//                                    break;
//                                }
//                            }
//                            document.getElementById('label').style.backgroundColor = 'pink';
//                        };

                        function isChecked1() {
                            document.getElementById("label1").style.backgroundColor = 'green';
                            document.getElementById("label2").style.backgroundColor = '#428BCA';
                            document.getElementById("label3").style.backgroundColor = '#428BCA';
                            document.getElementById("label4").style.backgroundColor = '#428BCA';
                        }
                        function isChecked2() {
                            document.getElementById("label1").style.backgroundColor = '#428BCA';
                            document.getElementById("label2").style.backgroundColor = 'green';
                            document.getElementById("label3").style.backgroundColor = '#428BCA';
                            document.getElementById("label4").style.backgroundColor = '#428BCA';
                        }
                        function isChecked3() {
                            document.getElementById("label1").style.backgroundColor = '#428BCA';
                            document.getElementById("label2").style.backgroundColor = '#428BCA';
                            document.getElementById("label3").style.backgroundColor = 'green';
                            document.getElementById("label4").style.backgroundColor = '#428BCA';
                        }
                        function isChecked4() {
                            document.getElementById("label1").style.backgroundColor = '#428BCA';
                            document.getElementById("label2").style.backgroundColor = '#428BCA';
                            document.getElementById("label3").style.backgroundColor = '#428BCA';
                            document.getElementById("label4").style.backgroundColor = 'green';
                        }

                        var countDownDate = new Date(document.getElementById("time").value).getTime();

                        // Update the count down every 1 second
                        var x = setInterval(function () {

                            // Get today's date and time
                            var now = new Date().getTime();

                            // Find the distance between now and the count down date
                            var distance = countDownDate - now;

                            // Time calculations for days, hours, minutes and seconds
                            var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                            var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                            var seconds = Math.floor((distance % (1000 * 60)) / 1000);

                            // Output the result in an element with id="demo"
                            document.getElementById("remain").innerHTML = "Time remaining: " + hours + "h "
                                    + minutes + "m " + seconds + "s ";

                            // If the count down is over, write some text 
                            if (distance < 1) {
                                clearInterval(x);
                                $("#submit").trigger("click");
                            }
                        }, 1000);



                    </script>
                </div>

            </div>

        </div>
    </body>


</html>
