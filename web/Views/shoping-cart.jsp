<%-- 
    Document   : shopping-cart
    Created on : May 19, 2024, 3:17:48 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Shopping Cart</title>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
        <!--===============================================================================================-->
    </head>

    <body>

        <jsp:include page="common/homepage/page-header.jsp"></jsp:include>

            <!-- breadcrumb -->
            <div class="container">
                <div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
                    <a href="home" class="stext-109 cl8 hov-cl1 trans-04">
                        Home
                        <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
                    </a>

                    <span class="stext-109 cl4">
                        Shopping Cart
                    </span>
                </div>
            </div>


            <!-- Shoping Cart -->
            <form action="cart?action=checkout" method="post" class="bg0 p-t-75 p-b-85">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-10 col-xl-7 m-lr-auto m-b-50">
                            <div class="m-l-25 m-r--38 m-lr-0-xl">
                                <div class="wrap-table-shopping-cart">
                                    <table class="table-shopping-cart">
                                        <tr class="table_head">
                                            <th class="column-5">Product</th>
                                            <th class="column-5"></th>
                                            <th class="column-2">Name</th>
                                            <th class="column-3">Price</th>
                                            <th class="column-1">Quantity</th>
                                            <th class="column-5">Total</th>
                                            <th class="p-r-15">Action</th>
                                        </tr>
                                    <c:forEach items="${cart}" var="item">

                                        <c:forEach items="${sessionScope.variantsSession}" var="variant">
                                            <c:if test="${variant.getProductVariantId() == item.getProductVariantId()}">
                                                <c:set var="v" value="${variant}" />
                                            </c:if>
                                        </c:forEach>

                                        <c:forEach items="${sessionScope.productsSession}" var="product">
                                            <c:forEach items="${product.getVariantList()}" var="pVari">
                                                <c:if test="${pVari.getProductId() == v.getProductId()}">
                                                    <c:set var="p" value="${product}" />
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>




                                        <c:if test="${v.getQuantity() > 0 && !v.isIsDeleted()}">
                                            <tr class="table_row">

                                                <td class="column-5">
                                                    <input type="checkbox" class="form-check" style="margin: 0 0 0 50px" name="cartItemId" value="${item.getCartItemId()}"/>
                                                </td>
                                                <td class="">
                                                    <div class="" style="padding: 0">
                                                        <img src="${p.getImg1()}" style="margin: 0; height: 60px; width: 60px" alt="IMG">
                                                    </div>
                                                </td>
                                                <td class="column-2">
                                                    <p style="font-weight: 700">${p.getName()}</p>
                                                    <p style="font-size: 10px">${v.getColor()}, ${v.getSize()}</p>
                                                </td>
                                                <td class="column-3">$ ${p.getPrice()}</td>
                                                <td class="column-4">
                                                    <div class="wrap-num-product flex-w m-l-auto m-r-0">
                                                        <div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
                                                            <i class="fs-16 zmdi zmdi-minus"></i>
                                                        </div>

                                                        <input class="mtext-104 cl3 txt-center num-product" type="number" id="num-product" value="${item.getQuantity()}" max="${v.getQuantity()}">

                                                        <div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
                                                            <i class="fs-16 zmdi zmdi-plus"></i>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="column-5">$ ${item.getQuantity() * p.getPrice()}</td>
                                                <td class="p-r-15 text-center">
                                                    <form action="cart?action=delete" method="post">
                                                        <input name="item" value="${item.getCartItemId()}" hidden=""/>
                                                        <button class="btn btn-danger text-white">
                                                            <i onclick="this.closest('form').submit()" class="bi bi-trash"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </table>
                            </div>



                            <div class="flex-w flex-sb-m bor15 p-t-18 p-b-15 p-lr-40 p-lr-15-sm">
                                <div class="flex-w flex-m m-r-20 m-tb-5">
                                    <input class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5" type="text" name="coupon" placeholder="Coupon Code">

                                    <div class="flex-c-m stext-101 cl2 size-118 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer m-tb-5">
                                        Apply coupon
                                    </div>
                                </div>


                            </div>
                            <br />
                            <br />
                            <h5>Inactive List</h5>
                            <div class="wrap-table-shopping-cart">
                                <table class="table-shopping-cart">
                                    <tr class="table_head">
                                        <th class="column-5">Product</th>
                                        <th class="column-5"></th>
                                        <th class="column-2">Name</th>
                                        <th class="column-3">Price</th>
                                        <th class="column-1">Quantity</th>
                                        <th class="p-r-15">Action</th>
                                    </tr>
                                    <c:forEach items="${cart}" var="item">

                                        <c:forEach items="${sessionScope.variantsSession}" var="variant">
                                            <c:if test="${variant.getProductVariantId() == item.getProductVariantId()}">
                                                <c:set var="v" value="${variant}" />
                                            </c:if>
                                        </c:forEach>

                                        <c:forEach items="${sessionScope.productsSession}" var="product">
                                            <c:forEach items="${product.getVariantList()}" var="pVari">
                                                <c:if test="${pVari.getProductId() == v.getProductId()}">
                                                    <c:set var="p" value="${product}" />
                                                </c:if>
                                            </c:forEach>
                                        </c:forEach>

                                        <c:if test="${v.getQuantity() == 0 || v.isIsDeleted()}">
                                            <tr class="table_row">

                                                <td class="column-5">
                                                    <p>Inactive</p>
                                                </td>
                                                <td class="">
                                                    <div class="">
                                                        <img src="${p.getImg1()}" style="margin: 0; height: 60px; width: 60px" alt="IMG">
                                                    </div>
                                                </td>
                                                <td class="column-2">
                                                    <p style="font-weight: 700">${p.getName()}</p>
                                                    <p style="font-size: 10px">${v.getColor()}, ${v.getSize()}</p>
                                                </td>
                                                <td class="column-3">$ ${p.getPrice()}</td>
                                                <td class="column-4">
                                                    <input class=" txt-center " type="number" value="0" readonly />
                                                </td>
                                                <td class="p-r-15 text-center">
                                                    <form action="cart?action=delete" method="post">
                                                        <input name="item" value="${item.getCartItemId()}" hidden=""/>
                                                        <button class="btn btn-danger text-white" />
                                                        <i onclick="this.closest('form').submit()" class="bi bi-trash"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:if>

                                    </c:forEach>
                                </table>
                            </div>
                        </div>

                    </div>

                    <div class="col-sm-10 col-lg-7 col-xl-5 m-lr-auto m-b-50">
                        <div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">
                            <h4 class="mtext-109 cl2 p-b-30">
                                Cart Totals
                            </h4>

                            <div class="flex-w flex-t bor12 p-b-13">
                                <div class="size-208">
                                    <span class="stext-110 cl2">
                                        Subtotal:
                                    </span>
                                </div>

                                <div class="size-209">
                                    <span class="mtext-110 cl2">
                                        $79.65
                                    </span>
                                </div>
                            </div>

                            <div class="flex-w flex-t bor12 p-t-15 p-b-30">
                                <div class="size-208 w-full-ssm">
                                    <span class="stext-110 cl2">
                                        Shipping:
                                    </span>
                                </div>

                                <div class="size-209">
                                    <span class="mtext-110 cl2">
                                        $79.65
                                    </span>
                                </div>
                            </div>

                            <div class="flex-w flex-t bor12 p-t-15 p-b-30">
                                <div class="size-208 w-full-ssm">
                                    <span class="stext-110 cl2">
                                        Discount:
                                    </span>
                                </div>

                                <div class="size-209">
                                    <span class="mtext-110 cl2">
                                        $79.65
                                    </span>
                                </div>
                            </div>

                            <div class="flex-w flex-t p-t-27 p-b-33">
                                <div class="size-208">
                                    <span class="mtext-101 cl2">
                                        Total:
                                    </span>
                                </div>

                                <div class="size-209 p-t-1">
                                    <span class="mtext-110 cl2">
                                        $79.65
                                    </span>
                                </div>
                            </div>

                            <button class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer m-tb-10">
                                Proceed to Checkout
                            </button>
                            <div onclick="location.href = 'shop'" class="flex-c-m stext-101 cl2 size-119 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer m-tb-10">
                                Continue Shopping
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </form>




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
