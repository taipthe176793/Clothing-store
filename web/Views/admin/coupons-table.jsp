<%-- 
    Document   : table
    Created on : May 23, 2024, 12:54:09 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/images/apple-icon.png">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Manage Coupons</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" name="viewport" />

        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />

        <link href="${pageContext.request.contextPath}/css/demo.css" rel="stylesheet" />

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/colReorder-bootstrap4.css">

        <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

        <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

        <link href="${pageContext.request.contextPath}/css/sb-admin.css" rel="stylesheet" type="text/css">

        <link href="${pageContext.request.contextPath}/css/sb-admin.min.css" rel="stylesheet" type="text/css">

    </head>

    <body>

        <div class="wrapper">
            <div class="sidebar" data-image="${pageContext.request.contextPath}/images/sidebar-5.jpg">



            </div>
            <jsp:include page="../common/admin/side-bar.jsp"></jsp:include>
                <div class="main-panel">

                <jsp:include page="../common/admin/header.jsp"></jsp:include>

                    <div class="content">
                        <div class="container-fluid">

                            <!-- Breadcrumbs-->
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="./dashboard">Dashboard</a>
                                </li>
                                <li class="breadcrumb-item active">Coupons</li>
                            </ol>

                            <div class="card mb-3">
                                <div class="card-header d-flex justify-content-between">
                                    <div>
                                        <i class="fas fa-table"></i>
                                        Coupons List
                                    </div>
                                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addModal">
                                        Add New Coupon
                                    </button>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>Coupon Id</th>
                                                    <th>Code</th>
                                                    <th>Description</th>
                                                    <th>Discount</th>
                                                    <th>Expire</th>
                                                    <th>Start</th>
                                                    <th>Quantity</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${couponList}" var="c">
                                                <tr>
                                                    <td name="id">${c.getCouponId()}</td>
                                                    <td name="code">${c.getCode()}</td>
                                                    <td name="description">${c.getDescription()}</td>
                                                    <td name="discount">${c.getDiscount()}</td>
                                                    <td name="expire">${c.getExpiresAt()}</td>
                                                    <td name="start">${c.getStartAt()}</td>
                                                    <td name="quantity">${c.getQuantity()}</td>
                                                    <td>
                                                        <button type="button" class="btn btn-primary"
                                                                data-toggle="modal" data-target="#editCouponModal"
                                                                onclick="editCouponModal(this)">Edit</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../common/admin/footer.jsp"></jsp:include>
                </div>
            </div>

            <!-- Add Modal -->
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModal" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Add Coupon</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="addCouponForm" action="coupon?action=add" method="post">
                                <!--Code-->
                                <div class="form-group">
                                    <label for="code">Code:</label>
                                    <input type="text" class="form-control" id="codeInput" name="code">
                                    <div id="nameError" class="error"></div>
                                </div>
                                <!-- Description -->
                                <div class="form-group">
                                    <label for="description">Description:</label>
                                    <textarea class="form-control" id="descriptionInput" name="description"></textarea>
                                </div>
                                <!-- Discount -->
                                <div class="form-group">
                                    <label for="discount">Discount:</label>
                                    <input type="number" class="form-control" id="discountInput" name="discount">
                                    <div id="discountError" class="error"></div>
                                </div>
                                <!-- Expiry Date -->
                                <div class="form-group">
                                    <label for="expiresAt">Expires At:</label>
                                    <input type="date" class="form-control" id="expiresAtInput" name="expiresAt">
                                    <div id="expireDateError" class="error"></div>
                                </div>
                                <!-- Start Date -->
                                <div class="form-group">
                                    <label for="startAt">Start At:</label>
                                    <input type="date" class="form-control" id="startAtInput" name="startAt">
                                    <div id="startDateError" class="error"></div>
                                    <div id="dateError" class="error"></div>
                                </div>
                                <!-- Quantity -->
                                <div class="form-group">
                                    <label for="quantity">Quantity:</label>
                                    <input type="number" class="form-control" id="quantityInput" name="quantity">
                                    <div id="quantityError" class="error"></div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" form="addCouponForm" onclick="validateForm(event)">Add</button>
                        </div>
                    </div>
                </div>
            </div>

            <!--<!-- Update Modal -->
            <div class="modal fade" id="editCouponModal" tabindex="-1" role="dialog" aria-labelledby="editCouponModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editCouponModalLabel">Edit Coupon</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="editCouponForm" action="coupon?action=update" method="post">
                                <div class="form-group" style="display: none;">
                                    <input type="text" class="form-control" id="couponIdInput" name="couponId">
                                </div>
                                <!-- Code -->
                                <div class="form-group">
                                    <label for="codeEditInput">Code:</label>
                                    <input type="text" class="form-control" id="codeEditInput" name="code">
                                    <div id="codeEditError" class="error text-danger"></div>
                                </div>
                                <!-- Description -->
                                <div class="form-group">
                                    <label for="descriptionEditInput">Description:</label>
                                    <textarea class="form-control" id="descriptionEditInput" name="description"></textarea>
                                </div>
                                <!-- Discount -->
                                <div class="form-group">
                                    <label for="discountEditInput">Discount:</label>
                                    <input type="number" class="form-control" id="discountEditInput" name="discount">
                                    <div id="discountEditError" class="error text-danger"></div>
                                </div>
                                <!-- Expiry Date -->
                                <div class="form-group">
                                    <label for="expiresAtEditInput">Expires At:</label>
                                    <input type="date" class="form-control" id="expiresAtEditInput" name="expiresAt">
                                    <div id="expireDateEditError" class="error text-danger"></div>
                                </div>
                                <!-- Start Date -->
                                <div class="form-group">
                                    <label for="startAtEditInput">Start At:</label>
                                    <input type="date" class="form-control" id="startAtEditInput" name="startAt">
                                    <div id="startDateEditError" class="error text-danger"></div>
                                    <div id="dateEditError" class="error text-danger"></div>
                                </div>
                                <!-- Quantity -->
                                <div class="form-group">
                                    <label for="quantityEditInput">Quantity:</label>
                                    <input type="number" class="form-control" id="quantityEditInput" name="quantity">
                                    <div id="quantityEditError" class="error text-danger"></div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" form="editCouponForm" onclick="validateEditForm(event)">Update</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Notification Modal -->
            <div class="modal fade" id="notiModal" role="dialog" aria-labelledby="errorModal">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="notiModal">Notification</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>${notification}</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </body>

    <script src="${pageContext.request.contextPath}/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/core/popper.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/core/bootstrap.min.js" type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-switch.js"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/chartist.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/jquery.sharrre.js"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-notify.js"></script>

    <script src="${pageContext.request.contextPath}/js/light-bootstrap-dashboard.js?v=2.0.1" type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/js/demo.js"></script>



    <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/chart.js/Chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.js"></script>
    <script src="${pageContext.request.contextPath}/js/sb-admin.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>
    <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>
    <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
    <script src="${pageContext.request.contextPath}/js/demo/chart-area-demo.js"></script>
    <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>
    <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>

    <script>
    function validateForm(event) {
        event.preventDefault();
        let code = $('#codeInput').val();
        let startAt = $('#startAtInput').val();
        let expiresAt = $('#expiresAtInput').val();
        let discount = $('#discountInput').val();
        let quantity = $('#quantityInput').val();

        let isValid = true;

        $('.error').html('');

        if (code === '') {
            $('#nameError').html('Code cannot be empty!');
            isValid = false;
        }

        if (discount.trim() === '') {
            $('#discountError').html('Discount cannot be empty!');
            isValid = false;
        } else if (!$.isNumeric(discount) || parseFloat(discount) < 0) {
            $('#discountError').html('Invalid Discount');
            isValid = false;
        }

        if (quantity.trim() === '') {
            $('#quantityError').html('Quantity cannot be empty!');
            isValid = false;
        } else if (!$.isNumeric(quantity) || parseFloat(quantity) < 0) {
            $('#quantityError').html('Invalid Quantity');
            isValid = false;
        }

        if (startAt === '') {
            $('#startDateError').html('Start date cannot be empty!');
            isValid = false;
        }

        if (expiresAt === '') {
            $('#expireDateError').html('Expire date cannot be empty!');
            isValid = false;
        }

        if (startAt !== '' && expiresAt !== '') {
            if (new Date(startAt) >= new Date(expiresAt)) {
                $('#dateError').html('Start date must be before the expire date!');
                isValid = false;
            }
        }

        let today = new Date().setHours(0, 0, 0, 0);
        if (startAt !== '' && new Date(startAt).setHours(0, 0, 0, 0) < today) {
            $('#startDateError').html('Start date must be today or later!');
            isValid = false;
        }

        if (isValid) {
            $('#addCouponForm').submit();
        }
    }

    function editCouponModal(button) {
        var row = $(button).closest('tr');
        var couponId = row.find('td[name="id"]').text().trim();
        var code = row.find('td[name="code"]').text().trim();
        var description = row.find('td[name="description"]').text().trim();
        var discount = row.find('td[name="discount"]').text().trim();
        var expiresAt = row.find('td[name="expire"]').text().trim();
        var startAt = row.find('td[name="start"]').text().trim();
        var quantity = row.find('td[name="quantity"]').text().trim();

        $('#editCouponForm #couponIdInput').val(couponId);
        $('#editCouponForm #codeEditInput').val(code);
        $('#editCouponForm #descriptionEditInput').val(description);
        $('#editCouponForm #discountEditInput').val(discount);
        $('#editCouponForm #expiresAtEditInput').val(expiresAt);
        $('#editCouponForm #startAtEditInput').val(startAt);
        $('#editCouponForm #quantityEditInput').val(quantity);
    }

    function editCouponModal(button) {
    var row = $(button).closest('tr');
    var couponId = row.find('td[name="id"]').text().trim();
    var code = row.find('td[name="code"]').text().trim();
    var description = row.find('td[name="description"]').text().trim();
    var discount = row.find('td[name="discount"]').text().trim();
    var expiresAt = row.find('td[name="expire"]').text().trim();
    var startAt = row.find('td[name="start"]').text().trim();
    var quantity = row.find('td[name="quantity"]').text().trim();

    $('#editCouponForm #couponIdInput').val(couponId);
    $('#editCouponForm #codeEditInput').val(code);
    $('#editCouponForm #descriptionEditInput').val(description);
    $('#editCouponForm #discountEditInput').val(discount);
    $('#editCouponForm #expiresAtEditInput').val(expiresAt);
    $('#editCouponForm #startAtEditInput').val(startAt);
    $('#editCouponForm #quantityEditInput').val(quantity);
}

