<%-- 
    Document   : order
    Created on : 15 thg 6, 2024, 20:58:51
    Author     : truonghn
--%>

<%@ page import="Models.CustomerCoupon" %>
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
                        <h2>My Coupons</h2>
                    </div>
                </div>

            <div class="card">
                <div class="card-body">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Coupon ID</th>
                                <th>CODE</th>
                                <th>Description</th>
                                <th>Discount</th>
                                <th>Expires At</th>
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

        </div>

        <jsp:include page="../common/homepage/page-footer.jsp"></jsp:include>
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
        <script src="${pageContext.request.contextPath}/js/main.js"></script>

    </body>
</html>
