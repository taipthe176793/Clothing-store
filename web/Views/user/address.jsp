<%-- 
    Document   : address
    Created on : 15 thg 6, 2024, 20:58:51
    Author     : caoqu
--%>

<%@ page import="Models.CustomerAddress" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile Template</title>
        <link rel="stylesheet" href="profile.css">
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
                            <form id="addAddressForm" action="${pageContext.request.contextPath}/customer/address" method="post">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="addPhone">Phone</label>
                                    <input type="text" id="addPhone" name="phone" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="addAddress">Address</label>
                                    <textarea id="addAddress" name="address" class="form-control" rows="3" required></textarea>
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
                                <th>Address ID</th>
                                <th>Phone</th>
                                <th>Address</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="address" items="${addresses}" varStatus="loop">
                                <tr>
                                    <td>${address.addressId}</td>
                                    <td>${address.phone}</td>
                                    <td>${address.address}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/customer/address" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="update">
                                            <input type="hidden" name="id" value="${address.addressId}">
                                            <button type="submit" class="btn btn-info btn-sm btn-update">Update</button>
                                        </form>

                                        <form action="${pageContext.request.contextPath}/customer/address" method="post" style="display: inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${address.addressId}">
                                            <button type="submit" class="btn btn-danger btn-sm" ${loop.index == 0 ? 'disabled' : ''}>Delete</button>
                                        </form>

                                        <c:if test="${loop.index != 0}">
                                            <form action="${pageContext.request.contextPath}/customer/address" method="post" style="display: inline;">
                                                <input type="hidden" name="action" value="set-default">
                                                <input type="hidden" name="id" value="${address.addressId}">
                                                <button type="submit" class="btn btn-dark btn-sm">Set as Default</button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <a href="${pageContext.request.contextPath}/customer/profile?action=view" class="btn btn-link" style="color: black; font-weight: bold;">Cancel</a>

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
                        <form id="updateAddressForm" action="${pageContext.request.contextPath}/customer/address" method="post">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="updatePhone">Phone</label>
                                    <input type="text" id="updatePhone" name="phone" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label for="updateAddress">Address</label>
                                    <textarea id="updateAddress" name="address" class="form-control" rows="3" required></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <input type="hidden" id="updateAddressId" name="id">
                                <input type="hidden" name="action" value="update">
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
        <script>
            $(document).ready(function () {
                // Xử lý khi nhấn nút Update trong bảng
                $('.btn-update').click(function (e) {
                    e.preventDefault();
                    var addressId = $(this).closest('tr').find('td:first').text();
                    var phone = $(this).closest('tr').find('td:eq(1)').text();
                    var address = $(this).closest('tr').find('td:eq(2)').text();

                    // Đổ dữ liệu vào modal
                    $('#updateAddressId').val(addressId);
                    $('#updatePhone').val(phone);
                    $('#updateAddress').val(address);

                    // Hiển thị modal
                    $('#updateAddressModal').modal('show');
                });
            });
        </script>
        <script>
            $(document).ready(function () {
                // Xử lý khi nhấn nút "Add Address"
                $('#addAddressForm').submit(function (e) {
                    e.preventDefault();
                    $.ajax({
                        type: 'POST',
                        url: $(this).attr('action'),
                        data: $(this).serialize(),
                        success: function (data) {
                            // Đóng modal khi thêm mới thành công
                            $('#addAddressModal').modal('hide');
                            // Cập nhật lại nội dung trang hoặc reload trang
                            location.reload(); // Có thể sử dụng location.reload() để reload trang
                        },
                        error: function () {
                            alert('Failed to add new address.');
                        }
                    });
                });
            });
        </script>

    </body>
</html>

