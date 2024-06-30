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
            <meta charset="utf-8"/>
            <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/images/apple-icon.png">
            <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
            <title>Blog Products</title>
            <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no"
                  name="viewport"/>
            <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet"/>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"/>
            <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
            <link href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet"/>
            <link href="${pageContext.request.contextPath}/css/demo.css" rel="stylesheet"/>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/css/colReorder-bootstrap4.css">
            <link href="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">
            <link href="${pageContext.request.contextPath}/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
            <link href="${pageContext.request.contextPath}/css/sb-admin.css" rel="stylesheet" type="text/css">
            <link href="${pageContext.request.contextPath}/css/sb-admin.min.css" rel="stylesheet" type="text/css">
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
        </head>
        <body>
            <div class="wrapper">
                <div class="sidebar" data-image="${pageContext.request.contextPath}/images/sidebar-5.jpg">
                    <jsp:include page="../common/staff/side-bar.jsp"></jsp:include>
                    </div>
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
                                            <td>${blog.blogId}</td>
                                            <td>${blog.title}</td>
                                            <td>${blog.body}</td>
                                            <td><img src="${blog.image}" alt="Blog Image" style="width: 50px; height: 50px;"></td>
                                            <td>${blog.blogTypeId}</td>
                                            <td>${blog.createdAt}</td>
                                            <td>${blog.status ? 'Visible' : 'Hidden'}</td>
                                            <td>
                                                <button class="btn btn-warning btn-sm" onclick="editBlog(${blog.blogId})">Edit</button>
                                                <button class="btn btn-danger btn-sm" onclick="deleteBlog(${blog.blogId})">Delete</button>
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

            <script>
               
                document.getElementById('searchTitle').addEventListener('input', filterBlogs);
                document.getElementById('filterStatus').addEventListener('change', filterBlogs);
                document.getElementById('filterBlogType').addEventListener('change', filterBlogs);
                document.getElementById('filterDateFrom').addEventListener('change', filterBlogs);
                document.getElementById('filterDateTo').addEventListener('change', filterBlogs);

                function filterBlogs() {
                    // Get filter values
                    var searchTitle = document.getElementById('searchTitle').value.toLowerCase();
                    var filterStatus = document.getElementById('filterStatus').value;
                    var filterBlogType = document.getElementById('filterBlogType').value;
                    var filterDateFrom = document.getElementById('filterDateFrom').value;
                    var filterDateTo = document.getElementById('filterDateTo').value;

                    var rows = document.querySelectorAll('tbody tr');

                    rows.forEach(function (row) {
                        var title = row.cells[1].textContent.toLowerCase();
                        var status = row.cells[6].textContent.toLowerCase();
                        var blogType = row.cells[4].textContent;
                        var date = row.cells[5].textContent;

                        var show = true;

                        if (searchTitle && !title.includes(searchTitle)) {
                            show = false;
                        }

                        if (filterStatus && ((filterStatus === 'true' && status !== 'visible') || (filterStatus === 'false' && status !== 'hidden'))) {
                            show = false;
                        }

                        if (filterBlogType && blogType !== filterBlogType) {
                            show = false;
                        }

                        if (filterDateFrom && new Date(date) < new Date(filterDateFrom)) {
                            show = false;
                        }

                        if (filterDateTo && new Date(date) > new Date(filterDateTo)) {
                            show = false;
                        }

                        row.style.display = show ? '' : 'none';
                    });
                }
            </script>


            <script src="${pageContext.request.contextPath}/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
            <script src="${pageContext.request.contextPath}/js/core/popper.min.js" type="text/javascript"></script>
            <script src="${pageContext.request.contextPath}/js/core/bootstrap.min.js" type="text/javascript"></script>
            <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-switch.js"></script>
            <script src="${pageContext.request.contextPath}/js/plugins/chartist.min.js"></script>
            <script src="${pageContext.request.contextPath}/js/plugins/jquery.sharrre.js"></script>
            <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-notify.js"></script>
            <script src="${pageContext.request.contextPath}/js/light-bootstrap-dashboard.js?v=2.0.1" type="text/javascript"></script>
            <script src="${pageContext.request.contextPath}/js/demo.js"></script>
            <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
            <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.js"></script>
            <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.js"></script>
            <script src="${pageContext.request.contextPath}/js/sb-admin.min.js"></script>
            <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>
            <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>
            <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
            <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>
            <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>
        </body>
    </html>

