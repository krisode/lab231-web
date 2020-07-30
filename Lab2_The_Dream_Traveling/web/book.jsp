<%-- 
    Document   : book
    Created on : Jun 9, 2020, 10:27:57 AM
    Author     : KRIS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Dream Travel</title>
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
                        <c:if test="${sessionScope.DTO.fullname != null}">
                            <li class="nav-item"><a href="#" class="nav-link">Welcome, ${sessionScope.DTO.fullname}</a></li>
                            </c:if>
                        <li class="nav-item"><a href="places.jsp" class="nav-link">Places</a></li>
                        <li class="nav-item active"><a href="book.jsp" class="nav-link">Booking</a></li>
                        <!--                        <li class="nav-item"><a href="login.jsp" class="nav-link">Login</a></li>-->
                        <li class="nav-item"><a href="Logout" class="nav-link">Logout</a></li>
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
                        <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Booking Tours</h1>
                    </div>
                </div>
            </div>
        </div>

        <section class="ftco-section">
            <form action="Update" class="col-md-12" method="POST">
                <div class="site-section">
                    <div class="container">
                        <div class="row mb-5" style="margin-bottom: 0rem !important;">
                            <c:if test="${sessionScope.cart.cart != null}">
                                <c:if test="${not empty sessionScope.cart.cart}" var="checkCart">
                                    <div class="site-blocks-table">
                                        <table class="table table-bordered" style="text-align: center; align-items: center; width: 1100px">
                                            <thead>
                                                <tr>
                                                    <th class="product-thumbnail">Image</th>
                                                    <th class="product-name">Destination</th>
                                                    <th style="width: 125px" class="product-name">From</th>
                                                    <th style="width: 125px" class="product-name">To</th>
                                                    <th class="product-price">Price</th>
                                                    <th class="product-quantity">Quantity</th>
                                                    <th class="product-quantity">Available Slots</th>
                                                    <th class="product-total">Total</th>
                                                    <th class="product-remove">Remove</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="dto" items="${sessionScope.cart.cart}">
                                                    <tr>
                                                        <td class="product-thumbnail">
                                                            <img style="height: 200px" width="200px" src="${dto.value.image}" alt="Image" class="img-fluid">
                                                        </td>
                                                        <td class="product-name" style="align-items: center">
                                                            <h2 class="h5 text-black">${dto.value.place}</h2>
                                                        </td>
                                                        <td>${dto.value.from}</td>
                                                        <td>${dto.value.to}</td>
                                                        <td>$${dto.value.price}</td>
                                                        <td style="width: 150px">
                                                            <div class="input-group mb-3" style="max-width: 120px; margin: auto">
                                                                <div class="input-group-prepend">
                                                                    <button class="btn btn-outline-primary js-btn-minus" type="button">&minus;</button>
                                                                </div>
                                                                <input type="text" class="form-control text-center" name="txtQuantity" value="${dto.value.quantity}" placeholder="" aria-label="Example text with button addon" aria-describedby="button-addon1">
                                                                <div class="input-group-append">
                                                                    <button class="btn btn-outline-primary js-btn-plus" type="button">&plus;</button>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td>${dto.value.slot} slots</td>
                                                        <td>${dto.value.quantity * dto.value.price}</td>
                                                        <td><a href="Update?btnDelete=X&txtDelete=${dto.value.id}" class="btn btn-primary height-auto btn-sm" style="width: 45px" onclick="return confirm('Tour [${dto.value.place}] will be removed?')">X</a></td>
                                                <input type="hidden" name="txtId" value="${dto.value.id}"/>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="row mb-5">
                                        <div class="col-md-6 mb-3 mb-md-0">
                                            <input name="btnUpdate" value="Update Cart" type="submit" class="btn btn-primary btn-sm btn-block" style="padding-top: 10px;-webkit-border-radius: 1px;-moz-border-radius: 1px;border-radius: 1px;">
                                        </div>
                                        <div class="col-md-6">
