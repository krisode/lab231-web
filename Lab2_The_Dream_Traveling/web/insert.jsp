<%-- 
    Document   : insert
    Created on : Jun 9, 2020, 10:38:21 AM
    Author     : KRIS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Dream Travel</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">

        <!-- Font Icon -->
        <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">

        <!-- Main css -->
        <link rel="stylesheet" href="css/insert.css">
    </head>
    <body onload="checkNotification()">

        <div class="main">

            <!-- Sign up form -->
            <section class="signup">
                <div class="container">
                    <div class="signup-content">
                        <div class="signup-form">
                            <h2 class="form-title">Insert Tour</h2>	
                            <form action="Insert" method="POST" class="register-form" id="register-form">
                                <div class="form-group">
                                    <label for="name"><i class="zmdi zmdi zmdi-label"></i></label>
                                    <input type="text" name="txtName" id="email" placeholder="Title" required=""/>
                                </div>
                                <div class="form-group">
                                    <label for="name"><i class="zmdi zmdi-pin-drop material-icons-name"></i></label>
                                    <input type="text" name="txtPlace" id="name" placeholder="Destination" required=""/>
                                </div>
                                <div class="form-group">
                                    Date From:<input name="txtFrom" type="date" id="checkin_date" class="form-control checkout_date" placeholder="Date from" required="">
                                </div>
                                <div class="form-group">
                                    Date To: <input name="txtTo" type="date" id="checkout_date" class="form-control checkout_date" placeholder="Date to" required="">
                                </div>
                                <div class="form-group">
                                    <label for="number"><i class="zmdi zmdi-money material-icons-name"></i></label>
                                    <input type="number" name="txtPrice" placeholder="Price" min="0" max="20000" required=""/>
                                </div>
                                <div class="form-group">
                                    <label for="number"><i class="zmdi zmdi-male-female material-icons-name"></i></label>
                                    <input type="number" name="txtQuota" placeholder="Quota" min="1" max="100" required=""/>
                                </div>
                                <div class="form-group">
                                    <label for="number"><i class="zmdi zmdi-book-image"></i></label>
                                    Image: <input type="file" name="txtImage" onchange="readURL(this);" accept="image/*" required=""/>
                                </div>
                                <div class="form-group">
                                    Description: <br/> <textarea style="width: 297px; height: 100px;" name="txtDescription" placeholder="Enter description" required=""></textarea>
                                </div>

                                <div class="form-group form-button">
                                    <input type="submit" name="btnInsert" id="signup" class="form-submit" value="Create"/>
                                </div>
                            </form>
                        </div>
                        <div class="signup-image">
                            <figure><img id="image" src="images/signup-image.jpg" alt="sing up image"></figure>
                            <a href="places.jsp" class="signup-image-link">Back to Home Page</a>
                        </div>
                    </div>
                </div>
            </section>

        </div>


        <!-- JS -->
        <script src="js/jquery-3.2.1.min.js"></script>
        <script src="js/aos.js"></script>
        <script src="js/main.js"></script>
        <script>
                                        function readURL(input) {
                                            if (input.files && input.files[0]) {
                                                var reader = new FileReader();
                                                reader.onload = function (e) {
                                                    $('#image').attr('src', e.target.result).width(300).height(210);
                                                };
                                                reader.readAsDataURL(input.files[0]);
                                            }
                                        }

                                        function checkNotification() {
            <c:if test="${requestScope.NOTIFICATION != null}">
                                            alert('${requestScope.NOTIFICATION}');
            </c:if>
                                        }

        </script> 
    </body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>
