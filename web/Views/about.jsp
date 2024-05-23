<%-- 
    Document   : about
    Created on : May 19, 2024, 3:16:24 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>About</title>
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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/util.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
        <!--===============================================================================================-->
    </head>

    <body>

        <jsp:include page="common/homepage/page-header.jsp"></jsp:include>

            <!-- Cart -->
            <div class="wrap-header-cart js-panel-cart">
                <div class="s-full js-hide-cart"></div>

                <div class="header-cart flex-col-l p-l-65 p-r-25">
                    <div class="header-cart-title flex-w flex-sb-m p-b-8">
                        <span class="mtext-103 cl2">
                            Your Cart
                        </span>

                        <div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart">
                            <i class="zmdi zmdi-close"></i>
                        </div>
                    </div>

                    <div class="header-cart-content flex-w js-pscroll">
                        <ul class="header-cart-wrapitem w-full">
                            <li class="header-cart-item flex-w flex-t m-b-12">
                                <div class="header-cart-item-img">
                                    <img src="${pageContext.request.contextPath}/images/item-cart-01.jpg" alt="IMG">
                            </div>

                            <div class="header-cart-item-txt p-t-8">
                                <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
                                    White Shirt Pleat
                                </a>

                                <span class="header-cart-item-info">
                                    1 x $19.00
                                </span>
                            </div>
                        </li>

                        <li class="header-cart-item flex-w flex-t m-b-12">
                            <div class="header-cart-item-img">
                                <img src="${pageContext.request.contextPath}/images/item-cart-02.jpg" alt="IMG">
                            </div>

                            <div class="header-cart-item-txt p-t-8">
                                <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
                                    Converse All Star
                                </a>

                                <span class="header-cart-item-info">
                                    1 x $39.00
                                </span>
                            </div>
                        </li>

                        <li class="header-cart-item flex-w flex-t m-b-12">
                            <div class="header-cart-item-img">
                                <img src="${pageContext.request.contextPath}/images/item-cart-03.jpg" alt="IMG">
                            </div>

                            <div class="header-cart-item-txt p-t-8">
                                <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">
                                    Nixon Porter Leather
                                </a>

                                <span class="header-cart-item-info">
                                    1 x $17.00
                                </span>
                            </div>
                        </li>
                    </ul>

                    <div class="w-full">
                        <div class="header-cart-total w-full p-tb-40">
                            Total: $75.00
                        </div>

                        <div class="header-cart-buttons flex-w w-full">
                            <a href="shoping-cart.jsp" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-r-8 m-b-10">
                                View Cart
                            </a>

                            <a href="shoping-cart.jsp" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
                                Check Out
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- Title page -->
        <section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('${pageContext.request.contextPath}/images/bg-01.jpg');">
            <h2 class="ltext-105 cl0 txt-center">
                About
            </h2>
        </section>


        <!-- Content page -->
        <section class="bg0 p-t-75 p-b-120">
            <div class="container">
                <div class="row p-b-148">
                    <div class="col-md-7 col-lg-8">
                        <div class="p-t-7 p-r-85 p-r-15-lg p-r-0-md">
                            <h3 class="mtext-111 cl2 p-b-16">
                                WHO WE ARE
                            </h3>

                            <p class="stext-113 cl6 p-b-26">
                                As one of the pioneering fashion brands, established in 2020, Urban Vibes has now become a familiar name among young streetwear fashion 
                                enthusiasts. With a focus on providing youthful, stylish products while maintaining a perfect balance between price and quality, 
                                Urban Vibes has made a significant mark in the fashion market.
                            </p>

                            <p class="stext-113 cl6 p-b-26">
                                With a team of young, dynamic, and dedicated staff, Urban Vibes constantly strives to evolve and learn every day to keep up with the 
                                latest fashion trends. Urban Vibes' designs always incorporate creativity based on artistic figures or sometimes ordinary images from 
                                daily life. This approach results in unique products that carry their own distinct personality and style.

                            </p>

                        </div>
                    </div>

                    <div class="col-11 col-md-5 col-lg-4 m-lr-auto">
                        <div class="how-bor1 ">
                            <div class="hov-img0">
                                <img src="${pageContext.request.contextPath}/images/about-01.jpg" alt="IMG">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="order-md-2 col-md-7 col-lg-8 p-b-30">
                        <div class="p-t-7 p-l-85 p-l-15-lg p-l-0-md">
                            <h3 class="mtext-111 cl2 p-b-16">
                                WHAT WE HAVE
                            </h3>

                            <p class="stext-113 cl6 p-b-26">
                                Urban Vibes not only attracts attention with its youthful, dynamic designs that clearly express fashion personality but
                                also provides users with an exceptional quality of apparel. The brand impresses with its meticulous selection of materials and thoughtful
                                attention to customer experience: sweat-wicking, lightly stretchy t-shirts that ensure comfort for the wearer; jackets that always have two
                                layers with perfect materials to keep warm in winter while remaining breathable in summer.

                                Urban Vibes firmly believes that the quality of its products can satisfy even the most discerning customers.

                            </p>

                            <div class="bor16 p-l-29 p-b-9 m-t-22">
                                <p class="stext-114 cl6 p-r-40 p-b-11">
                                    Fashion is the armor to survive the reality of everyday life
                                </p>

                                <span class="stext-111 cl8">
                                    - Bill Cunningham
                                </span>
                            </div>
                        </div>
                    </div>

                    <div class="order-md-1 col-11 col-md-5 col-lg-4 m-lr-auto p-b-30">
                        <div class="how-bor2">
                            <div class="hov-img0">
                                <img src="${pageContext.request.contextPath}/images/about-02.jpg" alt="IMG">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>



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
        <script src="${pageContext.request.contextPath}/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
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
