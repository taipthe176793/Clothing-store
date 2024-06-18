<%-- 
    Document   : productDetail
    Created on : 26 thg 5, 2024, 14:38:32
    Author     : caoqu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>ProductDetail</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
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
            .star {
                font-size: 24px;
                color: gray;
            }

        </style>
    </head>

    <body>

        <jsp:include page="common/homepage/page-header.jsp"></jsp:include>




            <div class="container">
                <div class="bg0 p-t-60 p-b-30 p-lr-15-lg how-pos3-parent">

                    <div class="row">

                        <div class="col-md-6 col-lg-7 p-b-30">
                            <div class="p-l-25 p-r-30 p-lr-0-lg">
                                <div class="wrap-slick3 flex-sb flex-w">
                                    <div class="wrap-slick3-dots"></div>
                                    <div class="wrap-slick3-arrows flex-sb-m flex-w"></div>

                                    <div class="slick3 gallery-lb">
                                        <div class="item-slick3" data-thumb="${product.getImg1()}">
                                        <div class="wrap-pic-w pos-relative">
                                            <img src="${product.getImg1()}" alt="IMG-PRODUCT">

                                            <a class="flex-c-m size-108 how-pos1 bor0 fs-16 cl10 bg0 hov-btn3 trans-04" href="${product.getImg1()}">
                                                <i class="fa fa-expand"></i>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="item-slick3" data-thumb="${product.getImg2()}">
                                        <div class="wrap-pic-w pos-relative">
                                            <img src="${product.getImg2()}" alt="IMG-PRODUCT">

                                            <a class="flex-c-m size-108 how-pos1 bor0 fs-16 cl10 bg0 hov-btn3 trans-04" href="${product.getImg2()}">
                                                <i class="fa fa-expand"></i>
                                            </a>
                                        </div>
                                    </div>

                                    <div class="item-slick3" data-thumb="${product.getImg3()}">
                                        <div class="wrap-pic-w pos-relative">
                                            <img src="${product.getImg3()}" alt="IMG-PRODUCT">

                                            <a class="flex-c-m size-108 how-pos1 bor0 fs-16 cl10 bg0 hov-btn3 trans-04" href="${product.getImg3()}">
                                                <i class="fa fa-expand"></i>
                                            </a>
                                        </div>
                                    </div>
                                </div>





                            </div>
                        </div>
                    </div>

                    <div class="col-md-6 col-lg-5 p-b-30">
                        <div class="p-r-50 p-t-5 p-lr-0-lg">
                            <h4 class="mtext-105 cl2 js-name-detail p-b-14">
                                ${product.name}
                            </h4>

                            <span class="mtext-106 cl2">
                                $${product.price}
                            </span>
                            <div id="rating-container">
                                <span class="star">&#9733;</span>
                                <span class="star ">&#9733;</span>
                                <span class="star ">&#9733;</span>
                                <span class="star ">&#9733;</span>
                                <span class="star">&#9733;</span>
                            </div>

                            <form action="cart?action=addToCart" method="post" >
                                <input type="hidden" name="id" value="${product.productId}" />

                                <div class="p-t-33">

                                    <div class="flex-w flex-r-m p-b-10">
                                        <div class="size-203 flex-c-m respon6">
                                            Color
                                        </div>
                                        <div class="size-204 respon6-next">
                                            <div class="rs1-select2 bg0">
                                                <c:forEach var="vColor" items="${product.getSortedVariantColors()}">
                                                    <input name="color" onclick="location.href = 'product?id=${product.getProductId()}&color=${vColor}&size=${size}'" type="radio" id="${vColor}" class="btn btn-check" value="${vColor}"
                                                           <c:if test="${vColor eq color}">checked</c:if>
                                                               />
                                                           <label class="btn btn-white btn-outline-dark" for="${vColor}">${vColor}</label>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="flex-w flex-r-m p-b-10">
                                        <div class="size-203 flex-c-m respon6">
                                            Size
                                        </div>
                                        <div class="size-204 respon6-next">
                                            <div class="rs1-select2 bg0">
                                                <c:forEach var="vSize" items="${product.getSortedVariantSizes()}">
                                                    <input name="size" onclick="location.href = 'product?id=${product.getProductId()}&color=${color}&size=${vSize}'" type="radio" id="${vSize}" class="btn btn-check" value="${vSize}"
                                                           <c:if test="${vSize eq size && sizeQuantity.get(size) != 0}">checked</c:if>
                                                           <c:if test="${!sizesOfColor.contains(vSize) || (sizeQuantity.get(vSize) == 0)}">disabled</c:if>
                                                               />
                                                           <label class="btn btn-white btn-outline-dark" for="${vSize}">${vSize}</label>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>

                                    <c:if test="${sizeQuantity.get(size) != 0 && sizeQuantity.get(size) ne null}">
                                        <div class="flex-w p-b-10"> 
                                            <div class="size-203 flex-c-m respon6">
                                                Stock
                                            </div>
                                            <div class="respon6-next text-success font-weight-bold">
                                                ${sizeQuantity.get(size)}
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                                <div class="flex-w flex-r-m p-b-10">
                                    <div class="size-204 flex-w flex-m respon6-next">
                                        <div class="wrap-num-product flex-w m-r-20 m-tb-10">
                                            <div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
                                                <i class="fs-16 zmdi zmdi-minus"></i>
                                            </div>
                                            <input class="mtext-104 cl3 txt-center num-product" type="number" name="quantity" id="num-product" 
                                                   <c:if test="${sizeQuantity.get(size) == 0 || sizeQuantity.get(size) eq null}">value="0" min="0"</c:if>
                                                   <c:if test="${sizeQuantity.get(size) != 0}">value="1" min="1"</c:if>
                                                   max="${sizeQuantity.get(size)}">
                                            <div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
                                                <i class="fs-16 zmdi zmdi-plus"></i>
                                            </div>
                                        </div>
                                        <c:if test="${sizeQuantity.get(size) == 0 || sizeQuantity.get(size) eq null}">
                                            <div class="flex-w p-b-10"> 
                                                <div class="flex-c-s stext-101 cl0 size-101 text-danger font-weight-bold">
                                                    Out of Stock
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:if test="${sizeQuantity.get(size) != 0 && sizeQuantity.get(size) ne null}">
                                            <input type="submit" value="Add to cart" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04 js-addcart-detail" />
                                        </c:if>
                                    </div>
                                </div>
                            </form>
                        </div>



                        <!--  -->
                        <div class="flex-w flex-m p-l-100 p-t-40 respon7">


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
                <div class="row">
                    <div class="container mt-5 ms-2 mb-5"> 
                        <button class="btn btn-dark" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                            Description
                        </button>
                        <div class="collapse"  id="collapseExample">
                            <div class="card card-body">
                                ${product.getDescription()} 
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row mt-3">
                    <h3>Feedback</h3>
                </div>
                <div class="row">
                    <div>
                        <section class="my-5 bg-light">
                            <h2 class="text-center cl2 p-t-19 p-b-10 respon1" style="font-size: 30px">Products in the same category</h2>
                            <div class="container">
                                <div id="carouselThreeColumn1" class="carousel slide" data-ride="carousel">
                                    <div class="carousel-inner">
                                        <c:set var="chunkSize" value="3"/>
                                        <c:forEach var="product" items="${sameCategory}" varStatus="status">
                                            <c:if test="${status.index % chunkSize == 0}">
                                                <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                                                    <div class="row">
                                                    </c:if>
                                                    <div class="col-4 p-1">
                                                        <div class="card">
                                                            <img src="${product.getImg1()}" style="height: 350px">
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
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="common/homepage/page-footer.jsp"></jsp:include>

        <!--===============================================================================================-->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <script src="${pageContext.request.contextPath}/vendor/jquery/jquery-3.2.1.min.js"></script>
    <!--===============================================================================================-->
    <script src="${pageContext.request.contextPath}/vendor/animsition/js/animsition.min.js"></script>
    <!--===============================================================================================-->
    <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/popper.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.min.js"></script>
    <!--===============================================================================================-->
    <script src="${pageContext.request.contextPath}/vendor/select2/select2.min.js"></script>
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
    <!--    <script>
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
        </script>-->
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
                                                            // Get the input element
                                                            const input = document.querySelector('input[id="num-product"]');
                                                            const maxValue = parseInt(input.max);

                                                            if (input) {
                                                                input.addEventListener('input', function () {
                                                                    let currentValue = parseInt(input.value);

                                                                    if (isNaN(currentValue) || input.value.trim() === "") {
                                                                        input.value = 1;
                                                                    } else {
                                                                        if (currentValue < 1) {
                                                                            input.value = 1;
                                                                        } else if (currentValue > maxValue) {
                                                                            input.value = maxValue;
                                                                        }
                                                                    }
                                                                });

                                                                document.querySelector('.btn-num-product-up').addEventListener('click', function () {
                                                                    let currentValue = parseInt(input.value);
                                                                    if (currentValue < maxValue) {
                                                                        input.value = currentValue + 1;
                                                                    }
                                                                });

                                                                document.querySelector('.btn-num-product-down').addEventListener('click', function () {
                                                                    let currentValue = parseInt(input.value);
                                                                    if (currentValue > 1) {
                                                                        input.value = currentValue - 1;
                                                                    }
                                                                });
                                                            }
                                                        });

    </script>

</body>
</html>

