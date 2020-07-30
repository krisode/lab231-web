<%-- 
    Document   : updateQuiz
    Created on : May 28, 2020, 1:06:22 PM
    Author     : KRIS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quiz Management</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->
        <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="CSS/UserUpdate.css">
        <link rel="stylesheet" type="text/css" href="CSS/UserUpdateFont.css">
        <!--===============================================================================================-->
    </head>
    <body>
        <div class="container-contact100">
            <div class="wrap-contact100">
                <form class="contact100-form validate-form" action="QuestionMainController" method="POST">
                    <span class="contact100-form-title">
                        Update Question
                    </span>

                    <c:if test="${requestScope.QUESTION != null}" var="dto">
                        <div class="wrap-input100 validate-input" data-validate="">
                            <label class="label-input100" for="name">ID</label>
                            <input id="name" class="input100" type="text" name="txtId" value="${requestScope.QUESTION.id}" readonly="true">
                            <span class="focus-input100"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate = "Content is required">
                            <label class="label-input100" for="name">Content</label>
                            <textarea id="email" class="input100" type="text" name="txtContent">${requestScope.QUESTION.content}</textarea> 
                            <span class="focus-input100"></span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate = "Answer 1 is required">
                            <label class="label-input100" for="name">Answer 1</label>
                            <input id="email" class="input100" type="text" name="txtAnswer1" value="${requestScope.QUESTION.ans1}">
                            <span class="focus-input100"></span>
                        </div>
                        <div class="wrap-input100 validate-input" data-validate = "Answer 2 is required">
                            <label class="label-input100" for="name">Answer 2</label>
                            <input id="email" class="input100" type="text" name="txtAnswer2" value="${requestScope.QUESTION.ans2}">
                            <span class="focus-input100"></span>
                        </div>
                        <div class="wrap-input100 validate-input" data-validate = "Answer 3 is required">
                            <label class="label-input100" for="name">Answer 3</label>
                            <input id="email" class="input100" type="text" name="txtAnswer3" value="${requestScope.QUESTION.ans3}">
                            <span class="focus-input100"></span>
                        </div>
                        <div class="wrap-input100 validate-input" data-validate = "Answer 4 is required">
                            <label class="label-input100" for="name">Answer 4</label>
                            <input id="email" class="input100" type="text" name="txtAnswer4" value="${requestScope.QUESTION.ans4}">
                            <span class="focus-input100"></span>
                        </div>

                        <div class="wrap-input100">
                            <div class="label-input100">Result: </div>
                            <div>
                                <select class="js-select2" name="txtCorrect">
                                    <c:if test="${requestScope.Correct == 'Answer1'}">
                                        <option selected="">Answer 1</option>
                                        <option>Answer 2</option>
                                        <option>Answer 3</option>
                                        <option>Answer 4</option>
                                    </c:if>
                                    <c:if test="${requestScope.Correct == 'Answer2'}">
                                        <option>Answer 1</option>
                                        <option selected="">Answer 2</option>
                                        <option>Answer 3</option>
                                        <option>Answer 4</option>
                                    </c:if>
                                    <c:if test="${requestScope.Correct == 'Answer3'}">
                                        <option>Answer 1</option>
                                        <option>Answer 2</option>
                                        <option selected="">Answer 3</option>
                                        <option>Answer 4</option>
                                    </c:if>
                                    <c:if test="${requestScope.Correct == 'Answer4'}">
                                        <option>Answer 1</option>
                                        <option>Answer 2</option>
                                        <option>Answer 3</option>
                                        <option selected="">Answer 4</option>
                                    </c:if>
                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                            <span class="focus-input100"></span>
                        </div>


                        <div class="wrap-input100">
                            <div class="label-input100">Change subject:</div>
                            <div>
                                <select class="js-select2" name="txtSubject">
                                    <c:forEach items="${requestScope.LIST}" var="dto">
                                        <option>${dto.id}</option>
                                    </c:forEach>
                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                            <span class="focus-input100"></span>
                        </div>


                        <div class="wrap-input100">
                            <div class="label-input100">Change status:</div>
                            <div>
                                <select class="js-select2" name="txtStatus">
                                    <option selected="">Active</option>
                                    <option>DeActive</option>
                                </select>
                                <div class="dropDownSelect2"></div>
                            </div>
                            <span class="focus-input100"></span>
                        </div>
                    </c:if>

                    <input type="hidden" name="txtSearch" value="${requestScope.Search}"/>
                    <input type="hidden" name="txtChoice" value="${requestScope.Category}"/>
                    <div class="container-contact100-form-btn">
                        <input type="hidden" name="role" value="${sessionScope.role}"/>
                        <button class="contact100-form-btn" type="submit" name="action" value="Update">
                            Update
                        </button>
                    </div>
                </form>

                <div class="contact100-more flex-col-c-m" style="background-image: url('Image/bg-01.jpg');">
                </div>
            </div>
        </div>

        <!--===============================================================================================-->
        <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--        <script src="js/main.js"></script>-->
        <script>
            (function ($) {
                "use strict";


                /*==================================================================
                 [ Validate ]*/
                var input = $('.validate-input .input100');

                $('.validate-form').on('submit', function () {
                    var check = true;

                    for (var i = 0; i < input.length; i++) {
                        if (validate(input[i]) === false) {
                            showValidate(input[i]);
                            check = false;
                        }
                    }

                    return check;
                });


                $('.validate-form .input100').each(function () {
                    $(this).focus(function () {
                        hideValidate(this);
                    });
                });

                function validate(input) {
                    if ($(input).attr('type') === 'email' || $(input).attr('name') === 'email') {
                        if ($(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/) === null) {
                            return false;
                        }
                    } else {
                        if ($(input).val().trim() === '') {
                            return false;
                        }
                    }
                }

                function showValidate(input) {
                    var thisAlert = $(input).parent();

                    $(thisAlert).addClass('alert-validate');
                }

                function hideValidate(input) {
                    var thisAlert = $(input).parent();

                    $(thisAlert).removeClass('alert-validate');
                }


            })(jQuery);
        </script>
        <script>
            $(".js-select2").each(function () {
                $(this).select2({
                    minimumResultsForSearch: 20,
                    dropdownParent: $(this).next('.dropDownSelect2')
                });
            })
            $(".js-select2").each(function () {
                $(this).on('select2:open', function (e) {
                    $(this).parent().next().addClass('eff-focus-selection');
                });
            });
            $(".js-select2").each(function () {
                $(this).on('select2:close', function (e) {
                    $(this).parent().next().removeClass('eff-focus-selection');
                });
            });

        </script>
        <!--===============================================================================================-->
        <script src="vendor/daterangepicker/moment.min.js"></script>
        <script src="vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->

        <!-- Global site tag (gtag.js) - Google Analytics -->
        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag() {
                dataLayer.push(arguments);
            }
            gtag('js', new Date());

            gtag('config', 'UA-23581568-13');
        </script>
    </body>
</html>
