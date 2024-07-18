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
                            <hr>
                            <h3>Order informaton</h3>
                            <hr>
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td><strong>Order code</strong></td>
                                        <td>${order.orderCode}</td>
                                </tr>
                                <tr>
                                    <td><strong>Fullname</strong></td>
                                    <td>${order.fullname}</td>
                                </tr>
                                <tr>
                                    <td><strong>Phone</strong></td>
                                    <td>${order.phone}</td>
                                </tr>
                                <tr>
                                    <td><strong>Email</strong></td>
                                    <td>${order.email}</td>
                                </tr>
                                <tr>
                                    <td><strong>Address</strong></td>
                                    <td>${order.deliveryAddress}</td>
                                </tr>
                                <tr>
                                    <td><strong>Total</strong></td>
                                    <td>${order.totalAmount}</td>
                                </tr>
                                <tr>
                                    <td><strong>Discount</strong></td>
                                    <td>${order.discount}</td>
                                </tr>
                                <tr>
                                    <td><strong>Status</strong></td>
                                    <td>${order.status}</td>
                                </tr>
                                <tr>
                                    <td><strong>Is paid</strong></td>
                                    <td>
                                        <c:if test="${order.isPaid}">Yes</c:if>
                                        <c:if test="${!order.isPaid}">No</c:if>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <hr>
                            <c:if test="${param.success != null}">
                                <div class="alert alert-success alert-dismissible fade show" role="alert">
                                    ${param.success}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </c:if>
                            <c:if test="${param.error}">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    ${param.error}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </c:if>
                        <hr>
                        <form action="${pageContext.request.contextPath}/staff/manage-order" method="post">
                            <input type="hidden" name="action" value="UpdateStatus">
                            <input type="hidden" name="orderId" value="${order.orderId}">
                            <div class="form-group">
                                <label for="status">Change Status</label>
                                <select name="status" id="status" class="form-control">
                                    <option value="Pending" <c:if test="${order.status == 'Pending'}">selected</c:if>>Pending</option>
                                    <option value="Shipping" <c:if test="${order.status == 'Shipping'}">selected</c:if>>Shipping</option>
                                    <option value="Delivered" <c:if test="${order.status == 'Delivered'}">selected</c:if>>Delivered</option>
                                    <option value="Cancelled" <c:if test="${order.status == 'Cancelled'}">selected</c:if>>Cancelled</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary">Update Status</button>
                            </form>
                            <hr>
                            <h3>Order Details</h3>
                            <hr>
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Product name</th>
                                        <th>Quantity</th>
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
                                        <td>${detail.variant.quantity}</td>
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

