<%-- 
    Document   : search
    Created on : Jun 9, 2020, 9:44:56 AM
    Author     : KRIS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <body>

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


                        <li class="nav-item active"><a href="places.jsp" class="nav-link">Places</a></li>

                        <c:if test="${sessionScope.DTO.role == 2}">
                            <li class="nav-item"><a href="book.jsp" class="nav-link">Booking <span class="icon-shopping-bag"></span>
                                    <span class="number">${sessionScope.cart.cart.size()}</span></a>

                            </li>
                        </c:if>

                        <c:if test="${sessionScope.DTO.role == null}">
                            <li class="nav-item"><a href="login.jsp" class="nav-link">Login</a></li>
                            </c:if>

                        <c:if test="${sessionScope.DTO.role == 1}">
                            <li class="nav-item"><a href="insert.jsp" class="nav-link">Insert</a></li>
                            </c:if>

                        <c:if test="${sessionScope.DTO.fullname != null}">
                            <li class="nav-item"><a href="Logout" class="nav-link">Logout</a></li>
                            </c:if>


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
                        <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><span class="mr-2"></span><span>Places</span></p>
                        <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Destinations</h1>
                    </div>
                </div>
            </div>
        </div>





        <section class="ftco-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 sidebar order-md-last ftco-animate">
                        <div class="sidebar-wrap ftco-animate">
                            <h3 class="heading mb-4">Find Tour</h3>
                            <form action="Search" method="POST">
                                <div class="fields">
                                    <div class="form-group">
                                        <input name="places" type="text" class="form-control" placeholder="Destination, City" value="${requestScope.Place}">
                                    </div>


                                    <div class="form-group">
                                        <input name="dateFrom" type="text" id="checkin_date" class="form-control checkin_date" placeholder="Date from" value="${requestScope.From}">
                                    </div>

                                    <div class="form-group">
                                        <input name="dateTo" type="text" id="checkout_date" class="form-control checkout_date" placeholder="Date to" value="${requestScope.To}">
                                    </div>


                                    <div class="form-group">
                                        <div class="range-slider">
                                            <span>
                                                <input name="lower" id="lower" type="number" <c:if test="${requestScope.Low != null && not empty requestScope.Low}" var="checkLow">value="${requestScope.Low}"</c:if> <c:if test="${!checkLow}">value="1000"</c:if>  min="0" max="20000" style="border: 2px solid #ff6347"/>	-
                                                <input name="higher" id="higher" type="number" <c:if test="${requestScope.High != null && not empty requestScope.High}" var="checkHigh">value="${requestScope.High}"</c:if> <c:if test="${!checkHigh}">value="20000"</c:if> min="0" max="20000" style="border: 2px solid #ff6347"/>
                                                <!--<input type="hidden" name="txtCount" value="${requestScope.Count}"/>-->
                                            </span> 
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <input type="submit" value="Search" class="btn btn-primary py-3 px-5">
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="sidebar-wrap ftco-animate">
                            <h3 class="heading mb-4">Star Rating</h3>

                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">
                                    <p class="rate"><span><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i></span></p>
                                </label>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">
                                    <p class="rate"><span><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star-o"></i></span></p>
                                </label>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">
                                    <p class="rate"><span><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star-o"></i><i class="icon-star-o"></i></span></p>
                                </label>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">
                                    <p class="rate"><span><i class="icon-star"></i><i class="icon-star"></i><i class="icon-star-o"></i><i class="icon-star-o"></i><i class="icon-star-o"></i></span></p>
                                </label>
                            </div>
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">
                                    <p class="rate"><span><i class="icon-star"></i><i class="icon-star-o"></i><i class="icon-star-o"></i><i class="icon-star-o"></i><i class="icon-star-o"></i></span></p>
                                </label>
                            </div>

                        </div>
                    </div><!-- END-->

                    <c:if test="${requestScope.LIST != null}">
                        <c:if test="${not empty requestScope.LIST}" var="checkList">
                            <div class="col-lg-9">
                                <div class="row">
                                    <c:forEach items="${requestScope.LIST}" var="dto">

                                        <div class="col-sm col-md-6 col-lg-4 ftco-animate">
                                            <div class="destination">
                                                <a href="#" class="img img-2 d-flex justify-content-center align-items-center myImg" style="background-image: url(${dto.image});">
                                                    <div class="icon d-flex justify-content-center align-items-center">
                                                        <span class="icon-link"></span>
                                                    </div>
                                                </a>
                                                <div class="text p-3">
                                                    <div class="d-flex">
                                                        <div class="one">
                                                            <h3><a href="#">${dto.name}</a></h3>
                                                            <p class="rate">
                                                                <i class="icon-star"></i>
                                                                <i class="icon-star"></i>
                                                                <i class="icon-star"></i>
                                                                <i class="icon-star"></i>
                                                                <i class="icon-star-o"></i>
                                                                <span>16 Rating</span>
                                                            </p>
                                                        </div>
                                                        <div class="two">
                                                            <span class="price">$${dto.price}</span>
                                                        </div>
                                                    </div>
                                                    <p>${dto.description}</p>
                                                    <p class="days"><span>From: ${dto.from}  - To: ${dto.to}</span></p>
                                                    <hr>


                                                    <form action="Booking" method="POST">
                                                        <p class="bottom-area d-flex">
                                                            <span><i class="icon-map-o"></i> ${dto.place}</span> 
                                                            <c:if test="${dto.slot < dto.quota}" var="checkSlot">
                                                                <c:if test="${sessionScope.DTO.role == 2}">
                                                                    <span class="ml-auto"><input type="submit" value="Discover"/></span>
                                                                    <input type="hidden" name="txtId" value="${dto.id}"/>
                                                                    <input type="hidden" name="txtImage" value="${dto.image}"/>
                                                                    <input type="hidden" name="txtName" value="${dto.name}"/>
                                                                    <input type="hidden" name="txtPrice" value="${dto.price}"/>
                                                                    <input type="hidden" name="txtDescription" value="${dto.description}"/>
                                                                    <input type="hidden" name="txtFrom" value="${dto.from}"/>
                                                                    <input type="hidden" name="txtTo" value="${dto.to}"/>
                                                                    <input type="hidden" name="txtPlace" value="${dto.place}"/>
                                                                    <input type="hidden" name="txtQuota" value="${dto.quota}"/>

                                                                    <input type="hidden" name="txtCount" value="${requestScope.Count}"/>
                                                                    <input type="hidden" name="places" value="${requestScope.Place}"/>
                                                                    <input type="hidden" name="dateFrom" value="${requestScope.From}"/>
                                                                    <input type="hidden" name="dateTo" value="${requestScope.To}"/>
                                                                    <input type="hidden" name="lower" value="${requestScope.Low}"/>
                                                                    <input type="hidden" name="higher" value="${requestScope.High}"/>
                                                                </c:if>
                                                            </c:if>    
                                                            <c:if test="${!checkSlot}">
                                                                <span class="ml-auto"><input type="button" value="Out of slots"/></span>

                                                            </c:if>
                                                        </p>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>

                                    </c:forEach>
                                </div>
                            </div> <!-- .col-md-8 -->
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col text-center">
                            <div class="block-27">
                                <ul>
                                    <li><a href="Search?txtCount=${requestScope.Count}&places=${requestScope.Place}&dateFrom=${requestScope.From}&dateTo=${requestScope.To}&lower=${requestScope.Low}&higher=${requestScope.High}&btnPrevious=previous">&lt;</a></li>
                                    <!--                                    <li class="active"><span>1</span></li>
                                                                        <li><a href="#">2</a></li>
                                                                        <li><a href="#">3</a></li>
                                                                        <li><a href="#">4</a></li>
                                                                        <li><a href="#">5</a></li>-->
                                    <c:forEach var="i" begin="1" end="${requestScope.Total}">
                                        <c:set var="count" value="${requestScope.Count}"/>
                                        <c:set var="check" value="${i}"/>
                                        <c:if test="${requestScope.Count == i}" var="checkIndex">
                                            <li class="active"><span>${i}</span></li>
                                                </c:if>
                                                <c:if test="${!checkIndex}">
                                            <li><a href="Search?txtCount=${i}&places=${requestScope.Place}&dateFrom=${requestScope.From}&dateTo=${requestScope.To}&lower=${requestScope.Low}&higher=${requestScope.High}">${i}</a></li>
                                            </c:if>
                                        </c:forEach>
                                    <li><a href="Search?txtCount=${requestScope.Count}&places=${requestScope.Place}&dateFrom=${requestScope.From}&dateTo=${requestScope.To}&lower=${requestScope.Low}&higher=${requestScope.High}&btnNext=next">&gt;</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${!checkList}">
                    <!--                    <div class="col-lg-9">-->
                    <div class="destination">
                        <div class="one">
                            <h4><p>No tours available to your search</p></h4>
                        </div>
                    </div>
                    <!--</div>-->
                </c:if>
            </c:if>
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

    </body>
</html>
