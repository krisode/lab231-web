<%-- 
    Document   : Notification
    Created on : Jul 4, 2020, 1:12:18 PM
    Author     : KRIS
--%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Sharing Resources</title>
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
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="search.jsp">The Company</a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>

                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a class="nav-link">Welcome, <s:property value="%{#session.DTO.name}"/></a></li>
                        <li class="nav-item"><a href="search.jsp" class="nav-link">Resources</a></li>
                        <li class="nav-item"><a href="book.jsp" class="nav-link">Booking <span class="icon-shopping-bag"></span>
                                <span class="number"><s:property value="%{#session.cart.cart.size}"/></span></a>
                        </li>
                        <li class="nav-item active"><a href="HistoryAction?nameSearch=&bookedDate=" class="nav-link">History</a></li>
                        <li class="nav-item"><a href="LogoutAction" class="nav-link">Logout</a></li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="hero-wrap js-fullheight" style="background-image: url('images/bg_1.jpg');">
            <div class="overlay"></div>
            <div class="container">
                <div class="row no-gutters slider-text js-fullheight align-items-center justify-content-center" data-scrollax-parent="true">
                    <div class="col-md-9 text-center ftco-animate" data-scrollax=" properties: { translateY: '70%' }">
                        <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><span class="mr-2"></span><span>Manage</span></p>
                        <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Request</h1>
                    </div>
                </div>
            </div>
        </div>
        <section class="ftco-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 sidebar order-md-last ftco-animate">
                        <div class="sidebar-wrap ftco-animate">
                            <h3 class="heading mb-4">Find Request</h3>
                            <form action="HistoryAction" method="POST">
                                <div class="fields">
                                    <div class="form-group">
                                        <input name="nameSearch" type="text" class="form-control" placeholder="Resource Name" value="<s:property value="%{#request.nameSearch}"/>">
                                    </div>

                                    <div class="form-group">
                                        <input name="bookedDate" type="text" id="checkin_date" class="form-control checkin_date" placeholder="Booking Date" value="<s:property value="%{#request.bookedDate}"/>">
                                    </div>

                                    <div class="form-group">
                                        <input type="submit" value="Search" class="btn btn-primary py-3 px-5">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div><!-- END-->

                    <form action="HistoryAction" class="col-md-12" method="POST">
                        Booking
                        <div class="site-section">
                            <div class="container">
                                <div class="row mb-5" style="margin-bottom: 0rem !important;">
                                    <s:if test="%{listBooking != null}">
                                        <s:if test="%{listBooking.size > 0}">
                                            <div class="site-blocks-table">
                                                <table class="table table-bordered" style="text-align: center; align-items: center; width: 1100px">
                                                    <thead>
                                                        <tr>                                                            
                                                            <th class="product-thumbnail">No</th>
                                                            <th class="product-thumbnail">Booking Date</th>
                                                            <th class="product-name">Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <s:iterator value="%{listBooking}" status="counter">
                                                            <tr>
                                                                <td class="product-name" style="align-items: center">
                                                                    <h2 class="h5 text-black"><s:property value="%{#counter.count}"/></h2>
                                                                </td>
                                                                <td><s:property value="bookingDate"/></td>
                                                                <td><s:if test="statusId == 3">
                                                                        <font style="color: blue; font-weight: bold">Processing</font>
                                                                    </s:if>
                                                                    <s:elseif test="statusId == 4">
                                                                        <font style="color: red; font-weight: bold">Deleted</font>
                                                                    </s:elseif>
                                                                    <s:elseif test="statusId == 5">
                                                                        <font style="color: green; font-weight: bold">Accepted</font>
                                                                    </s:elseif></td>
                                                                <td><a href="HistoryAction?viewDetail=X&id=<s:property value="%{bookingId}"/>&nameSearch=<s:property value="%{#request.nameSearch}"/>&bookedDate=<s:property value="%{#request.bookedDate}"/>">View Detail</a></td>
                                                            </tr>
                                                        </s:iterator>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </s:if>
                                        <s:elseif test="%{listBooking.size == 0}">
                                            <div class="site-blocks-table">
                                                <table class="table table-bordered" style="text-align: center; align-items: center; width: 1100px">
                                                    <thead>
                                                        <tr>
                                                            <th class="product-thumbnail">REQUEST</th>
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

                                <s:elseif test="%{listBooking == null}">
                                    <div class="site-blocks-table">
                                        <table class="table table-bordered" style="text-align: center; align-items: center; width: 1100px">
                                            <thead>
                                                <tr>
                                                    <th class="product-thumbnail">REQUEST</th>
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
                        <s:if test="%{listBookingDetail != null}">
                            <s:if test="%{listBookingDetail.size > 0}">
                                Booking Detail
                                <div class="site-blocks-table">
                                    <table class="table table-bordered" style="text-align: center; align-items: center; width: 1100px">
                                        <thead>
                                            <tr>                                                            
                                                <th class="product-thumbnail">No</th>
                                                <th class="product-thumbnail">ID</th>
                                                <th class="product-thumbnail">Using Date</th>
                                                <th class="product-name">Return Date</th>
                                                <th class="product-name">Resource Name</th>
                                                <th class="product-name">Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <s:iterator value="%{listBookingDetail}" status="counter">
                                                <tr>
                                                    <td class="product-name" style="align-items: center">
                                                        <h2 class="h5 text-black"><s:property value="%{#counter.count}"/></h2>
                                                    </td>
                                                    <td><s:property value="detailId"/></td>
                                                    <td><s:property value="borrowDate"/></td>
                                                    <td><s:property value="returnDate"/></td>
                                                    <td><s:property value="resourceName"/></td>
                                                    <td><s:property value="amount"/></td>
                                                </tr>
                                            </s:iterator>
                                        </tbody>
                                    </table>
                                    <s:if test="%{#request.bookingStatus == 3}">
                                        <div class="row mb-5">
                                            <div class="col-sm mb-3 mb-md-0" style="flex-grow: 0">
                                                <input name="cancel" value="Cancel" type="submit" class="btn btn-primary btn-sm btn-block" style="padding-top: 10px;-webkit-border-radius: 1px;-moz-border-radius: 1px;border-radius: 1px; width: 150px">
                                            </div>
                                            <input type="hidden" name="id" value="<s:property value="%{#request.id}"/>">
                                            <input type="hidden" name="nameSearch" value="<s:property value="%{#request.nameSearch}"/>">
                                            <input type="hidden" name="bookedDate" value="<s:property value="%{#request.bookedDate}"/>">
                                        </div>
                                    </s:if>
                                </div>
                            </s:if>
                        </s:if>
                    </form>
                </div>

            </div>



        </section>
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

    </body>
</html>
