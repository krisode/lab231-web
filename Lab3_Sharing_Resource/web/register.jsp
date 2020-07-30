<%@taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Register</title>
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
                            <h2 class="form-title">Sign up</h2>
                            <form action="RegisterAction" method="POST" class="register-form" id="register-form">
                                <div class="form-group">
                                    <label for="name"><i class="zmdi zmdi-account material-icons-name"></i></label>
                                    <input type="text" name="name" id="name" placeholder="Your Name" required/>
                                </div>
                                <div class="form-group">
                                    <label for="email"><i class="zmdi zmdi-email"></i></label>
                                    <input type="email" name="username" id="email" placeholder="Your Email" required/>
                                </div>
                                <div class="form-group">
                                    <label for="pass"><i class="zmdi zmdi-lock"></i></label>
                                    <input type="password" name="password" id="pass" placeholder="Password" required/>
                                </div>
                                <div class="form-group">
                                    <label for="re-pass"><i class="zmdi zmdi-lock-outline"></i></label>
                                    <input type="password" name="re_pass" id="re_pass" placeholder="Repeat your password" required/>
                                </div>

                                <div class="form-group">
                                    <label for="phone"><i class="zmdi zmdi-phone"></i></label>
                                    <input type="text" name="phone" id="phone" placeholder="Your phone number" required/>
                                </div>

                                <div class="form-group">
                                    <label for="address"><i class="zmdi zmdi-pin-drop"></i></label>
                                    <input type="text" name="address" id="address" placeholder="Your address" required/>
                                </div>


                                <div class="form-group form-button">
                                    <input type="submit" name="signup" id="signup" class="form-submit" value="Register" onclick="return checkRegister()"/>
                                </div>
                            </form>
                        </div>
                        <div class="signup-image">
                            <figure><img src="images/signup-image.jpg" alt="sing up image"></figure>
                            <a href="login.jsp" class="signup-image-link">I am already member</a>
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
                                        function checkRegister() {
                                            var pass = document.getElementById("pass").value;
                                            var re_pass = document.getElementById("re_pass").value;
                                            if (re_pass !== pass) {
                                                alert("Your confirm password does not match");
                                                document.getElementById("re_pass").focus();
                                                return false;
                                            }
                                            return true;
                                        }


                                        function checkNotification() {
            <s:if test="%{exception.message.indexOf('duplicate') > -1}">
                                            alert("Duplicated email");

            </s:if>
                                        }

        </script> 
    </body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>
