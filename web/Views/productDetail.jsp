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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/feedback.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">



        <!--===============================================================================================-->
        <style>
            .star {
                font-size: 24px;
                color: gray;
            }
            .modal-lg {
                max-width: 100%;
                margin-top: 60px
            }
            .checked {
                color: gold;
                font-size: 24px; /* Increase the size of the stars */
            }
            .fa-star, .fa-star-half-alt {
                color: gold;
                font-size: 24px; /* Increase the size of the stars */
            }
            .fa-star-o {
                color: gray;
                font-size: 24px; /* Increase the size of the stars */
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

                                <c:if test="${notification ne null}">
                                    <div id="alert" class="alert-box ${type}">
                                        ${notification}
                                    </div>
                                </c:if>

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
                <!-- Feedback -->
                <div class="feedback form-control"> 
                    <div><h3>Feedback</h3></div>
                    <div class="row">
                        <div class="rating-summary col-4">
                            <span class="rating-score" id="averageRating">${averageRating} / 5</span>
                            <div class="starsRatingOfProduct" id="productRating">
                            </div>
                            <span>(${numberOfFeedback} feedback)</span>
                        </div>



                        <div class="user-rating col-8" >

                            <c:if test="${purchased && !previousFeedback}">
                                <form action="${pageContext.request.contextPath}/customer/feedback" method="post">
                                    <div class="stars-input">
                                        <input type="radio" name="rating" value="1" id="star1"><label for="star1">★</label>
                                        <input type="radio" name="rating" value="2" id="star2"><label for="star2">★</label>
                                        <input type="radio" name="rating" value="3" id="star3"><label for="star3">★</label>
                                        <input type="radio" name="rating" value="4" id="star4"><label for="star4">★</label>
                                        <input type="radio" name="rating" value="5" id="star5"><label for="star5">★</label>
                                    </div>
                                    <textarea name="comment" rows="3" class="form-control" placeholder="Please write your feedback here..."></textarea>
                                    <input type="hidden" name="productId" value="${product.productId}">
                                    <div class="row">
                                        <div class="col d-flex justify-content-end">
                                            <button type="submit">Send feedback</button>
                                        </div>
                                    </div>
                                </form>
                            </c:if>

                        </div>





                        <form action="${pageContext.request.contextPath}/customer/feedback" method="get" id="filterForm">
                            <div>
                                <input type="hidden" name="productId" value="${product.productId}">

                                <button class="btn btn-white btn-outline-dark ${starFilter eq 'All' || starFilter == null ? 'active' : ''}" type="submit" name="starFilter" value="All">All</button>

                                <button class="btn btn-white btn-outline-dark ${starFilter eq '5' ? 'active' : ''}" type="submit" name="starFilter" value="5">5 Star</button>

                                <button class="btn btn-white btn-outline-dark ${starFilter eq '4' ? 'active' : ''}" type="submit" name="starFilter" value="4">4 Star</button>

                                <button class="btn btn-white btn-outline-dark ${starFilter eq '3' ? 'active' : ''}" type="submit" name="starFilter" value="3">3 Star</button>

                                <button class="btn btn-white btn-outline-dark ${starFilter eq '2' ? 'active' : ''}" type="submit" name="starFilter" value="2">2 Star</button>

                                <button class="btn btn-white btn-outline-dark ${starFilter eq '1' ? 'active' : ''}" type="submit" name="starFilter" value="1">1 Star</button>
                            </div>
                        </form>




                        <div class="feedback-list">
                            <c:if test="${not empty feedbackList}">
                                <c:forEach var="feedback" items="${feedbackList}">
                                    <div class="feedback-item">
                                        <div class="feedback-header">
                                            <span class="feedback-username">${feedback.username}</span>
                                            <div class="d-flex justify-content-end">
                                                <c:if test="${!feedback.isIsDeleted() && feedback.customerId == Integer.parseInt(cookie.userId.value eq null ? 0 : cookie.userId.value)}">
                                                    <a href="#" class="edit-feedback" data-toggle="modal" data-target="#updateFeedbackModal" 
                                                       data-feedback-id="${feedback.feedbackId}" data-rating="${feedback.rating}" data-comment="${feedback.comment}">
                                                        <i class="fas fa-pencil-alt" style="margin-right: 10px; color: black"></i>
                                                    </a>
                                                </c:if>

                                                <c:if test="${!feedback.isIsDeleted() && feedback.getCustomerId() != Integer.parseInt(cookie.userId.value eq null ? 0 : cookie.userId.value)}">
                                                    <form action="${pageContext.request.contextPath}/customer/feedback" method="post">
                                                        <input type="hidden" name="feedbackId" value="${feedback.feedbackId}">
                                                        <input type="hidden" name="action" value="report">
                                                        <input type="hidden" name="productId" value="${product.productId}">

                                                        <i class="fas fa-flag" onclick="this.closest('form').submit()" style="cursor: pointer"></i>

                                                    </form>
                                                </c:if>


                                            </div>

                                        </div>
                                        <div class="feedback-rating">
                                            <span class="feedback-rating">
                                                <c:forEach begin="1" end="${feedback.rating}">
                                                    <i class="fas fa-star"></i>
                                                </c:forEach>
                                                <c:forEach begin="${feedback.rating + 1}" end="5">
                                                    <i class="far fa-star"></i>
                                                </c:forEach>
                                            </span>
                                        </div>
                                        <p class="feedback-comment">${feedback.isIsDeleted() ? "<em>This feedback has been hidden</em>" : feedback.comment}</p>
                                        <p class="feedback-date"><small>Posted on: ${feedback.createdAt}</small></p>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty feedbackList}">
                                <p class="text-center">No rating yet !</p>
                            </c:if>
                        </div>
                    </div>


                    <!-- Modal for updating feedback -->
                    <div class="modal fade modal-lg" id="updateFeedbackModal" tabindex="-1" role="dialog" aria-labelledby="updateFeedbackModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="updateFeedbackModalLabel">Update Feedback</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <form id="updateFeedbackForm" action="${pageContext.request.contextPath}/customer/feedback" method="post">
                                        <div class="form-group">
                                            <label for="updateRating">Rating:</label>
                                            <div class="stars-input">
                                                <!-- Star rating inputs -->
                                                <input type="radio" name="rating" value="1" id="star1"><label for="star1">★</label>
                                                <input type="radio" name="rating" value="2" id="star2"><label for="star2">★</label>
                                                <input type="radio" name="rating" value="3" id="star3"><label for="star3">★</label>
                                                <input type="radio" name="rating" value="4" id="star4"><label for="star4">★</label>
                                                <input type="radio" name="rating" value="5" id="star5"><label for="star5">★</label> 
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="updateComment">Comment:</label>
                                            <textarea id="updateComment" name="comment" rows="3" class="form-control"></textarea>
                                        </div>
                                        <input type="hidden" id="updateProductId" name="productId" value="${product.productId}">
                                        <input type="hidden" id="updateFeedbackId" name="feedbackId" value="">
                                        <button type="submit" class="btn btn-dark">Update Feedback</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

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

                                                                const alert = document.querySelector('#alert');

                                                                if (alert) {
                                                                    alert.style.display = 'block';
                                                                    alert.style.opacity = '1';

                                                                    setTimeout(function () {
                                                                        alert.style.opacity = '0';

                                                                        setTimeout(function () {
                                                                            alert.classList.add('show');
                                                                        }, 500);
                                                                    }, 3500);
                                                                }

                                                                const stars = document.querySelectorAll('.stars-input label');

                                                                // Set initial star rating to 4 and check the corresponding radio button
                                                                stars.forEach((star, index) => {
                                                                    if (index < 4) {
                                                                        star.style.color = 'gold';
                                                                    } else {
                                                                        star.style.color = 'gray';
                                                                    }
                                                                });

                                                                // Check the radio button corresponding to 4 stars
                                                                const star4Input = document.querySelector('#star4');
                                                                if (star4Input) {
                                                                    star4Input.checked = true;
                                                                }

                                                                // Handle star click events
                                                                stars.forEach((star, index) => {
                                                                    star.addEventListener('click', () => {
                                                                        stars.forEach((s, i) => {
                                                                            if (i <= index) {
                                                                                s.style.color = 'gold';
                                                                            } else {
                                                                                s.style.color = 'gray';
                                                                            }
                                                                        });
                                                                    });
                                                                });

                                                            });

        </script>

        <script>
            // Update average rating and total feedback count based on backend data or initial values
            var averageRatingValue = ${averageRating}; // Replace with actual average rating value
            var totalFeedbackCountValue = ${numberOfFeedback}; // Replace with actual total feedback count value

            document.getElementById('averageRating').innerText = averageRatingValue.toFixed(1) + ' / 5';
            document.querySelector('.rating-score').innerText = averageRatingValue.toFixed(1) + ' / 5';
            document.getElementById('productRating').innerHTML = getStarsHtml(averageRatingValue); // Function to generate star icons based on average rating

            function getStarsHtml(rating) {
                var fullStars = Math.floor(rating);
                var halfStar = (rating % 1 !== 0) ? '<span class="fa fa-star-half-alt checked"></span>' : '';
                var emptyStars = 5 - fullStars - (halfStar ? 1 : 0);

                var starsHtml = '';
                for (var i = 0; i < fullStars; i++) {
                    starsHtml += '<span class="fa fa-star checked"></span>';
                }
                starsHtml += halfStar;
                for (var j = 0; j < emptyStars; j++) {
                    starsHtml += '<span class="far fa-star"></span>';
                }

                return starsHtml;
            }
        </script>

        <script>
            $(document).ready(function () {
                // Set up modal for updating feedback
                $('#updateFeedbackModal').on('show.bs.modal', function (event) {
                    var triggerElement = $(event.relatedTarget); // Element that triggered the modal
                    var feedbackId = triggerElement.data('feedback-id'); // Feedback ID to update
                    var rating = triggerElement.data('rating'); // Current rating
                    var comment = triggerElement.data('comment'); // Current comment

                    // Set modal fields with current feedback data
                    $('#updateFeedbackModal').find('#updateFeedbackId').val(feedbackId);
                    $('#updateFeedbackModal').find('#updateComment').val(comment);

                    // Set rating stars based on current rating
                    setStarRating(rating);

                    // Set the checked attribute for the correct radio button
                    $('#updateFeedbackModal').find('input[name="rating"][value="' + rating + '"]').prop('checked', true);
                });

                // Function to handle form submission
                $('#updateFeedbackForm').submit(function (event) {
                    // Prevent default form submission
                    event.preventDefault();

                    // Perform form submission via AJAX or standard form submit
                    $(this).unbind('submit').submit();
                });

                // Function to set the star rating
                function setStarRating(rating) {
                    const stars = document.querySelectorAll('#updateFeedbackModal .stars-input label');
                    stars.forEach((star, index) => {
                        if (index < rating) {
                            star.style.color = 'gold';
                        } else {
                            star.style.color = 'gray';
                        }
                    });
                }

                // Handle star click events
                $('#updateFeedbackModal .stars-input label').click(function () {
                    // Lấy giá trị rating từ input phía trước label được click
                    const rating = $(this).prev('input').val();
                    setStarRating(rating); // Gọi hàm setStarRating để cập nhật giao diện

                    // Đánh dấu input radio tương ứng là checked
                    $(this).prev('input').prop('checked', true);

                });

            });
        </script>


    </body>
</html>