<!--                                            <input type="hidden" name="txtCount" value=""/>-->
                                            <input type="hidden" name="places" value=""/>
                                            <input type="hidden" name="dateFrom" value=""/>
                                            <input type="hidden" name="dateTo" value=""/>
                                            <input type="hidden" name="lower" value=""/>
                                            <input type="hidden" name="higher" value=""/>
                                            <input name="btnContinue" value="Continue Booking" type="submit" class="btn btn-outline-primary btn-sm btn-block"style="padding-top: 10px;-webkit-border-radius: 1px;-moz-border-radius: 1px;border-radius: 1px; padding-right: 55px"/>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${!checkCart}">
                                    <div class="site-blocks-table">
                                        <table class="table table-bordered" style="text-align: center; align-items: center; width: 1100px">
                                            <thead>
                                                <tr>
                                                    <th class="product-thumbnail">TOUR</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>NO RECORD</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                            </c:if>
                        </div>


                        <c:if test="${sessionScope.cart.cart == null and fn:length(sessionScope.cart.cart) == 0}">
                            <div class="site-blocks-table">
                                <table class="table table-bordered" style="text-align: center; align-items: center; width: 1100px">
                                    <thead>
                                        <tr>
                                            <th class="product-thumbnail">TOUR</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>NO RECORD</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>

                        <c:if test="${sessionScope.cart.cart != null and fn:length(sessionScope.cart.cart) > 0}">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <label class="text-black h4" for="coupon">Coupon</label>
                                            <p>Enter your coupon code if you have one.</p>
                                        </div>
                                        <div class="col-md-8 mb-3 mb-md-0">
                                            <input name="txtDiscount" value="${requestScope.Discount}" type="text" class="form-control py-3" id="coupon" placeholder="Coupon Code">
                                        </div>
                                        <div class="col-md-4">
                                            <input name="btnDiscount" value="Apply Coupon" type="submit" class="btn btn-primary btn-sm px-4" style="padding-top: 5px;-webkit-border-radius: 1px;-moz-border-radius: 1px;border-radius: 1px;"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6 pl-5">
                                    <div class="row justify-content-end">
                                        <div class="col-md-7">
                                            <div class="row">
                                                <div class="col-md-12 text-right border-bottom mb-5">
                                                    <h3 class="text-black h4 text-uppercase">Cart Totals</h3>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-md-6">
                                                    <span class="text-black">Subtotal</span>
                                                </div>
                                                <div class="col-md-6 text-right">
                                                    <strong class="text-black">${sessionScope.cart.getTotal()}</strong>
                                                </div>
                                            </div>
                                            <c:if test="${requestScope.Discount != null}" var="checkDiscount">
                                                <div class="row mb-5">
                                                    <div class="col-md-6">
                                                        <span class="text-black">Discount</span>
                                                    </div>
                                                    <div class="col-md-6 text-right">
                                                        <strong class="text-black">${requestScope.DiscountPrice}</strong>
                                                    </div>
                                                </div> 
                                                <div class="row mb-5">
                                                    <div class="col-md-6">
                                                        <span class="text-black">Total</span>
                                                    </div>
                                                    <div class="col-md-6 text-right">
                                                        <strong class="text-black">${requestScope.FinalPrice}</strong>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <c:if test="${!checkDiscount}">
                                                <div class="row mb-5">
                                                    <div class="col-md-6">
                                                        <span class="text-black">Total</span>
                                                    </div>
                                                    <div class="col-md-6 text-right">
                                                        <strong class="text-black">${sessionScope.cart.getTotal()}</strong>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <input name="btnConfirm" value="Proceed To Checkout" type="submit" class="btn btn-primary btn-lg btn-block" onclick="return confirm('Do you proceed to check out?')"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
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
            <c:if test="${requestScope.ERROR != null}">
                                    alert('${requestScope.ERROR}');
            </c:if>
                                }
        </script>
    </body>
</html>
