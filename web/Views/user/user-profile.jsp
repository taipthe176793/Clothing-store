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
        <style>
            .list-group-item-action.active {
                background-color: black !important;
                border-color: black !important;
            }
        </style>
    </head>

    <body>
        <jsp:include page="../common/homepage/page-header.jsp"></jsp:include>

            <div class="container light-style flex-grow-1 container-p-y">
                <h4 class="font-weight-bold py-3 mb-4">
                    Account 
                </h4>
                <div class="card overflow-hidden">
                    <div class="row no-gutters row-bordered row-border-light">
                        <div class="col-md-3 pt-0">
                            <div class="list-group list-group-flush account-settings-links">
                                <a class="list-group-item list-group-item-action active" data-toggle="list"
                                   href="#account-general">General</a>
                                <a class="list-group-item list-group-item-action"
                                   href="${pageContext.request.contextPath}/customer/change-password">Change password</a>
                            <a class="list-group-item list-group-item-action" 
                               href="${pageContext.request.contextPath}/customer/address">My Address</a>

                           <a class="list-group-item list-group-item-action" 
                               href="${pageContext.request.contextPath}/my-coupon">My Coupon</a>
                            <a class="list-group-item list-group-item-action" 
                               href="${pageContext.request.contextPath}/history-order">My Orders History</a>
                          
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="tab-content">
                            <div class="tab-pane fade active show" id="account-general">
                                <div class="card-body media align-items-center">
                                    <img src="${pageContext.request.contextPath}/images/user/user-profile-image.png" alt
                                         class="d-block ui-w-80">
                                </div>
                                <hr class="border-light m-0">
                                <div class="card-body">

                                    <div class="form-group">
                                        <label class="form-label">Username</label>
                                        <input name="user" type="text" class="form-control mb-1" value="${account.username}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Full Name</label>
                                        <input name="fullname" type="text" class="form-control mb-1" value="${account.fullname}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Email</label>
                                        <input name="email" type="email" class="form-control mb-1" value="${account.email}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label class="form-label">Phone</label>
                                        <input name="phone" type="text" class="form-control" value="${account.phone}" readonly>
                                    </div>

                                    <button onclick="location.href = 'profile?action=update'" class="btn btn-dark">Edit Profile</button>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <c:if test="${notification ne null}">
            <div id="alert" class="alert-box ${type}">
                ${notification}
            </div>
        </c:if>
        <jsp:include page="../common/homepage/page-footer.jsp"></jsp:include>
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
        <script src="${pageContext.request.contextPath}/js/main.js"></script>
        <script>

                                document.addEventListener('DOMContentLoaded', function () {

                                    const alert = document.querySelector('#alert');

                                    if (alert) {
                                        alert.style.display = 'block';
                                        alert.style.opacity = '1';

                                        setTimeout(function () {
                                            alert.style.opacity = '0';

                                            setTimeout(function () {
                                                alert.classList.add('show');
                                            }, 500);
                                        }, 4000);
                                    }

                                });

        </script>
    </body>
</html>
