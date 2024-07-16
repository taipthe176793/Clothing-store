<%-- 
    Document   : feedback-table
    Created on : 4 thg 7, 2024, 17:02:02
    Author     : caoqu
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/images/apple-icon.png">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Manage Feedback</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" name="viewport" />

        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/demo.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"> 
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    </head>
    <body>
        <div class="wrapper">
            <div class="sidebar" data-image="${pageContext.request.contextPath}/images/sidebar-5.jpg">
            </div>
            <jsp:include page="../common/staff/side-bar.jsp"></jsp:include>
                <div class="main-panel">
                <jsp:include page="../common/staff/header.jsp"></jsp:include>
                    <div class="content">
                        <div class="container-fluid">
                            <div class="row mb-3">
                                <!-- Filters and search -->
                                <div class="col-md-4">
                                    <form action="${pageContext.request.contextPath}/staff/feedback" method="get" class="input-group">
                                    <input type="text" id="searchCustomer" name="search" class="form-control" placeholder="Search by Product" value="${search}">
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="submit" id="searchButton">
                                            Search
                                        </button>
                                    </div>
                                </form>
                            </div>

                            <div class="col-md-2">
                                <form action="${pageContext.request.contextPath}/staff/feedback" method="get" class="input-group">
                                    <select id="sortDate" name="sortDate" class="form-control" onchange="this.form.submit()">
                                        <option value="">Sort by Date</option>
                                        <option value="desc" ${sortDate == 'desc' ? 'selected' : ''}>Newest</option>
                                        <option value="asc" ${sortDate == 'asc' ? 'selected' : ''}>Oldest</option>
                                    </select>
                                </form>
                            </div>
                        </div>

                        <!-- Bootstrap Tabs -->
                        <ul class="nav nav-tabs" id="feedbackTab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="all-tab" data-toggle="tab" href="#all" role="tab" aria-controls="all" aria-selected="true">All</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="report-tab" data-toggle="tab" href="#report" role="tab" aria-controls="report" aria-selected="false">Report</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="feedbackTabContent">
                            <!-- All Feedback Tab -->
                            <div class="tab-pane fade show active" id="all" role="tabpanel" aria-labelledby="all-tab">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Customer</th>
                                            <th>Product</th>
                                            <th>Comment</th>
                                            <th>Rating</th>
                                            <th>Date</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="feedback" items="${feedbacks}" varStatus="loop">
                                            <tr>
                                                <td>${loop.index + 1}</td>
                                                <td>${feedback.username}</td>
                                                <td>
                                                    <c:forEach var="product" items="${products}">
                                                        <c:if test="${feedback.productId == product.productId}">
                                                            ${product.name}
                                                        </c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>${feedback.comment}</td>
                                                <td>${feedback.rating}</td>
                                                <td>${feedback.createdAt}</td>
                                                <td>
                                                    <c:if test="${feedback.isIsDeleted()}">Hidden</c:if>
                                                    <c:if test="${!feedback.isIsDeleted()}">Active</c:if>
                                                    </td>
                                                    <td>
                                                        <form action="${pageContext.request.contextPath}/staff/feedback" method="post">
                                                        <input type="hidden" name="feedbackId" value="${feedback.feedbackId}">
                                                        <input type="hidden" name="action" value="${feedback.isIsDeleted() ? 'active' : 'hidden'}">
                                                        <button type="submit" class="btn btn-sm ${feedback.isIsDeleted() ? 'btn-success' : 'btn-danger'}">
                                                            ${feedback.isIsDeleted() ? 'Show' : 'Hide'}
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Reported Feedback Tab -->
                            <div class="tab-pane fade" id="report" role="tabpanel" aria-labelledby="report-tab">
                                <table class="table table-striped table-hover">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Customer</th>
                                            <th>Product</th>
                                            <th>Comment</th>
                                            <th>Rating</th>
                                            <th>Date</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="feedback" items="${reportedFeedbacks}" varStatus="loop">
                                            <tr id="feedback-${feedback.feedbackId}" class="${feedback.isReported ? 'reported' : ''}">
                                                <td>${loop.index + 1}</td>
                                                <td>${feedback.username}</td>
                                                <td>
                                                    <c:forEach var="product" items="${products}">
                                                        <c:if test="${feedback.productId == product.productId}">
                                                            ${product.name}
                                                        </c:if>
                                                    </c:forEach>
                                                </td>
                                                <td>${feedback.comment}</td>
                                                <td>${feedback.rating}</td>
                                                <td>${feedback.createdAt}</td>
                                                <td>
                                                    <c:if test="${feedback.isIsDeleted()}">Hidden</c:if>
                                                    <c:if test="${!feedback.isIsDeleted()}">Active</c:if>
                                                    </td>
                                                    <td>
                                                        <form action="${pageContext.request.contextPath}/staff/feedback" method="post">
                                                        <input type="hidden" name="feedbackId" value="${feedback.feedbackId}">
                                                        <input type="hidden" name="action" value="hidden">
                                                        <button type="submit" class="btn btn-sm btn-danger">Hide</button>
                                                    </form>
                                                    <form action="${pageContext.request.contextPath}/staff/feedback" method="post">
                                                        <input type="hidden" name="feedbackId" value="${feedback.feedbackId}">
                                                        <input type="hidden" name="action" value="cancel">
                                                        <button type="submit" class="btn btn-sm btn-secondary">Cancel</button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <jsp:include page="../common/staff/footer.jsp"></jsp:include>
                </div>
            </div>
            <script src="${pageContext.request.contextPath}/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/core/popper.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/core/bootstrap.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-switch.js"></script>
        <script src="${pageContext.request.contextPath}/js/plugins/chartist.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/plugins/jquery.sharrre.js"></script>
        <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-notify.js"></script>
        <script src="${pageContext.request.contextPath}/js/light-bootstrap-dashboard.js?v=2.0.1" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/demo.js"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    </body>
</html>
