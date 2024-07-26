<%-- 
    Document   : table
    Created on : May 23, 2024, 12:54:09 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/images/apple-icon.png">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Manage blog</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" name="viewport" />

        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />


        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/colReorder-bootstrap4.css">

        <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

        <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

        <link href="${pageContext.request.contextPath}/css/sb-admin.css" rel="stylesheet" type="text/css">

        <link href="${pageContext.request.contextPath}/css/sb-admin.min.css" rel="stylesheet" type="text/css">

    </head>

    <body>

        <div class="wrapper">
            <jsp:include page="../common/admin/side-bar.jsp"></jsp:include>
                <div class="main-panel">
                <jsp:include page="../common/admin/header.jsp"></jsp:include>
                    <div class="content">
                        <div class="container-fluid">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="./dashboard">Dashboard</a>
                                </li>
                                <li class="breadcrumb-item active">Blog</li>
                            </ol>

                            <div class="card mb-3">
                                <div class="card-header">
                                    <div>
                                        <i class="fas fa-table"></i>
                                        Blog Posts
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">

                                    <c:if test="${param.success != null}">
                                        <div class="alert alert-success" role="alert">
                                            ${param.success}
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                    </c:if>
                                    <c:if test="${param.error != null}">
                                        <div class="alert alert-error" role="alert">
                                            ${param.error}
                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                    </c:if>
                                    <table class="table table-bordered" id="data-table" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>No.</th>
                                                <th>Title</th>
                                                <th>Image</th>
                                                <th>Body</th>
                                                <th>Type Name</th>
                                                <th>Status</th>
                                                <th>Created At</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${blogs}" var="blog" varStatus="index">
                                                <tr>
                                                    <td>${index.index + 1}</td>
                                                    <td>${blog.title}</td>
                                                    <td><img src=${blog.image} alt="${blog.title}" width="100"></td>
                                                    <td>${fn:substring(blog.body, 0,50)}...</td>
                                                    <td>${blog.typeName}</td>
                                                    <td>
                                                        <span class="badge badge-${blog.status == true ? "success" : "danger"}">
                                                            ${blog.status == true ? "Public" : "Hidden"}
                                                        </span>
                                                    </td>
                                                    <td>${blog.createdAt}</td>
                                                    <td class="d-flex justify-content-center">
                                                        <form action="../admin/manage-blog" method="get">
                                                            <input type="hidden" name="action" value="approve">
                                                            <input type="hidden" name="status" value="${blog.status ? 0 : 1}">
                                                            <input type="hidden" name="blogId" value="${blog.blogId}">
                                                            <button onclick="return confirm('Are you sure to change visibility of this post?')" type="submit" class="btn btn-${blog.status ? "danger" : "success"}">${blog.status ? "Hide" : "Show"}</button>
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
                </div>
                <jsp:include page="../common/admin/footer.jsp"></jsp:include>
                </div>
            </div>


            <script src="${pageContext.request.contextPath}/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/core/popper.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/core/bootstrap.min.js" type="text/javascript"></script>

        <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-switch.js"></script>

        <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.js"></script>
        <script src="${pageContext.request.contextPath}/js/sb-admin.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>
        <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>
        <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
        <script src="${pageContext.request.contextPath}/js/demo.js"></script>
        <script>
                                                                $(document).ready(function () {
                                                                    $("#data-table").DataTable();
                                                                });
        </script>
    </body>
</html>
