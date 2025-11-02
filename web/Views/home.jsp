<%-- 
    Document   : home
    Created on : Oct 18, 2023, 11:03:40 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <!-- Basic -->
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <!-- Mobile Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <!-- Site Metas -->
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <meta name="author" content="" />

        <title>BookShop</title>

        <!-- slider stylesheet -->
        <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.1.3/assets/owl.carousel.min.css" />
        <script src="https://kit.fontawesome.com/9a14d14ca3.js" crossorigin="anonymous"></script>
        <!-- bootstrap core css -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

        <!-- fonts style -->
        <link href="https://fonts.googleapis.com/css?family=Baloo+Chettan|Dosis:400,600,700|Poppins:400,600,700&display=swap" rel="stylesheet" />
        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet" />
        <!-- responsive style -->
        <link href="css/responsive.css" rel="stylesheet" />

    </head>

    <body class="sub_page">
        <!-- nav section -->
        <%@include file="navbar.jsp" %>

        <div class="hero_area">
            <!-- slider section -->
            <section class=" slider_section position-relative">
                <div id="carouselExampleControls" class="carousel slide " data-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <div class="img-box">
                                <img src="images/banner-clothes1.png" alt="">
                            </div>
                        </div>
                        <div class="carousel-item">
                            <div class="img-box">
                                <img src="images/banner-clothes2.png" alt="">
                            </div>
                        </div>
                        <div class="carousel-item">
                            <div class="img-box">
                                <img src="images/banner-clothes3.png" alt="">
                            </div>
                        </div>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </section>
            <!-- end slider section -->
        </div>


        <section class="shop_section layout_padding">
            <div class="container">
                <div class="box">
                    <div class="detail-box mb-5">
                        <h2>
                            Book shop
                        </h2>
                    </div>
                    <div class="img-box">
                        <img src="images/shop-img.jpg" alt="">
                    </div>
                </div>
            </div>
        </section>

        <!-- about section -->

        <section class="about_section">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-6 px-0">
                        <div class="img-box">
                            <img src="images/about-img.jpg" alt="">
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="detail-box">
                            <div class="heading_container">
                                <hr>
                                <h2>
                                    About Our Book Shop
                                </h2>
                            </div>
                            <p> Book Shop là hệ thống bán lẻ sách hàng đầu trực thuộc Công ty TNHH XNK Thương mại An Minh. </p>
                            <a href="about">
                                Read More
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- end about section -->

        <section class="fruit_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <hr>
                    <h2>
                        Explore More Books In Shop
                    </h2>
                </div>
            </div>
            <c:if test="${requestScope.products != null}" >
                <div class="container-fluid">
                    <div class="fruit_container">
                        <c:forEach items="${products}" var="p"> 
                            <div class="box" >
                                <img src="${p.image}" alt="" />
                                <div class="link_box">
                                    <h5>
                                        ${p.name}
                                    </h5>
                                    <p><fmt:formatNumber pattern="###,### VND" value="${p.price}"/></p>
                                    <c:if test="${sessionScope.account == null}">
                                        <a href="login">
                                            Buy Now
                                        </a>
                                    </c:if>
                                    <c:if test="${sessionScope.account != null && sessionScope.account.role == false}">
                                        <a href="detail?pid=${p.id}">
                                            Buy Now
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
            <div class="container text-center mt-3">
                <a href="productlist?cp=1" class="btn btn-dark btn-lg">See More</a>
            </div>

        </section>


        <!-- contact section -->
        <section class="contact_section layout_padding" style="margin-bottom: 100px;">
            <div class="container">
                <div class="offset-lg-2 col-md-10 offset-md-1">
                    <div class="heading_container">
                        <hr>
                        <h2>
                            Map Location
                        </h2>
                    </div>
                </div>
                <div class="col-lg-12" style="margin-left: 20%;">
                    <div class="map_container">
                        <div class="map-responsive">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3833.856011735838!2d108.2583164!3d15.968891!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142116949840599%3A0x365b35580f52e8d5!2sFPT%20University%20Danang!5e0!3m2!1sen!2s!4v1697603662532!5m2!1sen!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>

                        </div>
                    </div>
                </div>

            </div>
        </section>
        <!-- end contact section -->

        <%@include file="footer.jsp" %>


    </body>
    <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/custom.js"></script>

</html>
