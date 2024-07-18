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
                    <div class="col-12">
                        <h2>History order</h2>
                    </div>
                </div>

            <div class="card">
                <div class="card-body">
                    <h3>Order Information</h3>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Order code</th>
                                <th>Fullname</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Address</th>
                                <th>Total</th>
                                <th>Discount</th>
                                <th>Status</th>
                                <th>Is paid</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>${order.orderCode}</td>
                                <td>${order.fullname}</td>
                                <td>${order.phone}</td>
                                <td>${order.email}</td>
                                <td>${order.deliveryAddress}</td>
                                <td>${order.totalAmount}</td>
                                <td>${order.discount}</td>
                                <td>${order.status}</td>
                                <td>
                                    <c:if test="${order.isPaid}">Yes</c:if>
                                    <c:if test="${!order.isPaid}">No</c:if>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <h3>Order Details</h3>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Product name</th>
                                    <th>Color</th>
                                    <th>Size</th>
                                    <th>Image</th>
                                    <th>Quantity</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="detail" items="${order.listOrderDetails}" varStatus="loop">
                                <tr>
                                    <td>${loop.index + 1}</td>
                                    <td>${detail.variant.product.name}</td>
                                    <td>${detail.variant.color}</td>
                                    <td>${detail.variant.size}</td>
                                    <td>
                                        <img src="${detail.variant.product.img1}" width="100px" height="height" alt="alt"/>
                                    </td>
                                    <td>${detail.quantity}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <a href="${pageContext.request.contextPath}/customer/profile?action=view" class="btn btn-dark" style="width: 10%; margin: 0 auto">Back to Profile</a>
            </div>

            
        </div>

        <jsp:include page="../common/homepage/page-footer.jsp"></jsp:include>
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
        <script src="${pageContext.request.contextPath}/js/main.js"></script>

    </body>
</html>
