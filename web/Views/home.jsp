<%-- 
    Document   : home
    Created on : May 19, 2024, 3:13:08 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Home</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/icons/favicon.png" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/iconic/css/material-design-iconic-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/linearicons-v1.0.0/icon-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animate/animate.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animsition/css/animsition.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/select2/select2.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/slick/slick.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/MagnificPopup/magnific-popup.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/util.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <style>
            .carousel-item {
                padding: 20px 0;
            }

            .card {
                margin: 10px;
                border: none;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .card:hover {
                transform: scale(1.05);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .card img {
                height: 150px;
                object-fit: cover;
            }

            .card-body {
                padding: 15px;
                text-align: center;
            }

            .card-title {
                font-size: 1.25rem;
                margin-bottom: 10px;
                color: #333;
            }

            .card-text {
                font-size: 1rem;
                margin-bottom: 15px;
                color: #666;
            }

            .btn-outline-success {
                transition: background-color 0.3s, color 0.3s;
                border-radius: 50px;
                padding: 10px 20px;
                font-weight: bold;
            }

            .btn-outline-success:hover {
                background-color: #28a745;
                color: #fff;
            }

            .carousel-control-prev-icon,
            .carousel-control-next-icon {
                background-color: rgba(0, 0, 0, 0.5);
                border-radius: 50%;
            }

            .carousel-control-prev, .carousel-control-next {
                width: 5%;
            }

            .carousel-inner {
                display: flex;
                align-items: center;
            }

            .carousel-indicators li {
                background-color: #28a745;
                border-radius: 50%;
            }

            h2 {
                color: #444;
                margin-bottom: 30px;
            }

            .container {
                max-width: 1200px;
            }
        </style>
    </head>

    <body>

        <jsp:include page="common/homepage/page-header.jsp"></jsp:include>

            <!-- Slider -->
            <section class="section-slide">
                <div class="wrap-slick1">
                    <div class="slick1">
                        <div class="item-slick1" style="background-image: url(${pageContext.request.contextPath}/images/slide-01.jpg);">
                        <div class="container h-full">
                            <div class="flex-col-l-m h-full p-t-100 p-b-30 respon5">
                                <div class="layer-slick1 animated visible-false" data-appear="fadeInDown" data-delay="0">
                                    <span class="ltext-101 cl2 respon2">
                                        Women Collection 2018
                                    </span>
                                </div>

                                <div class="layer-slick1 animated visible-false" data-appear="fadeInUp" data-delay="800">
                                    <h2 class="ltext-201 cl2 p-t-19 p-b-43 respon1">
                                        NEW SEASON
                                    </h2>
                                </div>

                                <div class="layer-slick1 animated visible-false" data-appear="zoomIn" data-delay="1600">
                                    <a href="shop" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
                                        Shop Now
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-slick1" style="background-image: url(${pageContext.request.contextPath}/images/slide-02.jpg);">
                        <div class="container h-full">
                            <div class="flex-col-l-m h-full p-t-100 p-b-30 respon5">
                                <div class="layer-slick1 animated visible-false" data-appear="rollIn" data-delay="0">
                                    <span class="ltext-101 cl2 respon2">
                                        Men New-Season
                                    </span>
                                </div>

                                <div class="layer-slick1 animated visible-false" data-appear="lightSpeedIn" data-delay="800">
                                    <h2 class="ltext-201 cl2 p-t-19 p-b-43 respon1">
                                        Jackets & Coats
                                    </h2>
                                </div>

                                <div class="layer-slick1 animated visible-false" data-appear="slideInUp" data-delay="1600">
                                    <a href="shop" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
                                        Shop Now
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="item-slick1" style="background-image: url(${pageContext.request.contextPath}/images/slide-03.jpg);">
                        <div class="container h-full">
                            <div class="flex-col-l-m h-full p-t-100 p-b-30 respon5">
                                <div class="layer-slick1 animated visible-false" data-appear="rotateInDownLeft" data-delay="0">
                                    <span class="ltext-101 cl2 respon2">
                                        Men Collection 2018
                                    </span>
                                </div>

                                <div class="layer-slick1 animated visible-false" data-appear="rotateInUpRight" data-delay="800">
                                    <h2 class="ltext-201 cl2 p-t-19 p-b-43 respon1">
                                        New arrivals
                                    </h2>
                                </div>

                                <div class="layer-slick1 animated visible-false" data-appear="rotateIn" data-delay="1600">
                                    <a href="shop" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04">
                                        Shop Now
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Banner -->
        <div class="sec-banner bg0 p-t-80 p-b-50">
            <div class="container">
                <div class="row">
                    <c:forEach items="${categoryList}" var="category">
                        <div class="col-md-6 col-xl-4 p-b-30 m-lr-auto">
                            <!-- Block1 -->
                            <div class="block1 wrap-pic-w">
                                <img src="${category.getImg()}" alt="IMG-BANNER" style="width: 14rem; height: 14rem">

                                <a href="shop?category=${category.getCategoryId()}" class="block1-txt ab-t-l s-full flex-col-l-sb p-lr-38 p-tb-34 trans-03 respon3">
                                    <div class="block1-txt-child1 flex-col-l">
                                        <span class="block1-name ltext-102 trans-04 p-b-8">
                                            ${category.getName()}
                                        </span>
                                    </div>

                                    <div class="block1-txt-child2 p-b-4 trans-05">
                                        <div class="block1-link stext-101 cl0 trans-09">
                                            Shop Now
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>


        <div>
            <section class="my-5 bg-light">
                <h2 class="text-center ltext-201 cl2 p-t-19 p-b-10 respon1" style="font-size: 30px">Latest Products</h2>
                <div class="container">
                    <div id="carouselThreeColumn1" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <c:set var="chunkSize" value="3"/>
                            <c:forEach var="product" items="${lastestProducts}" varStatus="status">
                                <c:if test="${status.index % chunkSize == 0}">
                                    <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                        <div class="row">
                                        </c:if>
                                        <div class="col-xl-4 p-1">
                                            <div class="card">
                                                <img src="${product.getImg1()}" class="img-fluid" style="height: 300px; cursor: pointer" onclick="location.href='${pageContext.request.contextPath}/product?id=${product.getProductId()}'">
                                                <div class="card-body">
                                                    <h5 class="text-center card-title mtext-105 cl2 js-name-detail" style="font-size: 20px">${product.name}</h5>
                                                    <p class="card-text text-center">$${product.price}</p>
                                                    <a href="${pageContext.request.contextPath}/product?id=${product.getProductId()}" class="btn btn-outline-success w-100">Shop Now</a>
                                                </div>
                                            </div>
                                        </div>
                                        <c:if test="${status.index % chunkSize == chunkSize - 1 || status.last}">
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <a class="carousel-control-prev" href="#carouselThreeColumn1" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselThreeColumn1" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>
            </section>
        </div>

        <div>
            <section class="my-5 bg-light">
                <h2 class="text-center ltext-201 cl2 p-t-19 p-b-10 respon1" style="font-size: 30px">Random Products</h2>
                <div class="container">
                    <div id="carouselThreeColumn2" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner">
                            <c:set var="chunkSize" value="3"/>
                            <c:forEach var="product" items="${randomProducts}" varStatus="status">
                                <c:if test="${status.index % chunkSize == 0}">
                                    <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                        <div class="row">
                                        </c:if>
                                        <div class="col-xl-4 p-1">
                                            <div class="card">
                                                <img src="${product.getImg1()}" class="img-fluid" style="height: 300px; cursor: pointer" onclick="location.href='${pageContext.request.contextPath}/product?id=${product.getProductId()}'">
                                                <div class="card-body">
                                                    <h5 class="text-center card-title mtext-105 cl2 js-name-detail" style="font-size: 20px">${product.name}</h5>
                                                    <p class="card-text text-center">$${product.price}</p>
                                                    <a href="${pageContext.request.contextPath}/product?id=${product.getProductId()}" class="btn btn-outline-success w-100">Shop Now</a>
                                                </div>
                                            </div>
                                        </div>
                                        <c:if test="${status.index % chunkSize == chunkSize - 1 || status.last}">
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <a class="carousel-control-prev" href="#carouselThreeColumn2" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#carouselThreeColumn2" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>
            </section>
        </div>


        <jsp:include page="common/homepage/page-footer.jsp"></jsp:include>


            <!-- Back to top -->
            <div class="btn-back-to-top" id="myBtn">
                <span class="symbol-btn-back-to-top">
                    <i class="zmdi zmdi-chevron-up"></i>
                </span>
            </div>


            <!--===============================================================================================-->
            <script src="${pageContext.request.contextPath}/vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/popper.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/select2/select2.min.js"></script>
        <script>
            $(".js-select2").each(function () {
                $(this).select2({
                    minimumResultsForSearch: 20,
                    dropdownParent: $(this).next('.dropDownSelect2')
                });
            })
        </script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/daterangepicker/moment.min.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/parallax100/parallax100.js"></script>
        <script>
            $('.parallax100').parallax100();
        </script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
        <script>
            $('.gallery-lb').each(function () { // the containers for all your galleries
                $(this).magnificPopup({
                    delegate: 'a', // the selector for gallery item
                    type: 'image',
                    gallery: {
                        enabled: true
                    },
                    mainClass: 'mfp-fade'
                });
            });
        </script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/isotope/isotope.pkgd.min.js"></script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/sweetalert/sweetalert.min.js"></script>
        <script>
            $('.js-addwish-b2').on('click', function (e) {
                e.preventDefault();
            });

            $('.js-addwish-b2').each(function () {
                var nameProduct = $(this).parent().parent().find('.js-name-b2').jsp();
                $(this).on('click', function () {
                    swal(nameProduct, "is added to wishlist !", "success");

                    $(this).addClass('js-addedwish-b2');
                    $(this).off('click');
                });
            });

            $('.js-addwish-detail').each(function () {
                var nameProduct = $(this).parent().parent().parent().find('.js-name-detail').jsp();

                $(this).on('click', function () {
                    swal(nameProduct, "is added to wishlist !", "success");

                    $(this).addClass('js-addedwish-detail');
                    $(this).off('click');
                });
            });

            /*---------------------------------------------*/

            $('.js-addcart-detail').each(function () {
                var nameProduct = $(this).parent().parent().parent().parent().find('.js-name-detail').jsp();
                $(this).on('click', function () {
                    swal(nameProduct, "is added to cart !", "success");
                });
            });
        </script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
        <script>
            $('.js-pscroll').each(function () {
                $(this).css('position', 'relative');
                $(this).css('overflow', 'hidden');
                var ps = new PerfectScrollbar(this, {
                    wheelSpeed: 1,
                    scrollingThreshold: 1000,
                    wheelPropagation: false,
                });

                $(window).on('resize', function () {
                    ps.update();
                })
            });
        </script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/js/main.js"></script>

    </body>
</html>
