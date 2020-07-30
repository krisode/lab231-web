<%-- 
    Document   : admin
    Created on : May 21, 2020, 9:03:54 PM
    Author     : KRIS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <link rel="stylesheet" type="text/css" href="CSS/Body.css">
        <link href="https://fonts.googleapis.com/css?family=Montserrat:700,900" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Josefin+Sans&family=Open+Sans+Condensed:wght@300&display=swap" rel="stylesheet">
    </head>
    <body>
        <main id="cd-main-content">
            <section id="cd-intro">
                <h1 style="font-family: 'Josefin Sans', sans-serif; font-size: 35px">Welcome, ${sessionScope.Fullname}</h1>

                <header class="cd-header">
                    <div id="cd-logo" style="border-style: solid; border-color: #FFF; padding-top: 4px;"><a href="LogoutController">LOGOUT</a></div>
                    <c:if test="${sessionScope.Role == 'admin'}">
                        <a class="cd-menu-trigger" href="#main-nav" style="border-style: solid; border-color: #FFF;">Manage Question<span></span></a>
                    </c:if>
                    <c:if test="${sessionScope.Role == 'student'}">
                        <a class="cd-menu-trigger" href="#main-nav" style="border-style: solid; border-color: #FFF;">Manage Quiz<span></span></a>
                    </c:if>

                </header>
                <div class="cd-blurred-bg"></div>
            </section> <!-- cd-intro -->
        </main>

        <div class="cd-shadow-layer"></div>

        <nav id="main-nav">
            <ul style="background-image: url('https://www.pixel4k.com/wp-content/uploads/2018/10/starry-night-sky-evening-blue-landscape-4k_1540144784.jpg'); background-position: center; color: #FFF;">
                <c:if test="${sessionScope.Role == 'admin'}">
                    <%-- GET "Username" and "Role" from LOGIN, NOTIFICATION Controller => to give PERMISSION access to MENU's elements --%>
                    <li style="list-style-type: none;"><a href="searchQuiz.jsp" style="font-family: 'Josefin Sans', sans-serif;"><span>SEARCH</span></a></li>
                    <li style="list-style-type: none;"><a href="QuestionMainController?action=Insert" style="color: #FFF; font-family: 'Josefin Sans', sans-serif;"><span>CREATE</span></a></li>
                    <li style="list-style-type: none;"><a href="searchQuiz.jsp" style="font-family: 'Josefin Sans', sans-serif;color: #FFF;"><span>UPDATE</span></a></li>
                    <li style="list-style-type: none;"><a href="searchQuiz.jsp" style="font-family: 'Josefin Sans', sans-serif;color: #FFF;"><span>DELETE</span></a></li>
                    </c:if>
                    <c:if test="${sessionScope.Role == 'student'}">
                    <li style="list-style-type: none;"><a href="quiz.jsp"style="font-family: 'Josefin Sans', sans-serif;color: #FFF;"><span>Take Quiz</span></a></li>
                    </c:if>
            </ul>
            <a href="#0" class="cd-close-menu">Close<span></span></a>
        </nav>
    </body>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <script>
        jQuery(document).ready(function ($) {
            //open menu
            $('.cd-menu-trigger').on('click', function (event) {
                event.preventDefault();
                $('#cd-main-content').addClass('move-out');
                $('#main-nav').addClass('is-visible');
                $('.cd-shadow-layer').addClass('is-visible');
            });
            //close menu
            $('.cd-close-menu').on('click', function (event) {
                event.preventDefault();
                $('#cd-main-content').removeClass('move-out');
                $('#main-nav').removeClass('is-visible');
                $('.cd-shadow-layer').removeClass('is-visible');
            });

            //clipped image - blur effect
            set_clip_property();
            $(window).on('resize', function () {
                set_clip_property();
            });

            function set_clip_property() {
                var $header_height = $('.cd-header').height(),
                        $window_height = $(window).height(),
                        $header_top = $window_height - $header_height,
                        $window_width = $(window).width();
                $('.cd-blurred-bg').css('clip', 'rect(' + $header_top + 'px, ' + $window_width + 'px, ' + $window_height + 'px, 0px)');
            }
        });
    </script>
</html>
