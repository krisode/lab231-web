<%-- 
    Document   : search
    Created on : Jun 9, 2020, 9:44:56 AM
    Author     : KRIS
--%>

<%@taglib prefix="s" uri="/struts-tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
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
                            <s:if test="%{#session.DTO.role != 1}">
                            <li class="nav-item active"><a href="search.jsp" class="nav-link">Resources</a></li>
                            <li class="nav-item"><a href="book.jsp" class="nav-link">Booking <span class="icon-shopping-bag"></span>
                                    <span class="number"><s:property value="%{#session.cart.cart.size}"/></span></a>
                            </li>
                            <li class="nav-item"><a href="HistoryAction?nameSearch=&bookedDate=" class="nav-link">History</a></li>
                            </s:if>
                            <s:if test="%{#session.DTO.role == 1}">
                            <li class="nav-item"><a href="SearchRequestAction?nameSearch=&usernameSearch=&from=&to=&status=All" class="nav-link">Notification</a></li>
                            </s:if>
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
                        <p class="breadcrumbs" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }"><span class="mr-2"></span><span>Sharing</span></p>
                        <h1 class="mb-3 bread" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Resources</h1>
                    </div>
                </div>
            </div>
        </div>




        <s:if test="%{#session.DTO.role != 1}">
            <section class="ftco-section">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-3 sidebar order-md-last ftco-animate">
                            <div class="sidebar-wrap ftco-animate">
                                <h3 class="heading mb-4">Find Items</h3>
                                <form action="SearchAction" method="POST">
                                    <div class="fields">
                                        <div class="form-group">
                                            <input name="nameSearch" type="text" class="form-control" placeholder="Name" value="<s:property value="%{#request.nameSearch}"/>">
                                        </div>

                                        <div class="form-group">
                                            <select id="category" name="category" class="form-control">
                                                <s:iterator value="%{#session.listCategory}">
                                                    <option><s:property value="name" default="None"/></option>
                                                </s:iterator>
                                            </select>                                                                                        
                                        </div>

                                        <div class="form-group">
                                            <input name="usingDate" type="text" id="checkout_date" class="form-control checkout_date" placeholder="Using date" value="<s:property value="%{#request.usingDate}"/>" required="">
                                        </div>

                                        <div class="form-group">
                                            <input type="submit" value="Search" class="btn btn-primary py-3 px-5">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div><!-- END-->

                        <s:if test="%{listResource != null}">
                            <s:if test="%{listResource.size > 0}">
                                <div class="col-lg-9">
                                    <div class="row">
                                        <s:iterator value="listResource">
                                            <div class="col-sm col-md-6 col-lg-4 ftco-animate">
                                                <div class="destination">
                                                    <a href="#" class="img img-2 d-flex justify-content-center align-items-center myImg" style="background-image: url(<s:property value="image"/>);">
                                                        <div class="icon d-flex justify-content-center align-items-center">
                                                            <span class="icon-link"></span>
                                                        </div>
                                                    </a>
                                                    <div class="text p-3">
                                                        <div class="d-flex">
                                                            <div class="one">
                                                                <h3><a href="#"><s:property value="name"/></a></h3>
                                                            </div>
                                                            <div class="two">
                                                                <span class="price"><s:property value="color"/></span>
                                                            </div>
                                                        </div>
                                                        <p><s:property value="description"/></p>
                                                        <p class="days"><span>Category: <s:property value="category"/>  -  Quantity: <s:property value="availableQuantity"/> left </span></p>
                                                        <hr>
                                                        <form action="BookAction" method="POST">
                                                            <p class="bottom-area d-flex">
                                                                <span><i class="icon-map-o"></i></span> 
                                                                    <s:if test="%{availableQuantity <= quantity}">
                                                                        <s:if test="%{availableQuantity != 0}">
                                                                        <span class="ml-auto"><input type="submit" value="Hire"/></span>
                                                                        <!--Hidden input will be send to BookAction-->
                                                                        <input type="hidden" name="id" value="<s:property value="id"/>"/>
                                                                        <input type="hidden" name="resourceName" value="<s:property value="name"/>"/>
                                                                        <input type="hidden" name="quantity" value="<s:property value="quantity"/>"/>
                                                                        <input type="hidden" name="role" value="<s:property value="role"/>"/>
                                                                        <input type="hidden" name="availableQuanitity" value="<s:property value="availableQuantity"/>"/>
                                                                        <input type="hidden" name="description" value="<s:property value="description"/>"/>
                                                                        <input type="hidden" name="color" value="<s:property value="color"/>"/>
                                                                        <input type="hidden" name="image" value="<s:property value="image"/>"/>

                                                                        <!--Hidden input will be send to SearchAction-->
                                                                        <input type="hidden" name="nameSearch" value="<s:property value="%{#request.nameSearch}"/>"/>
                                                                        <input type="hidden" name="pageCount" value="<s:property value="%{#request.Count}"/>"/>
                                                                        <input type="hidden" name="category" value="<s:property value="%{#request.category}"/>"/>
                                                                        <input type="hidden" name="usingDate" value="<s:property value="%{#request.usingDate}"/>"/>

                                                                    </s:if>
                                                                    <s:elseif test="%{availableQuantity == 0}">
                                                                        <span class="ml-auto"><input type="button" value="Out of resources"/></span>
                                                                        </s:elseif>
                                                                    </s:if>    

                                                            </p>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </s:iterator>
                                    </div>
                                </div>  
                            </div>

                            <div class="row mt-5">
                                <div class="col text-center">
                                    <div class="block-27">
                                        <ul>
                                            <li><a href="SearchAction?pageCount=<s:property value="#request.Count"/>&previous=previous&nameSearch=<s:property value="#request.nameSearch"/>&category=<s:property value="#request.category"/>&usingDate=<s:property value="#request.usingDate"/>">&lt;</a></li>                                            
                                                <s:iterator var="i" begin="1" end="%{#request.Total}" >                                    
                                                    <s:if test="%{#request.Count == #i}">
                                                    <li class="active"><span><s:property value="%{#i}"/></span></li>
                                                        </s:if>
                                                        <s:elseif test="%{#request.Count != #i}">
                                                    <li><a href="SearchAction?pageCount=<s:property value="%{#i}"/>&nameSearch=<s:property value="#request.name"/>&category=<s:property value="#request.category"/>&usingDate=<s:property value="#request.usingDate"/>"><s:property value="%{#i}"/></a></li>
                                                    </s:elseif>
                                                </s:iterator>
                                            <li><a href="SearchAction?pageCount=<s:property value="#request.Count"/>&next=next&nameSearch=<s:property value="#request.nameSearch"/>&category=<s:property value="#request.category"/>&usingDate=<s:property value="#request.usingDate"/>">&gt;</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </s:if>
                        <s:elseif test="%{listResource.size == 0}">
                            <div class="col-lg-9">
                                <div class="destination">
                                    <div class="one">
                                        <h4><p>No resources available to your search</p></h4>
                                    </div>
                                </div>
                            </div>
                        </s:elseif>
                    </s:if>
                </div>
            </section> <!-- .section -->
        </s:if>
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
