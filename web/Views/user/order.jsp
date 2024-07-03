<%-- 
    Document   : order
    Created on : 15 thg 6, 2024, 20:58:51
    Author     : truonghn
--%>

<%@ page import="Models.CustomerOrder" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile Template</title>
        <link rel="stylesheet" href="profile.css">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/icons/favicon.png" />
        <!-- CSS Links -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/iconic/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/linearicons-v1.0.0/icon-font.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animate/animate.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/css-hamburgers/hamburgers.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animsition/css/animsition.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/select2/select2.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/slick/slick.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/MagnificPopup/magnific-popup.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/util.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">

    </head>

    <body>
        <jsp:include page="../common/homepage/page-header.jsp"></jsp:include>

            <div class="container mt-4">
                <div class="row mb-4">
                    <div class="col-10">
                        <h2>My Addresses</h2>
                    </div>
                    <div class="col-2">
                        <div class="card">
                            <button type="button" class="btn btn-dark" data-toggle="modal" data-target="#addAddressModal">
                                Add New Address
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Modal "Add New Address" -->
                <div class="modal fade" id="addAddressModal" tabindex="-1" role="dialog" aria-labelledby="addAddressModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="addAddressModalLabel">Add New Address</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form id="addAddressForm" action="${pageContext.request.contextPath}/customer/address" method="post" onsubmit="return validateForm()">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="addPhone">Phone</label>
                                    <input type="text" id="addPhone" name="phone" class="form-control" required>
                                    <div class="invalid-feedback">Phone number must be 10 digits and start with 0 without spaces.</div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="city">City <span class="text-danger">*</span></label>
                                        <select class="form-control mb-3" name="city" id="city" aria-label=".form-select-sm" required>
                                            <option value="" selected>Choose city</option>           
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="district">District <span class="text-danger">*</span></label>
                                        <select class="form-control mb-3" name="district" id="district" aria-label=".form-select-sm" required>
                                            <option value="" selected>Choose district</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="ward">Ward <span class="text-danger">*</span></label>
                                        <select class="form-control mb-3" name="ward" id="ward" aria-label=".form-select-sm" required>
                                            <option value="" selected>Choose ward</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="stAddress">Street Address <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="stAddress" id="stAddress"
                                               value="" required>
                                        <div class="invalid-feedback">Street Address must not be empty.</div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-dark">Add Address</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-body">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Phone</th>
                                <th>Address</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>

                            <c:forEach var="address" items="${addresses}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${address.phone}</td>
                                    <td>${address.address}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/customer/address" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" value="${address.addressId}">
                                            <button type="submit" class="btn btn-info btn-sm btn-update">Update</button>
                                        </form>

                                        <c:if test="${loop.index != 0}">
                                            <form action="${pageContext.request.contextPath}/customer/address" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="id" value="${address.addressId}">
                                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                            </form>
                                        </c:if>

                                        <c:if test="${loop.index != 0}">
                                            <form action="${pageContext.request.contextPath}/customer/address" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="set-default">
                                                <input type="hidden" name="id" value="${address.addressId}">
                                                <button type="submit" class="btn btn-dark btn-sm">Set as Default</button>
                                            </form>
                                        </c:if>
                                        <c:if test="${loop.index == 0}">
                                            <span class="badge bg-warning p-2">Default</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <a href="${pageContext.request.contextPath}/customer/profile?action=view" class="btn btn-dark " style="width: 10%; margin: 0 auto">Back to Profile</a>
            </div>

            <div id="updateAddressModal" class="modal fade" role="dialog">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Update Address</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form id="updateAddressForm" action="address?action=update" method="post">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="updatePhone">Phone</label>
                                    <input type="text" id="updatePhone" name="phone" class="form-control" required>
                                    <div class="invalid-feedback">Phone number must be 10 digits and start with 0 without spaces.</div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="city">City <span class="text-danger">*</span></label>
                                        <select class="form-control mb-3" name="city" id="uCity" aria-label=".form-select-sm" required>
                                            <option value="" selected>Choose city</option>           
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="district">District <span class="text-danger">*</span></label>
                                        <select class="form-control mb-3" name="district" id="uDistrict" aria-label=".form-select-sm" required>
                                            <option value="" selected>Choose district</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <label for="ward">Ward <span class="text-danger">*</span></label>
                                        <select class="form-control mb-3" name="ward" id="uWard" aria-label=".form-select-sm" required>
                                            <option value="" selected>Choose ward</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="stAddress">Street Address <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="stAddress" id="uStAddress"
                                               value="" required>
                                        <div class="invalid-feedback">Street Address must not be empty.</div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="hidden" id="updateAddressId" name="id">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-dark">Update</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="../common/homepage/page-footer.jsp"></jsp:include>
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
        <script src="${pageContext.request.contextPath}/js/main.js"></script>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
        <script>
                                var citis = document.getElementById("city");
                                var districts = document.getElementById("district");
                                var wards = document.getElementById("ward");
                                var uCitis = document.getElementById("uCity");
                                var uDistricts = document.getElementById("uDistrict");
                                var uWards = document.getElementById("uWard");
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
                                        uCitis.options[uCitis.options.length] = new Option(x.Name.replace("Thành phố", "").replace("Tỉnh", ""), x.Name.replace("Thành phố", "").replace("Tỉnh", ""));
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
                                    uCitis.onchange = function () {
                                        uDistrict.length = 1;
                                        uWard.length = 1;
                                        if (this.value != "") {
                                            const result = data.filter(n => n.Name.replace("Thành phố", "").replace("Tỉnh", "") === this.value);

                                            for (const k of result[0].Districts) {
                                                uDistrict.options[uDistrict.options.length] = new Option(k.Name, k.Name);
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
                                    uDistrict.onchange = function () {
                                        uWard.length = 1;
                                        const dataCity = data.filter((n) => n.Name.replace("Thành phố", "").replace("Tỉnh", "") === uCitis.value);
                                        if (this.value != "") {
                                            const dataWards = dataCity[0].Districts.filter(n => n.Name === this.value)[0].Wards;

                                            for (const w of dataWards) {
                                                uWard.options[uWard.options.length] = new Option(w.Name, w.Name);
                                            }
                                        }
                                    };
                                }
        </script>

        <script>
            $(document).ready(function () {
                $('.btn-update').click(function (e) {
                    e.preventDefault();
                    let addressId = $(this).closest('form').find('input[name="id"]').val();
                    let phone = $(this).closest('tr').find('td:eq(1)').text();
                    let address = $(this).closest('tr').find('td:eq(2)').text().split(',');
                    let city = address[0].trim();
                    let district = address[1].trim();
                    let ward = address[2].trim();
                    let strAddress = address[3].trim();

                    $('#updateAddressId').val(addressId);
                    $('#updatePhone').val(phone);
                    $('#uCity').find('option').each(function () {
                        if ($(this).text().replace("Thành phố", "").replace("Tỉnh", "").trim() === city) {
                            $(this).prop('selected', true);
                            $(this).trigger('change');
                        }
                    });
                    $('#uCity').trigger('change');
                    $('#uDistrict').find('option').each(function () {
                        if ($(this).text() === district) {
                            $(this).prop('selected', true);
                            $(this).trigger('change');
                        }
                    });
                    $('#uWard').find('option').each(function () {
                        if ($(this).text() === ward) {
                            $(this).prop('selected', true);
                        }
                    });
                    $('#uStAddress').val(strAddress);

                    $('#updateAddressModal').modal('show');
                });
            });

            $('#addAddressForm').submit(function (e) {
                e.preventDefault();
                if (validateForm('addAddressForm')) {
                    $.ajax({
                        type: 'POST',
                        url: $(this).attr('action'),
                        data: $(this).serialize(),
                        success: function (data) {
                            $('#addAddressModal').modal('hide');
                            location.reload(); 
                        },
                        error: function () {
                            alert('Failed to add new address.');
                        }
                    });
                }
            });

// Xử lý khi nhấn nút "Update Address"
            $('#updateAddressForm').submit(function (e) {
                e.preventDefault();
                if (validateForm('updateAddressForm')) {
                    $.ajax({
                        type: 'POST',
                        url: $(this).attr('action'),
                        data: $(this).serialize(),
                        success: function (data) {
                            $('#updateAddressModal').modal('hide');
                            location.reload(); 
                        },
                        error: function () {
                            alert('Failed to update address.');
                        }
                    });
                }
            });

            function validateForm(formId) {
                let phonePattern = /^(?!.*\s)0\d{9}$/;

                let form = document.forms[formId];
                let address = form["stAddress"];
                let phone = form["phone"];

                let isValid = true;

                if (!phonePattern.test(phone.value) || phone.value.trim() === "") {
                    phone.classList.add("is-invalid");
                    isValid = false;
                } else {
                    phone.classList.remove("is-invalid");
                }

                if (address.value.trim() === "") {
                    address.classList.add("is-invalid");
                    isValid = false;
                } else {
                    address.classList.remove("is-invalid");
                }

                return isValid;
            }
        </script>

    </body>
</html>
