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
        <c:if test="${cart.isEmpty()}">
            <div class="text-center m-t-100">
                <img src="${pageContext.request.contextPath}/images/cart/emptycart.png" alt="empty cart image"/>
                <h1>No item in your cart.</h1>
                <buttton class="btn text-white mt-3 font-weight-bold pointer" style=" background-color: orange; font-size: 20px" onclick="location.href = 'shop'">Go Shopping now</buttton>
            </div>
        </c:if>
        <div class="bg0 p-t-75 p-b-85">

            <div id="alert" class="alert-box alert-box-danger">
                Please select at least one item before proceeding to checkout.
            </div>

            <c:if test="${!cart.isEmpty()}">
                <div class="container">
                    <form id="mainCartForm" action="cart?action=checkout" method="post" onsubmit="return validateCheckout()">
                        <div class="row">
                            <div class="col-lg-10 col-xl-7 m-lr-auto m-b-50">
                                <div class="m-l-25 m-r--38 m-lr-0-xl">
                                    <h5 class="m-b-20 font-weight-bold">Available Products</h5>
                                    <div class="wrap-table-shopping-cart">

                                        <table class="table-shopping-cart">
                                            <tr class="table_head">
                                                <th class=" d-flex justify-content-center"><input type="checkbox" id="selectAll" /></th>
                                                <th class=""></th>
                                                <th class="column-2">Name</th>
                                                <th class="column-3 text-center">Price</th>
                                                <th class="column-3 text-center">Quantity</th>
                                                <th class="column-5">Total</th>
                                                <th class="p-r-15">Action</th>
                                            </tr>
                                            <c:forEach items="${cart}" var="item">

                                                <c:forEach items="${allVariant}" var="variant">
                                                    <c:if test="${variant.getProductVariantId() == item.getProductVariantId()}">
                                                        <c:set var="v" value="${variant}" />
                                                    </c:if>
                                                </c:forEach>

                                                <c:forEach items="${allProduct}" var="product">
                                                    <c:forEach items="${product.getVariantList()}" var="pVari">
                                                        <c:if test="${pVari.getProductId() == v.getProductId()}">
                                                            <c:set var="p" value="${product}" />
                                                        </c:if>
                                                    </c:forEach>
                                                </c:forEach>

                                                <form></form>

                                                <c:if test="${v.getQuantity() > 0 && !v.isIsDeleted()}">
                                                    <tr class="table_row">
                                                        <td style="padding: 0 10px;" class="">
                                                            <input id="itemSelected" type="checkbox" class="form-check" name="cartItem" value="${item.getCartItemId()}-${item.getProductVariantId()}-${item.getQuantity()}"/>
                                                            <input name="itemId" value="${item.getProductVariantId()}" hidden=""/>
                                                            <input name="cItemId" value="${item.getCartItemId()}" hidden=""/>
                                                            <input name="cItemQuantity" value="${item.getQuantity()}" hidden=""/>
                                                        </td>
                                                        <td class="">
                                                            <div class="" style="padding: 0">
                                                                <img src="${p.getImg1()}" style="margin: 0 10px 0 0; height: 60px; width: 60px" alt="IMG">
                                                            </div>
                                                        </td>
                                                        <td class="column-2">
                                                            <p style="font-weight: 700; font-size: 15px;">${p.getName()}</p>
                                                            <p style="font-size: 10px">${v.getColor()}, ${v.getSize()}</p>
                                                        </td>
                                                        <td id="price" class="column-3 text-center">$ ${p.getPrice()}</td>
                                                        <td class="column-4">
                                                            <div class="wrap-num-product flex-w m-l-auto m-r-0">
                                                                <div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
                                                                    <i class="fs-16 zmdi zmdi-minus"></i>
                                                                </div>
                                                                <input class="mtext-104 cl3 txt-center num-product" type="number" name="quantity" id="num-product" value="${item.getQuantity()}" max="${v.getQuantity()}">
                                                                <div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
                                                                    <i class="fs-16 zmdi zmdi-plus"></i>
                                                                </div>
                                                            </div>
                                                            <p class="${v.getQuantity() < 10 ? "text-danger" : "text-success"} text-center" style="font-size: 12px;">${v.getQuantity()} items left</p>
                                                        </td>
                                                        <td id="itemTotal" class="column-5">$ ${item.getQuantity() * p.getPrice()}</td>
                                                    <form action="cart?action=delete" method="post">
                                                        <input name="itemIdDelete" value="${item.getProductVariantId()}" hidden=""/>
                                                        <input name="cItemIdDelete" value="${item.getCartItemId()}" hidden=""/>
                                                        <td class="p-r-15 ">
                                                            <button onclick="this.closest('form').submit()" class="btn btn-danger text-white" />
                                                            <i class="bi bi-trash"></i>
                                                            </button>
                                                        </td>
                                                    </form>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </table>
                                    </div>

                                    <c:if test="${not empty cookie.userId}">
                                        <div class="flex-w flex-sb-m bor15 p-t-18 p-b-15 p-lr-40 p-lr-15-sm">
                                            <div class="flex-w flex-m m-r-20 m-tb-5">
                                                <input id="coupon" class="stext-104 cl2 plh4 size-117 bor13 p-lr-20 m-r-10 m-tb-5" type="text" name="coupon" placeholder="Coupon Code" >

                                                <div onclick="applyCoupon(this)" class="flex-c-m stext-101 cl2 size-118 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer m-tb-5">
                                                    Apply coupon
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <br />
                                    <br />
                                    <!-- Inactive items -->
                                    <h5 class="m-b-20 font-weight-bold" id="inactiveTitle" style="display: none">Unavailable Products</h5>
                                    <div class="wrap-table-shopping-cart">
                                        <table class="table-shopping-cart" id="inactiveTable" style="display: none">
                                            <tr class="table_head">
                                                <th class=" d-flex justify-content-center">Status</th>
                                                <th ></th>
                                                <th class="column-2">Name</th>
                                                <th class="column-1">Price</th>
                                                <th class="column-1" style="padding-left: 60px;">Quantity</th>
                                                <th class="column-5" style="text-align: start;">Total</th>
                                                <th class="p-r-45">Action</th>
                                            </tr>
                                            <c:forEach items="${cart}" var="item">

                                                <c:forEach items="${allVariant}" var="variant">
                                                    <c:if test="${variant.getProductVariantId() == item.getProductVariantId()}">
                                                        <c:set var="v" value="${variant}" />
                                                    </c:if>
                                                </c:forEach>

                                                <c:forEach items="${allProduct}" var="product">
                                                    <c:forEach items="${product.getVariantList()}" var="pVari">
                                                        <c:if test="${pVari.getProductId() == v.getProductId()}">
                                                            <c:set var="p" value="${product}" />
                                                        </c:if>
                                                    </c:forEach>
                                                </c:forEach>

                                                <c:if test="${v.getQuantity() == 0 || v.isIsDeleted()}">
                                                    <tr class="table_row">

                                                        <td class="column-2 text-center">
                                                            <p class="text-white bg-secondary" style="border: solid 1px gray; margin-left: 10px; border-radius: 100px;">${v.getQuantity() == 0 ? "Sold out" : "Inactive"}</p>
                                                        </td>
                                                        <td class="">
                                                            <div class="">
                                                                <img src="${p.getImg1()}" style="margin: 0 5px; height: 60px; width: 60px" alt="IMG">
                                                            </div>
                                                        </td>
                                                        <td class="column-2">
                                                            <p style="font-weight: 700">${p.getName()}</p>
                                                            <p style="font-size: 10px">${v.getColor()}, ${v.getSize()}</p>
                                                        </td>
                                                        <td class="column-1">$ ${p.getPrice()}</td>
                                                        <td class="column-2">
                                                            <input class=" txt-center " type="number" value="1" readonly />
                                                        </td>
                                                        <td class="column-5" style="text-align: start;">$ ${p.getPrice()}</td>
                                                    <form action="cart?action=delete" method="post">
                                                        <input name="itemIdDelete" value="${item.getProductVariantId()}" hidden=""/>
                                                        <input name="cItemIdDelete" value="${item.getCartItemId()}" hidden=""/>
                                                        <td class="p-r-15">
                                                            <button onclick="this.closest('form').submit()" class="btn btn-danger text-white" />
                                                            <i class="bi bi-trash"></i>
                                                            </button>
                                                        </td>
                                                    </form>
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

                                        <div class="size-209 text-center">
                                            <span class="mtext-110 cl2" id="subTotalTxt">
                                            </span>
                                        </div>
                                    </div>

                                    <div class="flex-w flex-t bor12 p-t-15 p-b-30">
                                        <div class="size-208 w-full-ssm">
                                            <span class="stext-110 cl2">
                                                Discount:
                                            </span>
                                        </div>

                                        <div class="size-209 text-center">
                                            <span class="mtext-110 cl2" id="discountTxt"></span>
                                        </div>
                                    </div>
                                    <input name="discount" id="discount" hidden="" type="number" value="${discount ne null ? discount : 0}"/>

                                    <div class="flex-w flex-t p-t-27 p-b-33">
                                        <div class="size-208">
                                            <span class="mtext-101 cl2">
                                                Total:
                                            </span>
                                        </div>

                                        <div class="size-209 text-center p-t-1">
                                            <span class="mtext-110 cl2" id="totalTxt"></span>
                                        </div>
                                    </div>
                                    <input name="totalAmount" id="totalAmount" hidden="" type="number" value="0"/>

                                    <input type="submit" value="Proceed to Checkout" class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer m-tb-10">

                                    <div onclick="location.href = 'shop'" class="flex-c-m stext-101 cl2 size-119 bg8 bor13 hov-btn3 p-lr-15 trans-04 pointer m-tb-10">
                                        Continue Shopping
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
            </c:if>

        </div>


        <!-- Back to top -->
        <div class="btn-back-to-top" id="myBtn">
            <span class="symbol-btn-back-to-top">
                <i class="zmdi zmdi-chevron-up"></i>
            </span>
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
                                        });
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
                                            })

                                            $(window).on('resize', function () {
                                                ps.update();
                                            });
                                        });
        </script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/js/main.js"></script>

        <script>
                                        document.addEventListener('DOMContentLoaded', function () {

                                            document.querySelector('#subTotalTxt').innerText = "$ 0.0";
                                            document.querySelector('#discountTxt').innerText = "$ 0.0";
                                            document.querySelector('#totalTxt').innerText = "$ 0.0";

                                            const inputs = document.querySelectorAll('input[id="num-product"]');

                                            if (inputs.length > 0) {
                                                inputs.forEach(function (input) {

                                                    let tr = input.closest('tr');
                                                    let priceTxt = tr.querySelector('td[id="price"]');
                                                    let priceInput = parseFloat(priceTxt.textContent.trim().replace('$', '').trim());
                                                    const maxValueInput = parseInt(input.max);
                                                    let currentValueInput = parseInt(input.value);
                                                    input.value = currentValueInput > maxValueInput ? maxValueInput : currentValueInput;
                                                    let updateTotal = input.value * priceInput;
                                                    let totalInput = tr.querySelector('td[id="itemTotal"]');
                                                    totalInput.innerText = "$ " + updateTotal.toFixed(1);

                                                    input.addEventListener('input', function (e) {
                                                        const maxValue = parseInt(input.max);
                                                        let currentValue = parseInt(e.target.value);

                                                        if (isNaN(currentValue) || e.target.value.trim() === "") {
                                                            e.target.value = 1;
                                                        } else {
                                                            if (currentValue < 1) {
                                                                e.target.value = 1;
                                                            } else if (currentValue > maxValue) {
                                                                e.target.value = maxValue;
                                                            }
                                                        }
                                                    });

                                                    // Add 'focusout' event listener
                                                    input.addEventListener('focusout', function (e) {
                                                        changeQuantity(e);
                                                    });

                                                    // Add 'keypress' event listener
                                                    input.addEventListener('keypress', function (e) {
                                                        if (e.key === "Enter") {
                                                            e.preventDefault();
                                                            changeQuantity(e);
                                                        }
                                                    });
                                                });

                                                // Add click event listener for 'btn-num-product-up'
                                                document.querySelectorAll('.btn-num-product-up').forEach(function (button) {
                                                    button.addEventListener('click', function (e) {
                                                        const inputContainer = button.closest('.wrap-num-product');
                                                        if (inputContainer) {
                                                            const input = inputContainer.querySelector('input[id="num-product"]');
                                                            if (input) {
                                                                const maxValue = parseInt(input.max);
                                                                let currentValue = parseInt(input.value);

                                                                if (currentValue < maxValue) {
                                                                    input.value = currentValue + 1;
                                                                }
                                                                changeQuantity(e);
                                                            }
                                                        }
                                                    });
                                                });

                                                // Add click event listener for 'btn-num-product-down'
                                                document.querySelectorAll('.btn-num-product-down').forEach(function (button) {
                                                    button.addEventListener('click', function (e) {
                                                        const inputContainer = button.closest('.wrap-num-product');
                                                        if (inputContainer) {
                                                            const input = inputContainer.querySelector('input[id="num-product"]');
                                                            if (input) {
                                                                const maxValue = parseInt(input.max);
                                                                let currentValue = parseInt(input.value);

                                                                if (currentValue > 1) {
                                                                    input.value = currentValue - 1;
                                                                }
                                                                changeQuantity(e);
                                                            }
                                                        }
                                                    });
                                                });
                                            }

                                            const checkboxs = document.querySelectorAll('input[id="itemSelected"]');

                                            let subTotal = 0;
                                            const discountTxt = document.querySelector('#discountTxt').textContent.trim();
                                            const discount = parseFloat(document.querySelector('#discount').value);
                                            let total = 0;

                                            checkboxs.forEach(function (checkbox) {
                                                const itemTotalText = checkbox.closest('tr').querySelector('td[id="itemTotal"]').textContent.trim();
                                                const itemTotal = parseFloat(itemTotalText.replace('$', '').trim());
                                                if (checkbox.checked) {
                                                    subTotal += itemTotal;
                                                }

                                                checkbox.addEventListener('change', function () {
                                                    if (checkbox.checked) {
                                                        subTotal += itemTotal;
                                                    } else {
                                                        subTotal -= itemTotal;
                                                    }
                                                    let subTotalDisplay = document.querySelector('#subTotalTxt');
                                                    subTotalDisplay.innerText = "$ " + subTotal.toFixed(1);
                                                    let totalText = document.querySelector('#totalTxt');
                                                    if (subTotal === 0) {
                                                        totalText.innerText = "$ 0.0";
                                                    } else {
                                                        document.querySelector('#discountTxt').innerText = (subTotal * discount / 100);
                                                        total = subTotal - (subTotal * discount / 100);
                                                        totalText.innerText = "$ " + total.toFixed(1);
                                                        document.querySelector('#totalAmount').value = total;
                                                    }
                                                });
                                            });

                                            const checkBoxAll = document.querySelector('#selectAll');

                                            checkBoxAll.addEventListener('change', function () {
                                                let totalText = document.querySelector('#totalTxt');
                                                if (checkBoxAll.checked) {
                                                    subTotal = 0;
                                                    total = 0;
                                                    checkboxs.forEach(function (checkbox) {
                                                        const itemTotalText = checkbox.closest('tr').querySelector('td[id="itemTotal"]').textContent.trim();
                                                        const itemTotal = parseFloat(itemTotalText.replace('$', '').trim());
                                                        if (!checkbox.checked) {
                                                            checkbox.checked = true;
                                                            subTotal += itemTotal;
                                                        }
                                                    });

                                                } else {
                                                    checkboxs.forEach(function (checkbox) {
                                                        const itemTotalText = checkbox.closest('tr').querySelector('td[id="itemTotal"]').textContent.trim();
                                                        const itemTotal = parseFloat(itemTotalText.replace('$', '').trim());
                                                        if (checkbox.checked) {
                                                            checkbox.checked = false;
                                                            subTotal -= itemTotal;
                                                        }

                                                    });

                                                }

                                                totalText.innerText = "$ " + total.toFixed(1);
                                            });

                                            let subTotalDisplay = document.querySelector('#subTotalTxt');
                                            subTotalDisplay.innerText = "$ " + subTotal.toFixed(1);
                                            let totalText = document.querySelector('#totalTxt');
                                            if (subTotal === 0) {
                                                totalText.innerText = "$ 0.0";
                                            } else {
                                                total = subTotal - discount;
                                                totalText.innerText = "$ " + total.toFixed(1);
                                                document.querySelector('#totalAmount').value = total;
                                            }

                                            let tableTitle = document.querySelector('#inactiveTitle');
                                            let table = document.querySelector('#inactiveTable');
                                            if (table) {
                                                let rows = table.querySelectorAll('td');
                                                if (rows.length > 0) {
                                                    tableTitle.style.display = 'block';
                                                    table.style.display = 'block';
                                                }
                                            }

                                        });

                                        function changeQuantity(e) {

                                            let tr = e.target.closest('tr');

                                            let itemId = tr.querySelector('input[name="itemId"]');
                                            let cItemId = tr.querySelector('input[name="cItemId"]');
                                            let quantity = tr.querySelector('input[name="quantity"]');
                                            let submitQuantity = document.querySelector('input[name="cItemQuantity"]');


                                            let form = document.createElement('form');
                                            submitQuantity.value = quantity.value;
                                            form.appendChild(itemId);
                                            form.appendChild(cItemId);
                                            form.appendChild(submitQuantity);
                                            form.action = "cart?action=updateQuantity";
                                            form.method = "post";
                                            document.body.appendChild(form);
                                            form.submit();

                                        }

                                        function applyCoupon(e) {

                                            const input = document.querySelector('#coupon');

                                            if (input !== null || input.value !== '') {

                                                let form = document.createElement('form');
                                                let inputCoupon = document.createElement('input');
                                                inputCoupon.name = "coupon";
                                                inputCoupon.value = input.value;
                                                form.appendChild(inputCoupon);
                                                form.action = "cart?action=applyCoupon";
                                                form.method = "post";
                                                document.body.appendChild(form);
                                                form.submit();

                                            }



                                        }

                                        function validateCheckout() {
                                            const checkboxes = document.querySelectorAll('input[id="itemSelected"]');
                                            let checked = false;

                                            checkboxes.forEach(function (checkbox) {
                                                if (checkbox.checked) {
                                                    checked = true;
                                                }
                                            });

                                            let alertBox = document.getElementById('alert');

                                            if (!checked) {
                                                alertBox.style.display = 'block';
                                                alertBox.style.opacity = '1';
                                                setTimeout(function () {
                                                    alertBox.style.opacity = '0';
                                                    setTimeout(function () {
                                                        alertBox.classList.add('show');
                                                    }, 500);
                                                }, 3500);
                                                return false;
                                            } else {
                                                alertBox.classList.remove('show');
                                            }

                                            return true;
                                        }



        </script>

    </body>
</html>