function validateEditForm(event) {
    event.preventDefault();
    let code = $('#codeEditInput').val();
    let startAt = $('#startAtEditInput').val();
    let expiresAt = $('#expiresAtEditInput').val();
    let discount = $('#discountEditInput').val();
    let quantity = $('#quantityEditInput').val();

    let isValid = true;

    $('.error').html('');

    if (code === '') {
        $('#codeEditError').html('Code cannot be empty!');
        isValid = false;
    }

    if (discount.trim() === '') {
        $('#discountEditError').html('Discount cannot be empty!');
        isValid = false;
    } else if (!$.isNumeric(discount) || parseFloat(discount) < 0) {
        $('#discountEditError').html('Invalid Discount');
        isValid = false;
    }

    if (quantity.trim() === '') {
        $('#quantityEditError').html('Quantity cannot be empty!');
        isValid = false;
    } else if (!$.isNumeric(quantity) || parseFloat(quantity) < 0) {
        $('#quantityEditError').html('Invalid Quantity');
        isValid = false;
    }

    if (startAt === '') {
        $('#startDateEditError').html('Start date cannot be empty!');
        isValid = false;
    }

    if (expiresAt === '') {
        $('#expireDateEditError').html('Expire date cannot be empty!');
        isValid = false;
    }

    if (startAt !== '' && expiresAt !== '') {
        if (new Date(startAt) >= new Date(expiresAt)) {
            $('#dateEditError').html('Start date must be before the expire date!');
            isValid = false;
        }
    }

    let today = new Date().setHours(0, 0, 0, 0);
    if (startAt !== '' && new Date(startAt).setHours(0, 0, 0, 0) < today) {
        $('#startDateEditError').html('Start date must be today or later!');
        isValid = false;
    }

    if (isValid) {
        $('#editCouponForm').submit();
    }
}

    //Display Error
    $(document).ready(function () {
    <c:if test="${notification != null}">
        $('#notiModal').modal('show');
    </c:if>
    });
    </script>


</html>