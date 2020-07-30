<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

        <title>Page Not Found</title>

        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:700,900" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="CSS/LoginCSS.css" />
        <!-- Custom stlylesheet -->

    </head>

    <body onload="checkError()">

        <div id="notfound">
            <div class="notfound">
                <div class="notfound-404">
                    <h1>404</h1>
                    <h2>Page not found</h2>
                </div>

                <a href="admin.jsp">Homepage</a>
            </div>
        </div>

    </body><!-- This templates was made by Colorlib (https://colorlib.com) -->
    <script>
        function checkError()
        <c:if test="${requestScope.ERROR != null}">
        alert('${requestScope.ERROR}');
        </c:if>
        }
    </script>
</html>
