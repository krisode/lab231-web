<%-- 
    Document   : index
    Created on : May 25, 2020, 9:36:21 AM
    Author     : KRIS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Login Page</title>
        <link rel="stylesheet" type="text/css" href="CSS/LoginCSS.css">
    </head>
    <body onload="checkDuplicate(); checkLoginRegister()">
        <div class="cotn_principal">
            <div class="cont_centrar">
                <div class="cont_login">
                    <div class="cont_info_log_sign_up">
                        <div class="col_md_login">
                            <div class="cont_ba_opcitiy">

                                <h2>LOGIN</h2>  
                                <p>Welcome to QuizOn</p> <br/>
                                <button class="btn_login" onclick="cambiar_login()">LOGIN</button>
                            </div>
                        </div>
                        <div class="col_md_sign_up">
                            <div class="cont_ba_opcitiy">
                                <h2>SIGN UP</h2>
                                <p>Sign Up here</p> <br/>
                                <button class="btn_sign_up" onclick="cambiar_sign_up()">SIGN UP</button>
                            </div>
                        </div>
                    </div>


                    <div class="cont_back_info">
                        <div class="cont_img_back_grey">
                            <img src="https://images.unsplash.com/42/U7Fc1sy5SCUDIu4tlJY3_NY_by_PhilippHenzler_philmotion.de.jpg?ixlib=rb-0.3.5&q=50&fm=jpg&crop=entropy&s=7686972873678f32efaf2cd79671673d" alt="" />
                        </div>

                    </div>
                    <div class="cont_forms" >
                        <div class="cont_img_back_">
                            <img src="https://images.unsplash.com/42/U7Fc1sy5SCUDIu4tlJY3_NY_by_PhilippHenzler_philmotion.de.jpg?ixlib=rb-0.3.5&q=50&fm=jpg&crop=entropy&s=7686972873678f32efaf2cd79671673d" alt="" />
                        </div>
                        <form class="cont_form_login" action="MainController" method="POST">
                            <a href="#" onclick="ocultar_login_sign_up()" ><i class="material-icons">&#xE5C4;</i></a>
                            <h2>LOGIN</h2>
                            <input id="loginUsername" name="txtUsername" type="text" placeholder="Email" value="${requestScope.Username}"/>
                            <input id="loginPassword" name="txtPassword" type="password" placeholder="Password" />
                            <button name="action" value="Login" class="btn_login" type="submit" onclick="cambiar_login(); return checkLogin();">LOGIN</button>
                        </form>

                        <form class="cont_form_sign_up" action="MainController" method="POST">
                            <a href="#" onclick="ocultar_login_sign_up()"><i class="material-icons">&#xE5C4;</i></a>
                            <h2>SIGN UP</h2>
                            <input id="signUsername" name="txtUsername" type="text" placeholder="Email" value="${requestScope.DTO.username}"/>
                            <input id="signFullname" name="txtFullname" type="text" placeholder="Full Name" value="${requestScope.DTO.fullname}"/>
                            <input id="signPassword" name="txtPassword" type="password" placeholder="Password" />
                            <input id="signConfirm" type="password" placeholder="Confirm Password" />
                            <button name="action" value="Register" class="btn_sign_up" type="submit" onclick="cambiar_sign_up(); return checkRegister()">SIGN UP</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
    <script>
        function cambiar_login() {
            document.querySelector('.cont_forms').className = "cont_forms cont_forms_active_login";
            document.querySelector('.cont_form_login').style.display = "block";
            document.querySelector('.cont_form_sign_up').style.opacity = "0";
            setTimeout(function () {
                document.querySelector('.cont_form_login').style.opacity = "1";
            }, 400);
            setTimeout(function () {
                document.querySelector('.cont_form_sign_up').style.display = "none";
            }, 200);
        }

        function cambiar_sign_up() {

            document.querySelector('.cont_forms').className = "cont_forms cont_forms_active_sign_up";
            document.querySelector('.cont_form_sign_up').style.display = "block";
            document.querySelector('.cont_form_login').style.opacity = "0";
            setTimeout(function () {
                document.querySelector('.cont_form_sign_up').style.opacity = "1";
            }, 100);
            setTimeout(function () {
                document.querySelector('.cont_form_login').style.display = "none";
            }, 400);
        }


        function ocultar_login_sign_up() {

            document.querySelector('.cont_forms').className = "cont_forms";
            document.querySelector('.cont_form_sign_up').style.opacity = "0";
            document.querySelector('.cont_form_login').style.opacity = "0";
            setTimeout(function () {
                document.querySelector('.cont_form_sign_up').style.display = "none";
                document.querySelector('.cont_form_login').style.display = "none";
            }, 500);
        }

    </script>

    <script>
        function checkLogin() {
            var username = document.getElementById("loginUsername").value;
            var password = document.getElementById("loginPassword").value;
            var usernameValidate = /^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$/gm;
            if (username.length < 1) {
                alert("Email can't be blank");
                document.getElementById("loginUsername").focus();
                return false;
            } else if (username.length > 1 && (!usernameValidate.test(username))) {
                alert("Please input email's syntax correctly!!!")
                document.getElementById("loginUsername").focus();
                return false;
            } else if (password.length < 1) {
                alert("Password can't be blank");
                document.getElementById("loginPassword").focus();
                return false;
            }
            return true;
        }

        function checkRegister() {
            var username = document.getElementById("signUsername").value;
            var fullname = document.getElementById("signFullname").value;
            var password = document.getElementById("signPassword").value;
            var confirm = document.getElementById("signConfirm").value;
            var usernameValidate = /^[a-z][a-z0-9_\.]{5,32}@[a-z0-9]{2,}(\.[a-z0-9]{2,4}){1,2}$/gm;
            var fullnameValidate = /^[a-zA-Z ]+$/;
            if (username.length < 1) {
                alert("Email can't be blank");
                document.getElementById("signUsername").focus;
                return false;
            } else if (username.length > 1 && (!usernameValidate.test(username))) {
                alert("Wrong emai's syntax!!! Please input again");
                document.getElementById("signUsername").focus();
                return false;
            } else if (fullname.length < 1) {
                alert("Fullname can't be blank");
                document.getElementById("signFullname").focus;
                return false;
            } else if (fullname.length > 1 && (!fullnameValidate.test(fullname))) {
                alert("Fullname can't have number");
                document.getElementById("signFullname").focus();
                return false;
            } else if (password.length < 1) {
                alert("Please input password");
                document.getElementById("signPassword").focus();
                return false;
            } else if (confirm !== password) {
                alert("Your confirm password does not match");
                document.getElementById("signConfirm").focus();
                return false;
            }
            return true;
        }

        function checkDuplicate() {
        <c:if test="${requestScope.ERROR != null}">
            <c:if test="${not empty requestScope.ERROR}" var="checkError">
            alert('${requestScope.ERROR}');
            </c:if>
        </c:if>
        }

        function checkLoginRegister() {
        <c:if test="${requestScope.ERROR != null}">
            <c:set var="checkError" value="${requestScope.ERROR}"/>
            <c:if test="${fn:contains(checkError, 'Invalid')}">
            cambiar_login();
            document.getElementById("loginUsername").focus();
            </c:if>
            <c:if test="${fn:contains(checkError, 'existed')}">
            cambiar_sign_up();
            document.getElementById("signUsername").focus();
            </c:if>
        </c:if>
        }
    </script>
</html>
