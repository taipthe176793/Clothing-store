<%-- 
    Document   : blogs-table.jsp
    Created on : 29 thg 6, 2024, 15:40:22
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
        <title>Manage order</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" name="viewport" />

        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />

        <link href="${pageContext.request.contextPath}/css/demo.css" rel="stylesheet" />
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
                            <!-- Blog table -->
                            <table class="table table-bordered" id="data-table">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Order code</th>
                                        <th>Full name</th>
                                        <th>Phone</th>
                                        <th>Email</th>
                                        <th>Address</th>
                                        <th>Total</th>
                                        <th>Status</th>
                                        <th>Paid</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="order" items="${orders}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${order.orderCode}</td>
                                        <td>${order.fullname}</td>
                                        <td>${order.phone}</td>
                                        <td>${order.email}</td>
                                        <td>${order.deliveryAddress}</td>
                                        <td>$${order.totalAmount}</td>
                                        <td>${order.status}</td>
                                        <td><c:if test="${order.isPaid}"><span class="text-success font-weight-bold">Yes</span></c:if><c:if test="${!order.isPaid}"><span class="text-danger font-weight-bold">No</span></c:if></td>
                                            <td>
                                            <a href="${pageContext.request.contextPath}/staff/manage-order?action=view&orderId=${order.orderId}" class="btn btn-info btn-sm">View Details</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
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
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"> 
        <link rel="stylesheet" href="https://cdn.datatables.net/2.0.8/css/dataTables.bootstrap4.css"/>
        <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.datatables.net/2.0.8/js/dataTables.js"></script>
        <script src="https://cdn.datatables.net/2.0.8/js/dataTables.bootstrap5.js"></script>
        <script>
            $(document).ready(function () {
                $("#data-table").DataTable();
            });
        </script>
    </body>
</html>

