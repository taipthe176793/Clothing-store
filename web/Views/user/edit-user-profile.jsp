<%-- 
    Document   : edit-user-profile
    Created on : 5 thg 6, 2024, 20:56:32
    Author     : caoqu
--%>
<%@ page import="Models.Account" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
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

            <div>

                <div class="container light-style flex-grow-1 container-p-y">
                    <h4 class="font-weight-bold py-3 mb-4">
                        Account settings
                    </h4>
                    <div class="card overflow-hidden">
                        <div class="row no-gutters row-bordered row-border-light">
                            <div class="col-md-12">
                                <div class="tab-content">
                                    <div class="tab-pane fade active show" id="account-general">
                                        <div class="card-body media align-items-center">
                                            <img src="${pageContext.request.contextPath}/images/user/user-profile-image.png" alt
                                             class="d-block ui-w-80">

                                    </div>
                                    <div class="card-body">
                                        <form id="editForm" action="${pageContext.request.contextPath}/customer/profile?action=update" method="post"  onsubmit="return validateForm()" novalidate>
                                            <div class="form-group">
                                                <label class="form-label">Username</label>
                                                <input name="user" type="text" class="form-control mb-1" value="${account.username}" readonly>
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Full Name</label>
                                                <input name="fullname" type="text" class="form-control" value="${account.fullname}" required>
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Email</label>
                                                <input name="email" type="email" class="form-control mb-1" value="${account.email}" required>
                                            </div>
                                            <div class="form-group">
                                                <label class="form-label">Phone</label>
                                                <input name="phone" type="text" class="form-control" value="${account.phone}" required>
                                            </div>
                                       
                                            <button type="submit" class="btn btn-dark">Save changes</button>&nbsp;
                                            <a href="${pageContext.request.contextPath}/customer/profile?action=view" class="btn btn-default">Cancel</a>
                                        </form>


                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../common/homepage/page-footer.jsp"></jsp:include>
                <script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
                <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
                <script type="text/javascript">

                </script>
        </body>
        <script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    
    <script>
            function validateForm() {
                let usernamePattern = /^(?!.*\s).{6,}$/;
                let phonePattern = /^(?!.*\s)0\d{9}$/;
                let passwordPattern = /^(?!.*\s).{8,}$/;
                let emailPattern = /^[^@]+@[^@]+\.[^@]+$/;
                
                let form = document.forms["signupForm"];
                let username = form["user"];
                let phone = form["phone"];
                let fullname = form["fullname"];
                let email = form["email"];

                
                let isValid = true;
                if(fullname.value.trim() === ""){
                    fullname.setCustomValidity("Fullname cannot be empty!!!");
                    isValid = false;
                }
                if (!usernamePattern.test(username.value) || username.value.trim() === "") {
                    username.setCustomValidity("Username must be at least 6 characters without spaces.");
                    isValid = false;
                } else {
                    username.setCustomValidity("");
                }

                if (!phonePattern.test(phone.value) || phone.value.trim() === "") {
                    phone.setCustomValidity("Phone number must be 10 digits and start with 0 without spaces.");
                    isValid = false;
                } else {
                    phone.setCustomValidity("");
                }
                if (!emailPattern.test(email.value)) {
                email.setCustomValidity("Please enter a valid email address.");
                isValid = false;
                } else {
                email.setCustomValidity("");
                }

                if (!isValid) {
                    form.reportValidity();
                }

                return isValid;
            }
        </script>
</html>
