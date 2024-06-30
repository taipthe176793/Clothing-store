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
        <title>Account Profile</title>
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
                                    <input type="text" id="searchTitle" class="form-control" placeholder="Search by Blog Title">
                                </div>
                                <div class="col-md-2">
                                    <select id="filterStatus" class="form-control">
                                        <option value="">Filter by Status</option>
                                        <option value="true">Visible</option>
                                        <option value="false">Hidden</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <select id="filterBlogType" class="form-control">
                                        <option value="">Filter by Blog Type</option>
                                        <option value="1">Type 1</option>
                                        <option value="2">Type 2</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <input type="date" id="filterDateFrom" class="form-control" placeholder="From Date">
                                </div>
                                <div class="col-md-2">
                                    <input type="date" id="filterDateTo" class="form-control" placeholder="To Date">
                                </div>
                            </div>
                            <div class="row mb-3">
                                <!-- Add new blog button -->
                                <div class="col-md-12">
                                    <button class="btn btn-primary float-right" data-toggle="modal" data-target="#addBlogModal">Add New Blog</button>
                                </div>
                            </div>
                            <!-- Blog table -->
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Body</th>
                                        <th>Image</th>
                                        <th>Blog Type</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="blog" items="${blogs}">
                                    <tr>
                                        <td>${blog.getBlogId}</td>
                                        <td>${blog.getTitle}</td>
                                        <td>${blog.getBody}</td>
                                        <td><img src="${blog.getImage}" alt="Blog Image" style="width: 50px; height: 50px;"></td>
                                        <td>${blog.getBlogTypeId}</td>
                                        <td>${blog.getCreatedAt}</td>
                                        <td>${blog.getStatus ? 'Visible' : 'Hidden'}</td>
                                        <td>
                                            <button class="btn btn-warning btn-sm" onclick="editBlog(${blog.getBlogId})">Edit</button>
                                            <button class="btn btn-danger btn-sm" onclick="deleteBlog(${blog.getBlogId})">Delete</button>
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


            <!-- Add Blog Modal -->
            <div class="modal fade" id="addBlogModal" tabindex="-1" role="dialog" aria-labelledby="addBlogModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addBlogModalLabel">Add New Blog</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="addBlogForm" action="${pageContext.request.contextPath}/staff/blog" method="post">
                            <input type="hidden" name="action" value="add">
                            <div class="form-group">
                                <label for="title">Title</label>
                                <input type="text" class="form-control" id="title" name="title" required>
                            </div>
                            <div class="form-group">
                                <label for="body">Body</label>
                                <textarea class="form-control" id="body" name="body" rows="5" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="image">Image URL</label>
                                <input type="text" class="form-control" id="image" name="image" required>
                            </div>
                            <div class="form-group">
                                <label for="blogTypeId">Blog Type</label>
                                <select class="form-control" id="blogTypeId" name="blogTypeId" required>
                                    <option value="1">Type 1</option>
                                    <option value="2">Type 2</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="status">Status</label>
                                <select class="form-control" id="status" name="status" required>
                                    <option value="true">Visible</option>
                                    <option value="false">Hidden</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </form>
                    </div>
                </div>
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

