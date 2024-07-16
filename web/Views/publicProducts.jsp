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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

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
        <style>
            .filter-section {
                padding: 20px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background-color: #f9f9f9;
            }

            .filter-section h5 {
                font-weight: bold;
                margin-bottom: 15px;
            }

            .filter-section .form-group {
                margin-bottom: 15px;
            }

            .filter-section label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            .filter-section input[type="radio"] + label {
                display: inline-grid;
                width: auto;
                padding: 5px 10px;
                cursor: pointer;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .filter-section input[type="radio"]:checked + label {
                background-color: #ddd;
                color: black;
                border-color: black;
            }

            .filter-section .btn {
                margin-top: 10px;
            }
            .color-palette {
                display: block;
                flex-wrap: wrap;
                gap: 5px;
            }

            .color-box-filter {
                width:  30px !important;
                height: 30px;
                border-radius: 50% !important;
                cursor: pointer !important;
                border: 2px solid #ddd !important;
            }

            .color-box-filter .checkmark {
                width: 30px;
                height: 30px;
                background-image: url('${pageContext.request.contextPath}/images/icons/checkmark.png'); /* Replace with the correct path to the checkmark image */
                background-size: 50%; /* Adjust size as needed */
                background-repeat: no-repeat;
                background-position: center;
                display: none;
            }

            .btn-check:checked + .color-box-filter .checkmark {
                display: block;
            }
        </style>

    </head>

    <body>

        <jsp:include page="common/homepage/page-header.jsp"></jsp:include>
        <c:if test="${notification ne null}">
            <div id="alert" class="alert-box ${type}">
                ${notification}
            </div>
        </c:if>
        <!-- Product -->
        <div class="bg0 m-t-23 p-b-140">
            <div class="container">
                <div class="flex-w flex-sb-m p-b-52 d-flex justify-content-end">
                    <div class="flex-w flex-c-m m-tb-10">
                        <div class="flex-c-m stext-106 m-r-15">
                            ${numOfProduct} Items
                        </div>
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
                        <form action="shop" method="get">
                            <div class="bor8 dis-flex p-l-15">
                                <button class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
                                    <i class="zmdi zmdi-search" onclick="this.closest('form').submit()"></i>
                                </button>

                                <input class="mtext-107 cl2 size-114 plh2 p-r-15" type="text" name="search" placeholder="Search" value="${param.search}" />
                                <input name="page" value="1" hidden />
                            </div>
                        </form>
                    </div>

                    <!-- Filter -->
                    <div class="dis-none panel-filter w-full p-t-10">
                        <div class="wrap-filter bg6 w-full p-lr-40 p-t-27 p-lr-15-sm filter-section">
                            <h5>Filter</h5>
                            <form action="shop" method="get">
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="form-group col">
                                            <label>Category:</label>
                                            <div>
                                                <input class="btn-check" type="radio" id="category-all" name="category" value="0" 
                                                       <c:if test="${empty param.category || param.category == 0}">checked</c:if> />
                                                       <label for="category-all">All</label>
                                                       <br />
                                                <c:forEach items="${categoryList}" var="cate">
                                                    <input class="btn-check" type="radio" id="category-${cate.getName()}" name="category" value="${cate.getCategoryId()}"
                                                           <c:if test="${param.category eq cate.getCategoryId()}">checked</c:if> />
                                                    <label for="category-${cate.getName()}">${cate.getName()}</label>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <div class="form-group col">
                                            <label>Price:</label>
                                            <div>
                                                <input class="btn-check" type="radio" id="price-all" name="price" value="all" 
                                                       <c:if test="${empty param.price || param.price eq 'all'}">checked</c:if> />
                                                       <label for="price-all">All</label>
                                                       <br />
                                                       <input class="btn-check" type="radio" id="price-0-15" name="price" value="0-15" 
                                                       <c:if test="${param.price eq '0-15'}">checked</c:if> />
                                                       <label for="price-0-15">0 - 15</label>
                                                       <input class="btn-check" type="radio" id="price-15-25" name="price" value="15-25" 
                                                       <c:if test="${param.price eq '15-25'}">checked</c:if> />
                                                       <label for="price-15-25">15 - 25</label>
                                                       <input class="btn-check" type="radio" id="price-25-50" name="price" value="25-50"
                                                       <c:if test="${param.price eq '25-50'}">checked</c:if> />
                                                       <label for="price-25-50">25 - 50</label>
                                                       <input class="btn-check" type="radio" id="price-999" name="price" value="50-999"
                                                       <c:if test="${param.price eq '50-999'}">checked</c:if> />
                                                       <label for="price-999">50+</label>
                                                </div>
                                            </div>

                                            <div class="form-group col">
                                                <label>Size:</label>
                                                <div>
                                                    <input class="btn-check" type="radio" id="size-all" name="size" value="all"
                                                    <c:if test="${empty param.size || param.size eq 'all'}">checked</c:if> />
                                                    <label for="size-all">All</label>
                                                    <br />
                                                    <input class="btn-check" type="radio" id="size-s" name="size" value="S"
                                                    <c:if test="${param.size eq 'S'}">checked</c:if> />
                                                    <label for="size-s">S</label>
                                                    <input class="btn-check" type="radio" id="size-m" name="size" value="M"
                                                    <c:if test="${param.size eq 'M'}">checked</c:if> />
                                                    <label for="size-m">M</label>
                                                    <input class="btn-check" type="radio" id="size-l" name="size" value="L"
                                                    <c:if test="${param.size eq 'L'}">checked</c:if> />
                                                    <label for="size-l">L</label>
                                                    <input class="btn-check" type="radio" id="size-xl" name="size" value="XL"
                                                    <c:if test="${param.size eq 'XL'}">checked</c:if> />
                                                    <label for="size-xl">XL</label>
                                                </div>
                                            </div>

                                            <div class="form-group col">
                                                <label>Color:</label>
                                                <div class="color-palette">
                                                    <input class="btn-check" type="radio" id="color-all" name="color" value="all" hidden
                                                    <c:if test="${empty param.color || param.color eq 'all'}">checked</c:if> />
                                                    <label for="color-all" hidden>All</label>
                                                    <input class="btn-check" type="radio" id="color-white" name="color" value="white" 
                                                    <c:if test="${param.color eq 'white'}">checked</c:if> />
                                                    <label for="color-white" class="color-box-filter" style="background-color: white;">
                                                        <span class="checkmark"></span>
                                                    </label>

                                                    <input class="btn-check" type="radio" id="color-black" name="color" value="black" 
                                                    <c:if test="${param.color eq 'black'}">checked</c:if> />
                                                    <label for="color-black" class="color-box-filter" style="background-color: black;">
                                                        <span class="checkmark"></span>
                                                    </label>

                                                    <input class="btn-check" type="radio" id="color-blue" name="color" value="blue" 
                                                    <c:if test="${param.color eq 'blue'}">checked</c:if> />
                                                    <label for="color-blue" class="color-box-filter" style="background-color: blue;">
                                                        <span class="checkmark"></span>
                                                    </label>

                                                    <input class="btn-check" type="radio" id="color-brown" name="color" value="brown" 
                                                    <c:if test="${param.color eq 'brown'}">checked</c:if> />
                                                    <label for="color-brown" class="color-box-filter" style="background-color: brown;">
                                                        <span class="checkmark"></span>
                                                    </label>

                                                    <input class="btn-check" type="radio" id="color-green" name="color" value="green" 
                                                    <c:if test="${param.color eq 'green'}">checked</c:if> />
                                                    <label for="color-green" class="color-box-filter" style="background-color: green;">
                                                        <span class="checkmark"></span>
                                                    </label>

                                                    <input class="btn-check" type="radio" id="color-grey" name="color" value="grey" 
                                                    <c:if test="${param.color eq 'grey'}">checked</c:if> />
                                                    <label for="color-grey" class="color-box-filter" style="background-color: grey;">
                                                        <span class="checkmark"></span>
                                                    </label>

                                                    <input class="btn-check" type="radio" id="color-tan" name="color" value="tan" 
                                                    <c:if test="${param.color eq 'tan'}">checked</c:if> />
                                                    <label for="color-tan" class="color-box-filter" style="background-color: tan;">
                                                        <span class="checkmark"></span>
                                                    </label>

                                                    <input class="btn-check" type="radio" id="color-orange" name="color" value="orange" 
                                                    <c:if test="${param.color eq 'orange'}">checked</c:if> />
                                                    <label for="color-orange" class="color-box-filter" style="background-color: orange;">
                                                        <span class="checkmark"></span>
                                                    </label>

                                                    <input class="btn-check" type="radio" id="color-pink" name="color" value="pink" 
                                                    <c:if test="${param.color eq 'pink'}">checked</c:if> />
                                                    <label for="color-pink" class="color-box-filter" style="background-color: pink;">
                                                        <span class="checkmark"></span>
                                                    </label>

                                                    <input class="btn-check" type="radio" id="color-purple" name="color" value="purple" 
                                                    <c:if test="${param.color eq 'purple'}">checked</c:if> />
                                                    <label for="color-purple" class="color-box-filter" style="background-color: purple;">
                                                        <span class="checkmark"></span>
                                                    </label>

                                                    <input class="btn-check" type="radio" id="color-red" name="color" value="red" 
                                                    <c:if test="${param.color eq 'red'}">checked</c:if> />
                                                    <label for="color-red" class="color-box-filter" style="background-color: red;">
                                                        <span class="checkmark"></span>
                                                    </label>

                                                    <input class="btn-check" type="radio" id="color-yellow" name="color" value="yellow" 
                                                    <c:if test="${param.color eq 'yellow'}">checked</c:if> />
                                                    <label for="color-yellow" class="color-box-filter" style="background-color: yellow;">
                                                        <span class="checkmark"></span>
                                                    </label>
                                                </div>
                                            </div>


                                            <div class="form-group col">
                                                <label>Sort by:</label>
                                                <div>
                                                    <input class="btn-check" type="radio" id="sortAll" name="sort" value="default" 
                                                    <c:if test="${empty param.sort || param.sort eq 'default'}">checked</c:if> />
                                                    <label for="sortAll">Default</label>
                                                    <br />
                                                    <input class="btn-check" type="radio" id="sortNAsc" name="sort" value="name-asc"
                                                    <c:if test="${param.sort == 'name-asc'}">checked</c:if> />
                                                    <label for="sortNAsc">Name (A-Z)</label>
                                                    <input class="btn-check" type="radio" id="sortNDesc" name="sort" value="name-desc"
                                                    <c:if test="${param.sort == 'name-desc'}">checked</c:if> />
                                                    <label for="sortNDesc">Name (Z-A)</label>
                                                    <input class="btn-check" type="radio" id="sortPAsc" name="sort" value="price-asc"
                                                    <c:if test="${param.sort == 'price-asc'}">checked</c:if> />
                                                    <label for="sortPAsc">Price (Low to High)</label>
                                                    <input type="radio" id="sortPDesc" class="btn-check" name="sort" value="price-desc"
                                                    <c:if test="${param.sort == 'price-desc'}">checked</c:if> />
                                                    <label for="sortPDesc">Price (High to Low)</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                <c:if test="${param.search ne null || not empty param.search}"><input type="hidden" id="search" name="search" value="${param.search}"></c:if>
                                    <input type="hidden" value="1" name="page" />
                                    <button type="submit" class="btn btn-primary">Apply Filters</button> 
                                    <button type="button" class="btn btn-secondary" onclick="location.href = 'shop'">Reset Filters</button>
                                </form>

                            </div>
                        </div>
                    </div>
                <c:if test="${numOfProduct == 0}">
                    <div class="row d-flex justify-content-center">
<!--                        <img style="width: 500px" src="${pageContext.request.contextPath}/images/cart/product-not-found.jpg" alt="Not found" />-->
                        <img style="width: 100%" src="${pageContext.request.contextPath}/images/cart/no-product-found.jpg" alt="Not found" />
                    </div>
                    <div class="row d-flex justify-content-center">
                        <button class="col-2 btn text-center text-white" style="background-color: orange"
                                onclick="location.href='shop'">Go back</button>
                    </div>
                </c:if>
                <c:if test="${numOfProduct > 0}">
                    <div class="row isotope-grid">
                        <c:forEach items="${productList}" var="product">
                            <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item">
                                <div class="block2">
                                    <div class="block2-pic hov-img0">
                                        <c:set var="variant" value="${product.getFirstInStock()}"></c:set>
                                        <c:if test="${variant ne null}">
                                            <a href="${pageContext.request.contextPath}/product?id=${product.getProductId()}&color=${variant.getColor()}&size=${variant.getSize()}">
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
                                            <div class="flex-m p-r-10 m-r-11">
                                                <form action="${pageContext.request.contextPath}/customer/wishlist" method="post">
                                                    <input type="hidden" name="productId" value="${product.getProductId()}">
                                                    <input type="hidden" name="action" value="add">
                                                    <button type="submit" style="background: none; border: none; cursor: pointer;">
                                                        <i class="zmdi zmdi-favorite"></i>
                                                    </button>
                                                </form>
                                            </div>

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
                                    <li class="page-item"><a class="page-link" href="shop?${query}&page=${page}">${page}</a></li>
                                    </c:forEach>



                            </ul>
                        </nav>
                    </div>
                </c:if>


            </div>
        </div>


        <jsp:include page="common/homepage/page-footer.jsp"></jsp:include>





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

                                        document.addEventListener('DOMContentLoaded', function () {

                                            const alert = document.querySelector('#alert');

                                            if (alert) {
                                                alert.style.display = 'block';
                                                alert.style.opacity = '1';

                                                setTimeout(function () {
                                                    alert.style.opacity = '0';

                                                    setTimeout(function () {
                                                        alert.classList.add('show');
                                                    }, 500);
                                                }, 4000);
                                            }

                                        });

        </script>

    </body>
</html>
