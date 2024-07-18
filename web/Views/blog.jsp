<%-- 
    Document   : blog
    Created on : May 19, 2024, 3:17:18 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Blog</title>
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

           
        <!-- Title page -->
        <section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('${pageContext.request.contextPath}/images/blog/bg-02.jpg');">
            <h2 class="ltext-105 cl0 txt-center">
                Blog
            </h2>
        </section>


        <!-- Content page -->
        <section class="bg0 p-t-62 p-b-60">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-lg-9 p-b-80">
                        <div class="p-r-45 p-r-0-lg">
                            
                            <!-- item blog -->
                            <c:forEach items="${blogs}" var="i">
                                <div class="p-b-63">
                                <a href="blog-detail?id=${i.blogId}" class="hov-img0 how-pos5-parent">
                                    <img src="${pageContext.request.contextPath}/images/blog/blog-04.jpg" alt="IMG-BLOG">
                                </a>

                                <div class="p-t-32">
                                    <h4 class="p-b-15">
                                        <a href="blog-detail?id=${i.blogId}" class="ltext-108 cl2 hov-cl1 trans-04">
                                            ${i.title}
                                        </a>
                                    </h4>

                                    <p class="stext-117 cl6">
                                            ${i.body}
                                    <div class="flex-w flex-sb-m p-t-18">


                                        <a href="blog-detail?id=${i.blogId}" class="stext-101 cl2 hov-cl1 trans-04 m-tb-10">
                                            Continue Reading

                                            <i class="fa fa-long-arrow-right m-l-9"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                           

                            <!-- Pagination -->
                            <div class="flex-l-m flex-w w-full p-t-10 m-lr--7">
                                <a href="#" class="flex-c-m how-pagination1 trans-04 m-all-7 active-pagination1">
                                    1
                                </a>

                                <a href="#" class="flex-c-m how-pagination1 trans-04 m-all-7">
                                    2
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 col-lg-3 p-b-80">
                        <div class="side-menu">


                            <div class="p-t-55">
                                <h4 class="mtext-112 cl2 p-b-33">
                                    Categories
                                </h4>

                                <ul>
                                    <li class="bor18">
                                        <a href="#" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4">
                                            Fashion
                                        </a>
                                    </li>

                                    <li class="bor18">
                                        <a href="#" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4">
                                            Beauty
                                        </a>
                                    </li>

                                    <li class="bor18">
                                        <a href="#" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4">
                                            Street Style
                                        </a>
                                    </li>

                                    <li class="bor18">
                                        <a href="#" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4">
                                            Life Style
                                        </a>
                                    </li>

                                    <li class="bor18">
                                        <a href="#" class="dis-block stext-115 cl6 hov-cl1 trans-04 p-tb-8 p-lr-4">
                                            DIY & Crafts
                                        </a>
                                    </li>
                                </ul>
                            </div>

                            <div class="p-t-65">
                                <h4 class="mtext-112 cl2 p-b-33">
                                    Featured Products
                                </h4>

                                <ul>
                                    <li class="flex-w flex-t p-b-30">
                                        <a href="#" class="wrao-pic-w size-214 hov-ovelay1 m-r-20">
                                            <img src="${pageContext.request.contextPath}/images/blog/product-min-01.jpg" alt="PRODUCT">
                                        </a>

                                        <div class="size-215 flex-col-t p-t-8">
                                            <a href="#" class="stext-116 cl8 hov-cl1 trans-04">
                                                COCO TEE
                                            </a>

                                            <span class="stext-116 cl6 p-t-20">
                                                $19.00
                                            </span>
                                        </div>
                                    </li>

                                    <li class="flex-w flex-t p-b-30">
                                        <a href="#" class="wrao-pic-w size-214 hov-ovelay1 m-r-20">
                                            <img src="${pageContext.request.contextPath}/images/blog/product-min-02.jpg" alt="PRODUCT">
                                        </a>

                                        <div class="size-215 flex-col-t p-t-8">
                                            <a href="#" class="stext-116 cl8 hov-cl1 trans-04">
                                                AQUILINE LEATHER JACKET
                                            </a>

                                            <span class="stext-116 cl6 p-t-20">
                                                $39.00
                                            </span>
                                        </div>
                                    </li>

                                    <li class="flex-w flex-t p-b-30">
                                        <a href="#" class="wrao-pic-w size-214 hov-ovelay1 m-r-20">
                                            <img src="${pageContext.request.contextPath}/images/blog/product-min-03.jpg" alt="PRODUCT">
                                        </a>

                                        <div class="size-215 flex-col-t p-t-8">
                                            <a href="#" class="stext-116 cl8 hov-cl1 trans-04">
                                                TIGER VARSITY JACKET
                                            </a>

                                            <span class="stext-116 cl6 p-t-20">
                                                $17.00
                                            </span>
                                        </div>
                                    </li>
                                </ul>
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
