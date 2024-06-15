<%-- 
   Document   : product
   Created on : May 19, 2024, 3:15:55 PM
   Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Product</title>
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
    </head>

    <body>

        <jsp:include page="common/homepage/page-header.jsp"></jsp:include>

            <!-- Product -->
            <div class="bg0 m-t-23 p-b-140">
                <div class="container">
                    <div class="flex-w flex-sb-m p-b-52">
                        <div class="flex-w flex-l-m filter-tope-group m-tb-10">
                            <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 how-active1" data-filter="*">
                                All Products
                            </button>

                        <c:forEach items="${categoryList}" var="category">
                            <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" onclick='location.href = "shop?categoryId=${category.getCategoryId()}"'>
                                ${category.getName()}
                            </button>
                        </c:forEach>

                    </div>

                    <div class="flex-w flex-c-m m-tb-10">
                        <div class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 js-show-filter">
                            <i class="icon-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-filter-list"></i>
                            <i class="icon-close-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i> Filter
                        </div>

                        <div class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search">
                            <i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"></i>
                            <i class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i> Search
                        </div>
                    </div>

                    <!-- Search product -->
                    <div class="dis-none panel-search w-full p-t-10 p-b-15">
                        <div class="bor8 dis-flex p-l-15">
                            <button class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
                                <i class="zmdi zmdi-search"></i>
                            </button>

                            <input class="mtext-107 cl2 size-114 plh2 p-r-15" type="text" name="search-product" placeholder="Search">
                        </div>
                    </div>

                    <!-- Filter -->
                    <div class="dis-none panel-filter w-full p-t-10">
                        <div class="wrap-filter flex-w bg6 w-full p-lr-40 p-t-27 p-lr-15-sm">
                            <div class="filter-col1 p-r-15 p-b-27">
                                <div class="mtext-102 cl2 p-b-15">
                                    Sort By
                                </div>

                                <ul>
                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04 filter-link-active">
                                            Default
                                        </a>
                                    </li>

                                    <!--                                    <li class="p-b-6">
                                                                            <a href="#" class="filter-link stext-106 trans-04">
                                                                                High rating
                                                                            </a>
                                                                        </li>-->

                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04">
                                            Price: Low to High
                                        </a>
                                    </li>

                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04">
                                            Price: High to Low
                                        </a>
                                    </li>
                                </ul>
                            </div>

                            <div class="filter-col2 p-r-15 p-b-27">
                                <div class="mtext-102 cl2 p-b-15">
                                    Price
                                </div>

                                <ul>
                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04 filter-link-active">
                                            All
                                        </a>
                                    </li>

                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04">
                                            $0.00 - $15.00
                                        </a>
                                    </li>

                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04">
                                            $15.00 - $25.00
                                        </a>
                                    </li>

                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04">
                                            $25.00 - $50.00
                                        </a>
                                    </li>

                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04">
                                            $50.00+
                                        </a>
                                    </li>

                                </ul>
                            </div>

                            <div class="filter-col3 p-r-15 p-b-27">
                                <div class="mtext-102 cl2 p-b-15">
                                    Color
                                </div>

                                <div class="d-flex">

                                    <ul class="mr-5">

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: #aaa;">
                                                <i class="zmdi zmdi-circle-o"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04 filter-link-active">
                                                All
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: #222;">
                                                <i class="zmdi zmdi-circle"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Black
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: white;">
                                                <i class="zmdi zmdi-circle"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                White
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: #FFFDD0;">
                                                <i class="zmdi zmdi-circle"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Cream
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: #808080;">
                                                <i class="zmdi zmdi-circle"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Gray
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: #FFC0CB;">
                                                <i class="zmdi zmdi-circle"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Pink
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: red;">
                                                <i class="zmdi zmdi-circle-o"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Red
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: orange;">
                                                <i class="zmdi zmdi-circle-o"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Orange
                                            </a>
                                        </li>

                                    </ul>

                                    <ul>
                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: #F5F5DC;">
                                                <i class="zmdi zmdi-circle"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Beige
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: #964B00;">
                                                <i class="zmdi zmdi-circle"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Brown
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: #FFFF00;">
                                                <i class="zmdi zmdi-circle"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Yellow
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: #8A9A5B;">
                                                <i class="zmdi zmdi-circle"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Moss Green
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: #008000;">
                                                <i class="zmdi zmdi-circle"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Green
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: mintcream;">
                                                <i class="zmdi zmdi-circle-o"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Mint
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: blue;">
                                                <i class="zmdi zmdi-circle-o"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Navy
                                            </a>
                                        </li>

                                        <li class="p-b-6">
                                            <span class="fs-15 lh-12 m-r-6" style="color: #A020F0;">
                                                <i class="zmdi zmdi-circle"></i>
                                            </span>

                                            <a href="#" class="filter-link stext-106 trans-04">
                                                Purple
                                            </a>
                                        </li>

                                    </ul>


                                </div>
                            </div>

                            <div class="filter-col4 p-r-15 p-b-27">
                                <div class="mtext-102 cl2 p-b-15">
                                    Size
                                </div>

                                <ul>
                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04 filter-link-active">
                                            All
                                        </a>
                                    </li>

                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04">
                                            S
                                        </a>
                                    </li>

                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04">
                                            M
                                        </a>
                                    </li>

                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04">
                                            L
                                        </a>
                                    </li>

                                    <li class="p-b-6">
                                        <a href="#" class="filter-link stext-106 trans-04">
                                            XL
                                        </a>
                                    </li>

                                </ul>
                            </div>

                        </div>
                    </div>
                </div>

                <div class="row isotope-grid">
                    <c:forEach items="${productList}" var="product">
                        <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item">
                            <div class="block2">
                                <div class="block2-pic hov-img0">
                                    <c:set var="variant" value="${product.getFirstInStock()}"></c:set>
                                    <c:if test="${variant ne null}">
                                        <a href="${pageContext.request.contextPath}/product?id=${product.getProductId()}&size=${variant.getSize()}&color=${variant.getColor()}">
                                        </c:if>
                                        <c:if test="${variant eq null}">
                                            <a href="${pageContext.request.contextPath}/product?id=${product.getProductId()}">
                                            </c:if>
                                            <img src="${product.getImg1()}" style="height: 250px; width: 250px;" alt="IMG-PRODUCT">

                                        </a>
                                </div>
                                <div class="block2-txt flex-w flex-t p-t-14">
                                    <div class="block2-txt-child1 flex-col-l">
                                        <a href="${pageContext.request.contextPath}/product?id=${product.getProductId()}" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                                            ${product.getName()}
                                        </a>
                                        <span class="stext-105 cl3">
                                            $${product.getPrice()}
                                        </span>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="row d-flex justify-content-center">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">


                            <c:forEach begin="1" end="${totalPageNumber}" var="page">
                                <li class="page-item"><a class="page-link" href="shop?page=${page}">${page}</a></li>
                                </c:forEach>



                        </ul>
                    </nav>
                </div>


            </div>
        </div>


        <jsp:include page="common/homepage/page-footer.jsp"></jsp:include>



            <!--  -->
            <div class="flex-w flex-m p-l-100 p-t-40 respon7">
                <div class="flex-m bor9 p-r-10 m-r-11">
                    <a href="#" class="fs-14 cl3 hov-cl1 trans-04 lh-10 p-lr-5 p-tb-2 js-addwish-detail tooltip100" data-tooltip="Add to Wishlist">
                        <i class="zmdi zmdi-favorite"></i>
                    </a>
                </div>

                <a href="#" class="fs-14 cl3 hov-cl1 trans-04 lh-10 p-lr-5 p-tb-2 m-r-8 tooltip100" data-tooltip="Facebook">
                    <i class="fa fa-facebook"></i>
                </a>

                <a href="#" class="fs-14 cl3 hov-cl1 trans-04 lh-10 p-lr-5 p-tb-2 m-r-8 tooltip100" data-tooltip="Twitter">
                    <i class="fa fa-twitter"></i>
                </a>

                <a href="#" class="fs-14 cl3 hov-cl1 trans-04 lh-10 p-lr-5 p-tb-2 m-r-8 tooltip100" data-tooltip="Google Plus">
                    <i class="fa fa-google-plus"></i>
                </a>
            </div>
        </div>
    </div>
</div>
</div>
</div>
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
                                $('.js-addwish-b2, .js-addwish-detail').on('click', function (e) {
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

<script>



</script>

</body>
</html>
