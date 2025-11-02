<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

        <!-- bootstrap core css -->
        <!--        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <!-- fonts style -->
        <link href="https://fonts.googleapis.com/css?family=Baloo+Chettan|Dosis:400,600,700|Poppins:400,600,700&display=swap" rel="stylesheet" />
        <!-- Custom styles for this template -->
        <link href="css/style.css" rel="stylesheet" />
        <!-- responsive style -->
        <link href="css/responsive.css" rel="stylesheet" />
        <script src="https://kit.fontawesome.com/9a14d14ca3.js" crossorigin="anonymous"></script>
        <style>
            /* Style the select element */
            select {
                padding: 10px;
                font-size: 16px;
                border: 2px solid #3498db;
                border-radius: 5px;
                background-color: #f2f2f2;
                color: #333;
                cursor: pointer;
            }

            /* Style the input buttons */
            input[type="submit"] {
                padding: 10px 20px;
                font-size: 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin: 5px;
                transition: background-color 0.3s;
            }

            input[type="submit"]:hover {
                background-color: #2975b5; /* Darker shade on hover */
            }

            /* Style the hidden input fields */
            input[type="text"][hidden] {
                display: none;
            }

            /* Style the selected option in the select element */
            select option[selected] {
                background-color: #3498db;
                color: white;
            }

            /* Center-align the form elements */
            form {
                text-align: center;
                margin-bottom: 70px;
            }

            .selected-page {
                background-color: #3498db;
                color: white;
            }

        </style>

    </head>

    <body class="sub_page">
        <!-- nav section -->

        <%@include file="navbar.jsp" %>

        <!-- end nav section -->

        <!-- search -->
        <br>
        <div class="header-search">
            <div class="topnav" style="margin: 0px 25px">
                <form action="search" method="get">
                    <input type="text" placeholder="search for...." name="key"/>
                    <button>
                        <img src="images/search_icon.png" width="15px" 
                             height="15px" alt="search"/>
                    </button>    
                </form>
            </div> 
        </div>

        <!--fruit section -->

        <section class="fruit_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <hr>
                    <h2>
                        All Book
                    </h2>
                </div>
                <!--  admin -->
                <c:if test="${sessionScope.account.role == true}">
                    <div class="col-lg-12" style="margin-bottom: 20px; text-align: center">
                        <a href="add"><i class="fa-solid fa-circle-plus"></i> Add new product</a>
                    </div>
                </c:if>

                <!-- FILTER FORM -->
                <form action="productlist" method="get" class="mb-4">
                    <select name="categoryId">
                        <option value="">All Categories</option>
                        <c:forEach var="c" items="${sessionScope.listC}">
                            <option value="${c.id}" ${param.categoryId == c.id ? 'selected' : ''}>${c.name}</option>
                        </c:forEach>
                    </select>

                    <select name="priceRange">
                        <option value="">All Prices</option>
                        <option value="low" ${param.priceRange == 'low' ? 'selected' : ''}>Below 500,000</option>
                        <option value="mid" ${param.priceRange == 'mid' ? 'selected' : ''}>500,000 - 2,000,000</option>
                        <option value="high" ${param.priceRange == 'high' ? 'selected' : ''}>Above 2,000,000</option>
                    </select>

                    <input type="submit" value="Filter" />
                    <a href="productlist" class="btn btn-light">Reset</a>
                </form>

                <!-- BEST OPTION SECTION -->
                <div class="best_option mb-5">
    <h4 style="color:#3498db; text-align:center; margin-bottom: 20px;">Best Options</h4>
    <div class="d-flex flex-wrap justify-content-center">
        <c:forEach var="b" items="${bestProducts}">
            <div class="card m-2 shadow-sm" style="width:200px;">
                <a href="detail?pid=${b.id}">
                    <img src="${b.image}" class="card-img-top" alt="${b.name}">
                </a>
                <div class="card-body text-center">
                    <h6>
                        <a href="detail?pid=${b.id}" style="text-decoration:none; color:black;">
                            ${b.name}
                        </a>
                    </h6>
                    <p><fmt:formatNumber pattern="###,### VND" value="${b.price}"/></p>
                </div>
            </div>
        </c:forEach>
    </div>
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
                                    <c:if test="${sessionScope.account.role == true}">
                                        <a href="update?pid=${p.id}">
                                            Update
                                        </a>
                                        <a href="delete?pid=${p.id}" style="margin-top: 10px">
                                            Delete
                                        </a>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </section>

        <c:if test="${search != '1'}">
            <!--Paging -->
            <%@include file="pagination.jsp" %>
        </c:if>

        <%@include file="footer.jsp" %>

    </body>


    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    <!--        <script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
            <script type="text/javascript" src="js/bootstrap.js"></script>
            <script type="text/javascript" src="js/custom.js"></script>-->

</html>
