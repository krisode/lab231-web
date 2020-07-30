<%-- 
    Document   : book
    Created on : Jun 9, 2020, 10:27:57 AM
    Author     : KRIS
--%>

<%@taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Sharing Resource</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Abril+Fatface" rel="stylesheet">

        <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
        <link rel="stylesheet" href="css/animate.css">

        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">

        <link rel="stylesheet" href="css/aos.css">

        <link rel="stylesheet" href="css/ionicons.min.css">

        <link rel="stylesheet" href="css/bootstrap-datepicker.css">


        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/icomoon.css">
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body onload="alertError()">

        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="places.jsp">Adventure</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>

                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a class="nav-link">Welcome, <s:property value="%{#session.DTO.name}"/></a></li>
                        <li class="nav-item"><a href="search.jsp" class="nav-link">Resources</a></li>
                        <li class="nav-item active"><a href="book.jsp" class="nav-link">Booking</a></li>
                        <li class="nav-item"><a href="HistoryAction?nameSearch=&bookedDate=" class="nav-link">History</a></li>
                        <li class="nav-item"><a href="LogoutAction" class="nav-link">Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- END nav -->

        <div class="hero-wrap js-fullheight" style="background-image: url('images/bg_1.jpg');">
            <div class="overlay"></div>
            <div class="container">
                <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center" data-scrollax-parent="true">
                    <div class="col-md-9 text-center ftco-animate" data-scrollax=" properties: { translateY: '70%' }">
                        <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><span class="mr-2"></span><span>Booking</span></p>
                        <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Resources</h1>
                    </div>
                </div>
            </div>
        </div>

        <section class="ftco-section">
            <form action="RequestAction" class="col-md-12" method="POST">
                <div class="site-section">
                    <div class="container">
                        <div class="row mb-5" style="margin-bottom: 0rem !important;">
                            <s:if test="%{#session.cart.cart != null}">
                                <s:if test="%{#session.cart.cart.size > 0}">
                                    <div class="site-blocks-table">
                                        <table class="table table-bordered" style="text-align: center; align-items: center; width: 1100px">
                                            <thead>
                                                <tr>
                                                    <th class="product-thumbnail">Image</th>
                                                    <th class="product-name">Name</th>
                                                    <th style="width: 125px" class="product-name">Using date</th>
                                                    <th style="width: 125px" class="product-name">Return date</th>
                                                    <th class="product-price">Color</th>
                                                    <th class="product-quantity">Quantity</th>
                                                    <th class="product-quantity">Available</th>
                                                    <th class="product-remove">Remove</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <s:iterator value="%{#session.cart.cart}">
                                                    <tr>
                                                        <td class="product-thumbnail">
                                                            <img style="height: 200px" width="200px" src="<s:property value="value.image"/>" alt="Image" class="img-fluid">
                                                        </td>
                                                        <td class="product-name" style="align-items: center">
                                                            <h2 class="h5 text-black"><s:property value="value.name"/></h2>
                                                        </td>
                                                        <td><s:property value="value.borrowDate"/></td>
                                                        <td style="width: 150px"><input name="returnDate" type="text" id="checkout_date" class="form-control checkout_date" required=""></td>
                                                        <td><s:property value="value.color"/></td>
                                                        <td>
                                                            <s:property value="value.quantityInCart"/>
                                                        </td>
                                                        <td><s:property value="value.availableQuantity"/> left</td>
                                                        <td><a href="RequestAction?delete=X&id=<s:property value="%{value.id}"/>" class="btn btn-primary height-auto btn-sm" style="width: 45px" onclick="return confirm('Items will be removed?')">X</a></td>
                                                <input type="hidden" name="id" value="<s:property value="%{value.id}"/>"/>
                                                </tr>
                                            </s:iterator>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col-md-6 mb-3 mb-md-0">
                                        <input name="send" value="Send request" type="submit" class="btn btn-primary btn-sm btn-block" style="padding-top: 10px;-webkit-border-radius: 1px;-moz-border-radius: 1px;border-radius: 1px; width: 150px">
                                    </div>
                                </s:if>
                                <s:elseif test="%{#session.cart.cart.size == 0}">
                                    <div class="site-blocks-table">
                                        <table class="table table-bordered" style="text-align: center; align-items: center; width: 1100px">
                                            <thead>
                                                <tr>
                                                    <th class="product-thumbnail">RESOURCES</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>NO RECORD</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </s:elseif>
                            </s:if>
                        </div>


                        <s:elseif test="%{#session.cart == null}">
                            <div class="site-blocks-table">
                                <table class="table table-bordered" style="text-align: center; align-items: center; width: 1100px">
                                    <thead>
                                        <tr>
                                            <th class="product-thumbnail">Resources</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>NO RECORD</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </s:elseif>
                    </div>
                </div>
            </form>
        </section> <!-- .section -->


        <footer class="ftco-footer ftco-bg-dark ftco-section">
            <div class="container">
                <div class="row mb-5">
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Adventure</h2>
                            <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                            <ul class="ftco-footer-social list-unstyled float-md-left float-lft mt-3">
                                <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
                                <li class="ftco-animate"><a href="https://www.facebook.com/profile.php?id=100011010546371" target="_blank"><span class="icon-facebook"></span></a></li>
                                <li class="ftco-animate"><a href="https://www.instagram.com/tt_dang.huy/" target="_blank"><span class="icon-instagram"></span></a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4 ml-md-4">
                            <h2 class="ftco-heading-2">Information</h2>
                            <ul class="list-unstyled">
                                <li><a href="#" class="py-2 d-block">About Us</a></li>
                                <li><a href="#" class="py-2 d-block">Online enquiry</a></li>
                                <li><a href="#" class="py-2 d-block">Call Us</a></li>
                                <li><a href="#" class="py-2 d-block">General enquiries</a></li>
                                <li><a href="#" class="py-2 d-block">Booking Conditions</a></li>
                                <li><a href="#" class="py-2 d-block">Privacy and Policy</a></li>
                                <li><a href="#" class="py-2 d-block">Refund policy</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Experience</h2>
                            <ul class="list-unstyled">
                                <li><a href="#" class="py-2 d-block">Beach</a></li>
                                <li><a href="#" class="py-2 d-block">Adventure</a></li>
                                <li><a href="#" class="py-2 d-block">Wildlife</a></li>
                                <li><a href="#" class="py-2 d-block">Honeymoon</a></li>
                                <li><a href="#" class="py-2 d-block">Nature</a></li>
                                <li><a href="#" class="py-2 d-block">Party</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2">Have a Questions?</h2>
                            <div class="block-23 mb-3">
                                <ul>
                                    <li><span class="icon icon-map-marker"></span><span class="text">FPTUniversity, District 9, Ho Chi Minh City</span></li>
                                    <li><a href="#"><span class="icon icon-phone"></span><span class="text">+84 937 195 833</span></a></li>
                                    <li><a href="#"><span class="icon icon-envelope"></span><span class="text">HuyTTDSE140080@fpt.edu.vn</span></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 text-center">

                        <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true"></i>
                            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
                    </div>
                </div>
            </div>
        </footer>



        <!-- loader -->
        <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery-migrate-3.0.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.easing.1.3.js"></script>
        <script src="js/jquery.waypoints.min.js"></script>
        <script src="js/jquery.stellar.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/aos.js"></script>
        <script src="js/jquery.animateNumber.min.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/scrollax.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
        <script src="js/google-map.js"></script>
        <script src="js/main.js"></script>

        <script>
                                function alertError() {
            <s:if test="%{#request.ERROR != null}">
                                    alert('<s:property value="%{#request.ERROR}"/>');
            </s:if>
                                }
        </script>
    </body>
</html>
