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
        <title>Manage Accounts</title>
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
                                <li class="breadcrumb-item active">Accounts</li>
                            </ol>

                            <div class="card mb-3">
                                <div class="card-header d-flex justify-content-between">
                                    <div>
                                        <i class="fas fa-table"></i>
                                        Accounts List
                                    </div>
                                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addModal">
                                        Add New Staff
                                    </button>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <form action="#">
                                            <input hidden value="${roleFilter}" id="selectedRole" />
                                        <label for="role">Filter:</label>
                                        <select onchange="filterByRole(this)" name="roleFilter" id="roleFilter" >
                                            <option value="all">All</option>
                                            <option value="customer">Customer</option>
                                            <option value="staff">Staff</option>
                                        </select>
                                    </form>
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Username</th>
                                                <th>Full name</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Role</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                            <c:forEach items="${accountList}" var="account"> 
                                                <tr>
                                                    <td name="id">${account.getAccountId()}</td>
                                                    <td name="username">${account.getUsername()}</td>
                                                    <td name="fullname">${account.getFullname()}</td>
                                                    <td name="email">${account.getEmail()}</td>
                                                    <td name="phone">${account.getPhone()}</td>
                                                    <c:forEach items="${roleList}" var="role"> 
                                                        <c:if test="${account.getRoleId() == role.getRoleId()}"> 
                                                            <td name="role">${role.getName()}</td> 
                                                        </c:if>
                                                    </c:forEach>
                                                    <td name="edit" class="d-flex justify-content-center">
                                                        <button type="button" class="btn btn-primary"
                                                                data-toggle="modal" data-target="#editUserModal"
                                                                onclick="editUserModal(this)">Edit</button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer small text-muted">Updated</div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../common/admin/footer.jsp"></jsp:include>
            </div>


            <!-- Add Modal -->
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModal" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Add New Staff</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="addStaffForm" action="accounts?action=add" method="post">
                                <!--Username-->
                                <div class="form-group">
                                    <label for="username">Username:</label>
                                    <input type="text" class="form-control" id="usernameInput" name="username" required>
                                </div>
                                <!--Password-->
                                <div class="form-group">
                                    <label for="password">Password:</label>
                                    <input type="password" class="form-control" id="passwordInput" name="password" required>
                                </div>
                                <!--Confirm Password-->
                                <div class="form-group">
                                    <label for="confirm-pass">Confirm Password:</label>
                                    <input type="password" class="form-control" id="confirm-passInput" name="confirm-pass" required>
                                </div>
                                <!--Full Name-->
                                <div class="form-group">
                                    <label for="fullname">Full Name:</label>
                                    <input type="text" class="form-control" id="fullnameInput" name="fullname" required>
                                </div>
                                <!--Email-->
                                <div class="form-group">
                                    <label for="email">Email:</label>
                                    <input type="text" class="form-control" id="emailInput" name="email" required>
                                </div>
                                <!--Phone-->
                                <div class="form-group">
                                    <label for="phone">Phone:</label>
                                    <input type="text" class="form-control" id="phoneInput" name="phone" required>
                                </div>
                                <!-- Role -->
                                <input type="hidden" name="role" value="2">
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" form="addStaffForm" onclick="validateForm()">Add</button>
                        </div>
                    </div>
                </div>
            </div>         

            <!-- Update Modal -->
            <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Edit User</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="editModalForm" action="accounts?action=update" method="POST" >
                                <div class="form-group" style="display: none">
                                    <input type="text" class="form-control" id="idEditInput" name="id">
                                </div>

                                <div class="form-group">
                                    <label for="username">Username:</label>
                                    <input type="text" class="form-control" id="usernameEditInput" name="username" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="fullname">Full name:</label>
                                    <input type="text" class="form-control" id="fullnameEditInput" name="fullname" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="phone">Phone:</label>
                                    <input type="text" class="form-control" id="phoneEditInput" name="phone" readonly>
                                </div>

                                <div class="form-group">
                                    <label for="email">Email:</label>
                                    <input type="text" class="form-control" id="emailEditInput" name="email" readonly> 
                                </div>

                                <div class="form-group">
                                    <label for="role">Role:</label>
                                    <br/>
                                    <input type="radio" name="role" value="3"> Customer
                                    <input type="radio" name="role" value="2" style="margin-left: 40px"> Staff
                                </div>

                                <div class="form-group" hidden="">
                                    <input type="text" name="pId" value=""/>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" form="editModalForm"
                                    onclick="validateForm2()">Update</button>
                        </div>
                    </div>
                </div>
            </div>

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
                                        function validateForm() {
                                            // Define validation patterns
                                            let usernamePattern = /^(?!.*\s).{6,}$/;
                                            let phonePattern = /^0\d{9}$/;
                                            let passwordPattern = /^(?!.*\s).{8,}$/;
                                            let emailPattern = /^[^@]+@[^@]+\.[^@]+$/;

                                            let form = document.forms["addStaffForm"];
                                            let username = form["username"];
                                            let phone = form["phone"];
                                            let password = form["password"];
                                            let confirmPassword = form["confirm-pass"];
                                            let fullname = form["fullname"];
                                            let email = form["email"];
                                            let role = form["role"];

                                            let isValid = true;

                                            // Reset custom validity messages
                                            fullname.setCustomValidity("");
                                            username.setCustomValidity("");
                                            phone.setCustomValidity("");
                                            password.setCustomValidity("");
                                            email.setCustomValidity("");
                                            confirmPassword.setCustomValidity("");

                                            // Validate Fullname
                                            if (fullname.value.trim() === "") {
                                                fullname.setCustomValidity("Fullname cannot be empty.");
                                                isValid = false;
                                            }

                                            // Validate Username
                                            if (!usernamePattern.test(username.value)) {
                                                username.setCustomValidity("Username must be at least 6 characters and contain no spaces.");
                                                isValid = false;
                                            }

                                            // Validate Phone
                                            if (!phonePattern.test(phone.value)) {
                                                phone.setCustomValidity("Phone must be 10 digits, start with 0 and contain no spaces.");
                                                isValid = false;
                                            }

                                            // Validate Password
                                            if (!passwordPattern.test(password.value)) {
                                                password.setCustomValidity("Password must be at least 8 characters and contain no spaces.");
                                                isValid = false;
                                            }

                                            // Validate Confirm Password
                                            if (password.value !== confirmPassword.value) {
                                                confirmPassword.setCustomValidity("Confirm Password is different from Password.");
                                                isValid = false;
                                            }

                                            // Validate Email
                                            if (!emailPattern.test(email.value)) {
                                                email.setCustomValidity("Please enter a valid email address.");
                                                isValid = false;
                                            }

                                            if (!role.value) {
                                                role.value = '2';
                                            }

                                            if (!isValid) {
                                                form.reportValidity();
                                                return false;
                                            }

                                            return true;
                                        }
                                        $(document).ready(function () {
                                            $('#addStaffForm').submit(function (event) {
                                                if (!validateForm()) {
                                                    event.preventDefault();
                                                } else {
                                                    $('#notiModal').modal('show');
                                                }
                                            });
                                        });





                                        function validateForm2() {
                                            let quantity = $('#quantityEditInput').val();

                                            $('.error').html('');

                                            if (quantity === '') {
                                                $('#quantityEditError').html('Quantity cannot be empty');
                                            } else if (!$.isNumeric(quantity) || parseFloat(quantity) < 0) {
                                                $('#quantityEditError').html('Quantity must be greater than 0');
                                            }

                                            let error = '';
                                            $('.error').each(function () {
                                                error += $(this).html();
                                            });
                                            if (error === '') {
                                                $('#editModalForm').submit();
                                            } else {
                                                event.preventDefault();
                                            }
                                        }

                                        function editUserModal(button) {
                                            let id = $(button).closest('tr').find('td[name="id"]').text().trim();
                                            let username = $(button).closest('tr').find('td[name="username"]').text().trim();
                                            let fullname = $(button).closest('tr').find('td[name="fullname"]').text().trim();
                                            let phone = $(button).closest('tr').find('td[name="phone"]').text().trim();
                                            let email = $(button).closest('tr').find('td[name="email"]').text().trim();
                                            let role = $(button).closest('tr').find('td[name="role"]').text().trim();

                                            $('#idEditInput').val(id);
                                            $('#usernameEditInput').val(username);
                                            $('#fullnameEditInput').val(fullname);
                                            $('#phoneEditInput').val(phone);
                                            $('#emailEditInput').val(email);

                                            if (role === 'customer') {
                                                $('input[name="role"][value="3"]').prop('checked', true);
                                            } else if (role === 'staff') {
                                                $('input[name="role"][value="2"]').prop('checked', true);
                                            } else {
                                                $('input[name="role"]').prop('checked', false);
                                            }
                                        }

                                        function filterByRole(selectedOption) {
                                            let form = selectedOption.closest('form');
                                            const selected = selectedOption.value;
                                            console.log(selected);
                                            form.action = "accounts?role=" + selected;
                                            form.method = "get";
                                            form.submit();
                                        }
                                        ;

                                        document.addEventListener('DOMContentLoaded', function () {
                                            const roleFilterValue = document.getElementById('selectedRole').value;
                                            const selectFilter = document.getElementById('roleFilter');

                                            Array.from(selectFilter.options).forEach(option => {
                                                if (option.value === roleFilterValue) {
                                                    option.selected = true;
                                                }
                                            });
                                        });
                                        $(document).ready(function () {
        <c:if test="${notification != null}">
                                            $('#notiModal').modal('show');
        </c:if>
                                        });
    </script>
</html>
