<%-- 
    Document   : checkout
    Created on : Jun 19, 2024, 8:50:28 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check out</title>
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

        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/checkout.css">

    </head>
    <body>

        <jsp:include page="common/homepage/page-header.jsp"></jsp:include>

            <div class="container mt-4 mb-5">
                <form class="needs-validation" id="checkoutForm" name="frmthanhtoan" method="post"
                      action="checkout" onsubmit="return validateCheckout()" >
                    <div class="py-5 text-center">
                        <i class="fa fa-credit-card fa-4x" aria-hidden="true"></i>
                        <h2>Checkout</h2>
                        <p class="lead">Please fill in your information and verify the Cart details before placing the order.</p>
                    </div>

                    <div class="row">
                        <div class="col-md-4 order-md-2 mb-4">
                            <h4 class="d-flex justify-content-between align-items-center mb-3">
                                <span class="text-muted">Cart</span>
                            </h4>
                            <ul class="list-group mb-3">
                            <c:forEach items="${variants}" var="v">

                                <c:forEach items="${products}" var="p">
                                    <c:if test="${p.getProductId() == v.getProductId()}">
                                        <c:set var="product" value="${p}"/>
                                    </c:if>
                                </c:forEach>

                                <input type="hidden" name="vId" value="${v.getProductVariantId()}">
                                <input type="hidden" name="vQuantity" value="${v.getQuantity()}">

                                <li class="list-group-item d-flex justify-content-between lh-condensed">
                                    <div>
                                        <div class="d-flex align-items-center">
                                            <img style="width: 50px; height: 50px; margin-right: 10px " src="${product.getImg1()}" alt="product IMG" />
                                            <h6 class="my-0">${product.getName()}<br /><small class="text-muted">${v.getColor()}, ${v.getSize()} x ${v.getQuantity()}</small></h6>
                                        </div>

                                    </div>
                                    <span id="itemPrice" class="text-muted">$ ${product.getPrice() * v.getQuantity()}</span>
                                </li>

                            </c:forEach>
                            <li class="list-group-item d-flex justify-content-between">
                                <span>Sub total</span>
                                <p id="subTotal"></p>
                            </li>
                            <li class="list-group-item d-flex justify-content-between">
                                <span>Discount</span>
                                <p>$ ${discount}</p>
                                <input hidden value="${discount}" name="discount"/>
                            </li>
                            <li class="list-group-item d-flex justify-content-between">
                                <span>Total amount</span>
                                <strong>$ ${totalAmount}</strong>
                                <input hidden value="${totalAmount}" id="usd-total" name="totalAmount"/>
                                <input hidden value="0" id="vnd-total" name="vnd" />
                            </li>
                        </ul>
                        <form></form>

                        <form action="cart" method="get">
                            <button onclick="this.closest('form').submit()" class="input-group btn btn-secondary d-flex justify-content-center">
                                Back to Shopping Cart
                            </button>
                        </form>

                    </div>
                    <div class="col-md-8 order-md-1">
                        <h4 class="mb-3">Shipping information</h4>

                        <div class="row">
                            <div class="col-md-6">
                                <label for="fullname">Fullname <span class="text-danger">*</span></label>
                                <input type="text" class="form-control mb-3" name="fullname" id="fullname"
                                       value="${account.getFullname()}" ${account ne null ? "readonly" : ""} required>
                            </div>
                            <div class="col-md-6">
                                <label for="email">Email <span class="text-danger">*</span></label>
                                <input type="text" class="form-control mb-3" name="email" id="email"
                                       value="${account.getEmail()}" ${account ne null ? "readonly" : ""} required>
                            </div>
                            <c:if test="${account eq null}">
                                <div class="col-md-6">
                                    <label for="city">City <span class="text-danger">*</span></label>
                                    <select class="form-select mb-3" name="city" id="city" aria-label=".form-select-sm" required>
                                        <option value="" selected>Choose city</option>           
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="district">District <span class="text-danger">*</span></label>
                                    <select class="form-select mb-3" name="district" id="district" aria-label=".form-select-sm" required>
                                        <option value="" selected>Choose district</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="ward">Ward <span class="text-danger">*</span></label>
                                    <select class="form-select mb-3" name="ward" id="ward" aria-label=".form-select-sm" required>
                                        <option value="" selected>Choose ward</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="stAddress">Street Address <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="stAddress" id="stAddress"
                                           value="" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="phone">Phone number <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="phone" id="phone"
                                           value="" required>
                                </div>
                            </c:if>
                            <c:if test="${account ne null}">
                                <input value="${cookie.userId.value}" hidden name="accId" />
                                <c:if test="${account.getAddresses().size() == 0}">
                                    <div class="col-md-6">
                                        <label for="city">City <span class="text-danger">*</span></label>
                                        <select class="form-select mb-3" name="city" id="city" aria-label=".form-select-sm" required>
                                            <option value="" selected>Choose city</option>           
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="district">District <span class="text-danger">*</span></label>
                                        <select class="form-select mb-3" name="district" id="district" aria-label=".form-select-sm" required>
                                            <option value="" selected>Choose district</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="ward">Ward <span class="text-danger">*</span></label>
                                        <select class="form-select mb-3" name="ward" id="ward" aria-label=".form-select-sm" required>
                                            <option value="" selected>Choose ward</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="stAddress">Street Address <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="stAddress" id="stAddress"
                                               value="" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="phone">Phone number <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="phone" id="phone"
                                               value="" required>
                                    </div>
                                </c:if>
                                <c:if test="${account.getAddresses().size() > 0}">
                                    <div class="col-md-12 mb-3" id="cusAddress">
                                        <label for="address" class="d-flex justify-content-between">Delivery Address
                                            <c:if test="${account.getAddresses().size() < 10}">
                                                <a href="#" onclick="handleAddNewAddress()">New Address</a>
                                            </c:if>
                                        </label>
                                        <select name="address" class="form-select" id="addressDropdown">
                                            <c:forEach items="${account.getAddresses()}" var="address">
                                                <option value="${address.getAddress()} - ${address.getPhone()}" 
                                                        ${address.isIsDefault() ? "selected" : ""}> ${address.getAddress()} 
                                                    - ${address.getPhone()} ${address.isIsDefault() 
                                                        ? " - Default" : ""}</option>
                                                </c:forEach>
                                        </select> 

                                    </div>
                                    <div class="col-md-6 d-none" name="cusNewAddress">
                                        <label for="city">City <span class="text-danger">*</span></label>
                                        <select class="form-select mb-3" name="city" id="city" aria-label=".form-select-sm">
                                            <option value="" selected>Choose city</option>           
                                        </select>
                                    </div>
                                    <div class="col-md-6 d-none" name="cusNewAddress">
                                        <label for="district">District <span class="text-danger">*</span></label>
                                        <select class="form-select mb-3" name="district" id="district" aria-label=".form-select-sm">
                                            <option value="" selected>Choose district</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 d-none" name="cusNewAddress">
                                        <label for="ward">Ward <span class="text-danger">*</span></label>
                                        <select class="form-select mb-3" name="ward" id="ward" aria-label=".form-select-sm">
                                            <option value="" selected>Choose ward</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 d-none" name="cusNewAddress">
                                        <label for="stAddress">Street Address <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="stAddress" id="stAddress"
                                               value="">
                                    </div>
                                    <div class="col-md-6 d-none" name="cusNewAddress">
                                        <label for="phone">Phone number <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="phone" id="phone"
                                               value="">
                                    </div>
                                    <div class="col-md-12 mt-3">
                                        <a href="#" class="d-none" id="selectAddressBtn" onclick="handleSelectAddress()">My Addresses</a>
                                    </div>
                                </c:if>
                            </c:if>
                        </div>

                        <h4 class="mt-3 mb-3">Payment method</h4>

                        <div class="d-block my-3">
                            <div class="form-check">
                                <input id="pmethod" name="paymentMethod" type="radio" class="form-check-input" 
                                       value="cod">
                                <label class="form-check-label" for="paymentMethod">Cash on Delivery</label>
                            </div>
                            <div class="form-check">
                                <input id="pmethod" name="paymentMethod" type="radio" class="form-check-input" 
                                       value="vnpay">
                                <label class="form-check-label" for="paymentMethod">VN Pay</label>
                            </div>
                        </div>
                        <hr class="mb-4">
                        <button class="btn btn-primary btn-lg btn-block" type="submit" name="btnDatHang">Place order</button>
                    </div>
                </div>
            </form>
        </div>

        <div id="alert" class="alert-box alert-box-danger">
            Please select a payment method to place order
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


                                            function validateCheckout() {
                                                const radio = document.querySelector('input[id="pmethod"]:checked');
                                                let alertBox = document.getElementById('alert');
                                                if (!radio) {
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
                                            function backToCart() {
                                                let form = document.createElement('form');
                                                form.action = "cart";
                                                form.method = "get";
                                                document.appendChild(form);
                                                form.submit();
                                            }

                                            function handleAddNewAddress() {
                                                let addNewAddressInputs = document.querySelectorAll('div[name="cusNewAddress"]');
                                                addNewAddressInputs.forEach((input) => {
                                                    input.classList.remove("d-none");
                                                    input.setAttribute('required', '');
                                                })
                                                let selectAddressBtn = document.querySelector('#selectAddressBtn');
                                                selectAddressBtn.classList.remove("d-none");
                                                let selectAddress = document.querySelector('#cusAddress');
                                                selectAddress.classList.add("d-none");
                                                let selectTag = selectAddress.querySelector('select[id="addressDropdown"]');
                                                selectTag.removeAttribute("name");
                                            }

                                            function handleSelectAddress() {
                                                let addNewAddressInputs = document.querySelectorAll('div[name="cusNewAddress"]');
                                                addNewAddressInputs.forEach((input) => {
                                                    input.classList.add("d-none");
                                                    input.removeAttribute('required');
                                                })
                                                let selectAddressBtn = document.querySelector('#selectAddressBtn');
                                                selectAddressBtn.classList.add("d-none");
                                                let selectAddress = document.querySelector('#cusAddress');
                                                selectAddress.classList.remove("d-none");
                                                let selectTag = selectAddress.querySelector('select[id="addressDropdown"]');
                                                selectTag.setAttribute("name", "address");
                                            }

                                            document.addEventListener('DOMContentLoaded', function () {

                                                //Display subtotal

                                                let subTotalTxt = document.querySelector('#subTotal');

                                                const itemPricesTxt = document.querySelectorAll('#itemPrice');

                                                let subTotal = 0;

                                                if (itemPricesTxt.length > 0) {

                                                    itemPricesTxt.forEach(function (priceTxt) {

                                                        subTotal += parseFloat(priceTxt.textContent.trim().replace('$', '').trim());

                                                    });

                                                }

                                                subTotalTxt.innerText = "$ " + subTotal.toFixed(1);

                                                //add event for tag 'a'
                                                document.querySelectorAll('a').forEach(link => {
                                                    link.addEventListener('click', (e) => {
                                                        if (link.getAttribute('href') === '#') {
                                                            e.preventDefault();
                                                        }
                                                    });
                                                });

                                                //Convert use to vnd
                                                const amount = document.querySelector("#usd-total").value;
                                                console.log(amount);

                                                const fromCurrency = 'USD';
                                                const toCurrency = 'VND';
                                                const apiKey = 'dca5383d5d3aa9ba3637fdc9';
                                                const apiUrl = "https://v6.exchangerate-api.com/v6/" + apiKey + "/latest/" + fromCurrency;

                                                fetch(apiUrl)
                                                        .then(response => {
                                                            if (!response.ok) {
                                                                throw new Error('Network response was not ok');
                                                            }
                                                            return response.json();
                                                        })
                                                        .then(data => {
                                                            if (data.result === 'success') {
                                                                const exchangeRate = data.conversion_rates[toCurrency];
                                                                const convertedAmount = amount * exchangeRate;
                                                                document.querySelector('#vnd-total').value = convertedAmount;
                                                                console.log(convertedAmount);
                                                            } else {
                                                                console.log('Error fetching exchange rate');
                                                            }
                                                        })
                                                        .catch(error => {
                                                            console.error('Error:', error);
                                                        });


                                            });

                                            $(document).ready(function () {
                                                $('#addressDropdown').select2({
                                                    templateResult: formatOption
                                                });

                                                function formatOption(data) {
                                                    if (!data.id) {
                                                        return data.text;
                                                    }

                                                    var parts = data.text.split('-');
                                                    var $result = $('<span>' + parts[0] + '<br>' + parts[1] +
                                                            (parts[2] === undefined ? '</small></span>' : '<br><small class="text-warning">' + parts[2] + '</small></span>'));
                                                    return $result;
                                                }

                                            });

        </script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script>
                                            var citis = document.getElementById("city");
                                            var districts = document.getElementById("district");
                                            var wards = document.getElementById("ward");
                                            var Parameter = {
                                                url: "https://raw.githubusercontent.com/kenzouno1/DiaGioiHanhChinhVN/master/data.json",
                                                method: "GET",
                                                responseType: "application/json",
                                            };
                                            var promise = axios(Parameter);
                                            promise.then(function (result) {
                                                renderCity(result.data);
                                            });

                                            function renderCity(data) {
                                                for (const x of data) {
                                                    citis.options[citis.options.length] = new Option(x.Name.replace("Thành phố", "").replace("Tỉnh", ""), x.Name.replace("Thành phố", "").replace("Tỉnh", ""));
                                                }
                                                citis.onchange = function () {
                                                    district.length = 1;
                                                    ward.length = 1;
                                                    if (this.value != "") {
                                                        const result = data.filter(n => n.Name.replace("Thành phố", "").replace("Tỉnh", "") === this.value);

                                                        for (const k of result[0].Districts) {
                                                            district.options[district.options.length] = new Option(k.Name, k.Name);
                                                        }
                                                    }
                                                };
                                                district.onchange = function () {
                                                    ward.length = 1;
                                                    const dataCity = data.filter((n) => n.Name.replace("Thành phố", "").replace("Tỉnh", "") === citis.value);
                                                    if (this.value != "") {
                                                        const dataWards = dataCity[0].Districts.filter(n => n.Name === this.value)[0].Wards;

                                                        for (const w of dataWards) {
                                                            wards.options[wards.options.length] = new Option(w.Name, w.Name);
                                                        }
                                                    }
                                                };
                                            }
        </script>

    </body>
</html>
