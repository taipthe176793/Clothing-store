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
        <title>Blog</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" name="viewport" />

        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />

        <link href="${pageContext.request.contextPath}/css/demo.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"> 
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
                                    <form action="${pageContext.request.contextPath}/staff/blog" method="get" class="input-group">
                                    <input type="text" id="searchTitle" name="search" class="form-control" placeholder="Search by Blog Title"
                                           value="<c:if test='${not empty searchTitle}'>${searchTitle}</c:if>">
                                           <div class="input-group-append">
                                               <button class="btn btn-outline-secondary" type="submit" id="searchButton">
                                                   Search
                                               </button>
                                           </div>
                                    </form>
                                </div>

                                <div class="col-md-2">
                                    <form action="${pageContext.request.contextPath}/staff/blog" method="get" class="input-group">
                                    <select id="filterStatus" name="filterStatus" class="form-control" onchange="this.form.submit()">
                                        <option value="">Filter by Status</option>
                                        <option value="all">All</option>
                                        <option value="true">Public</option>
                                        <option value="false">Hidden</option>
                                    </select>
                                </form>
                            </div>

                            <div class="col-md-2">
                                <form action="${pageContext.request.contextPath}/staff/blog" method="get" class="input-group">
                                    <select id="filterBlogType" name="filterBlogType" class="form-control" onchange="this.form.submit()">
                                        <option value="">Filter by Blog Type</option>
                                        <option value="all">All</option>
                                        <c:forEach var="blogType" items="${blogTypes}">
                                            <option value="${blogType.blogTypeId}">
                                                ${blogType.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </form>
                            </div>

                            <div class="col-md-2">
                                <form action="${pageContext.request.contextPath}/staff/blog" method="get" class="input-group">
                                    <select id="sortDate" name="sortDate" class="form-control" onchange="this.form.submit()">
                                        <option value="">Sort by Date</option>
                                        <option value="desc">Newest</option>
                                        <option value="asc">Oldest</option>
                                    </select>
                                </form>
                            </div>

                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <a href="${pageContext.request.contextPath}/staff/blog?action=add" class="btn btn-dark  float-right">Add New Blog</a>
                            </div>
                        </div>

                        <!-- Blog table -->
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Title</th>
                                    <th>Image</th>
                                    <th>Blog Type</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="blog" items="${blogs}" varStatus="loop">
                                    <tr>
                                        <td>${loop.index + 1}</td>
                                        <td>${blog.title}</td>
                                        <td>
                                            <img src="${blog.image}" name="image" alt="Blog Image" style="width: 150px; height: 100px;">
                                        </td>
                                        <td>
                                            <c:forEach var="blogType" items="${blogTypes}">
                                                <c:if test="${blog.blogTypeId == blogType.blogTypeId}">
                                                    ${blogType.name}
                                                </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>${blog.createdAt}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${blog.status == false}">Hidden</c:when>
                                                <c:when test="${blog.status == true && blog.status != 'Pending'}">Public</c:when>
                                            </c:choose>
                                        </td>
                                        <td class="d-flex">
                                            <button class="btn btn-secondary btn-sm text-white " style="margin-right: 10px" onclick="location.href = '${pageContext.request.contextPath}/staff/blog?action=edit&blogId=${blog.blogId}'">Edit</button>

                                            <c:if test="${blog.status == false}">
                                                <form action="blog?action=delete" method="post" >
                                                    <input name="blogId" value="${blog.blogId}" hidden="" />
                                                    <button onclick="this.closest('form').submit()" class="btn btn-danger btn-sm">Delete</button>
                                                </form>
                                            </c:if>

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
    </body>
</html>

