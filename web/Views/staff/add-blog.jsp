<%-- 
    Document   : add-blog
    Created on : 1 thg 7, 2024, 14:35:25
    Author     : caoqu
--%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/images/apple-icon.png">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Add Blog</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" name="viewport" />

        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />

        <link href="${pageContext.request.contextPath}/css/demo.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous"> 
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <style>
            textarea {
                resize: vertical;
                min-height: 250px;
            }
        </style>

    </head>
    <body>
        <div class="wrapper">
            <div class="sidebar" data-image="${pageContext.request.contextPath}/images/sidebar-5.jpg">
            </div>
            <jsp:include page="../common/staff/side-bar.jsp"></jsp:include>
                <div class="main-panel">
                <jsp:include page="../common/staff/header.jsp"></jsp:include>
                    <div class="content">
                        <div class="container mt-5">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="./dashboard">Dashboard</a>
                                </li>
                                <li class="breadcrumb-item">
                                    <a href="./blog">Blog</a>
                                </li>
                                <li class="breadcrumb-item active">${product.getName()}</li>
                        </ol>
                            <h2>Add New Blog</h2>
                            <form action="${pageContext.request.contextPath}/staff/blog" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="add">
                            <div class="form-group">
                                <label for="title">Title:</label>
                                <input type="text" class="form-control" id="title" name="title" required>
                            </div>
                            <div class="form-group">
                                <label for="body">Body:</label>
                                <textarea class="form-control" id="body" name="body" rows="5" required>${blog.body}</textarea>
                            </div>


                            <div class="form-group">
                                <label for="image">Image:</label>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">Upload</span>
                                    </div>
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="image" name="image" onchange="displayImage(this, 'previewImage')">
                                        <label class="custom-file-label" for="image">Choose file</label>
                                    </div>
                                </div>
                                <img id="previewImage" src="#" alt="Preview" style="display: none; max-width: 300px; max-height: 300px;">
                            </div>
                            <div class="form-group">
                                <label for="blogTypeId">Blog Type:</label>
                                <select class="form-control" id="blogTypeId" name="blogTypeId" required>
                                    <c:forEach var="blogType" items="${blogTypes}">
                                        <option value="${blogType.blogTypeId}" <c:if test="${blogType.blogTypeId == blog.blogTypeId}">selected</c:if>>${blogType.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                   

                    <button type="submit" class="btn btn-primary">Add Blog</button>
                    <a href="${pageContext.request.contextPath}/staff/blog" class="btn btn-secondary">Cancel</a>
                    </form>
                     </div>
                </div>
            </div>
            <jsp:include page="../common/staff/footer.jsp"></jsp:include>
            </div>

            <script type="text/javascript">
                function displayImage(input, previewId) {
                    var preview = document.getElementById(previewId);
                    var file = input.files[0];
                    var reader = new FileReader();

                    reader.onload = function (e) {
                        preview.src = e.target.result;
                        preview.style.display = 'block';
                    };

                    reader.readAsDataURL(file);
                }
            </script>

            <script src="${pageContext.request.contextPath}/js/core/jquery.3.2.1.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/core/bootstrap.min.js"></script>

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

