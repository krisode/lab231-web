<%@taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Login</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->	
        <link rel="icon" type="image/png" href="images/icons/favicon.ico"/>
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
        <!--===============================================================================================-->	
        <link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="css/util.css">
        <link rel="stylesheet" type="text/css" href="css/main.css">
        <!--===============================================================================================-->
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>

    </head>

    <body onload="checkError()">

        <div class="limiter">
            <div class="container-login100">
                <div class="wrap-login100">
                    <div class="login100-pic js-tilt" data-tilt>
                        <img src="images/img-01.png" alt="IMG">
                    </div>

                    <form id="demo-form" class="login100-form validate-form" action="LoginAction" method="POST">
                        <span class="login100-form-title" style="font-weight: bold">
                            Member Login
                        </span>

                        <div class="wrap-input100 validate-input" data-validate = "Username is required">
                            <input id="username" class="input100" type="email" name="username" placeholder="Username" value="<s:property value="#request.Username"/>" required="">
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-envelope" aria-hidden="true"></i>
                            </span>
                        </div>

                        <div class="wrap-input100 validate-input" data-validate = "Password is required">
                            <input id="password" class="input100" type="password" name="password" placeholder="Password" required="">
                            <span class="focus-input100"></span>
                            <span class="symbol-input100">
                                <i class="fa fa-lock" aria-hidden="true"></i>
                            </span>
                        </div>

                        <input type="hidden" id="recaptchaResult" name="recaptchaResult"/>
                        <div class="g-recaptcha"
                             data-sitekey="6Lfw8qsZAAAAAJxzz8htuCNHMG8wIDesTzRgaM4C" data-callback="recaptchaCallback"></div>

                        <div class="container-login100-form-btn">
                            <button class="login100-form-btn" disabled id="submitBtn" style="background-color: black" onclick="checkRecaptcha()">
                                Login
                            </button>
                        </div>

                        <div class="text-center p-t-12">
                            <span class="txt1">
                                Not a member yet?
                            </span>
                            <a class="txt2" href="register.jsp">
                                Register
                            </a>
                        </div>

                        <div class="text-center p-t-136">
                            <a href="#" class="btn-face m-b-20">
                                <i class="fa fa-facebook-official"></i>
                                Facebook
                            </a>
                            <a href="https://accounts.google.com/o/oauth2/auth?scope=profile email&redirect_uri=http://localhost:8084/Lab3_Sharing_Resource/LoginAction&response_type=code&client_id=955579505111-mb4m4q5a3knf7min93vcst3l984jb6n8.apps.googleusercontent.com&approval_prompt=force" class="btn-google m-b-20">
                                <img src="images/icons/icon-google.png" alt="GOOGLE">
                                Google
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!--===============================================================================================-->	
        <script src="js/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/bootstrap/js/popper.js"></script>
        <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
        <script src="vendor/tilt/tilt.jquery.min.js"></script>
        <script >
                                $('.js-tilt').tilt({
                                    scale: 1.1
                                })

                                function recaptchaCallback() {
                                    $('#submitBtn').removeAttr('disabled');
                                    $('#submitBtn').removeAttr('style');
                                }
                                ;

                                function checkError() {
            <s:if test="%{#request.ERROR != null}">
                                    alert('<s:property value="%{#request.ERROR}"/>');
            </s:if>
                                }

                                function checkRecaptcha() {
                                    var response = grecaptcha.getResponse();
                                    if (response.length === 0) {
                                        document.getElementById("recaptchaResult").value = 'False';
                                    } else {
                                        document.getElementById("recaptchaResult").value = 'True';
                                    }
                                }
        </script>
        <!--===============================================================================================-->
        <script src="js/main.js"></script>
    </body>
</html>
