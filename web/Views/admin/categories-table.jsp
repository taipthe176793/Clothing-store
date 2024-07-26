<%-- 
    Document   : table
    Created on : May 23, 2024, 12:54:09 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/images/apple-icon.png">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Manage Categories</title>
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
            <div class="sidebar" data-image="${pageContext.request.contextPath}/images/sidebar-5.jpg">



            </div>
            <jsp:include page="../common/admin/side-bar.jsp"></jsp:include>
                <div class="main-panel">

                <jsp:include page="../common/admin/header.jsp"></jsp:include>

                    <div class="content">
                        <div class="container-fluid">

                            <!-- Breadcrumbs-->
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="./dashboard">Dashboard</a>
                                </li>
                                <li class="breadcrumb-item active">Categories</li>
                            </ol>

                            <div class="card mb-3">
                                <div class="card-header d-flex justify-content-between">
                                    <div>
                                        <i class="fas fa-table"></i>
                                        Categories
                                    </div>
                                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addModal">
                                        Add New Category
                                    </button>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>Id</th>
                                                    <th>Image</th>
                                                    <th>Name</th>
                                                    <th>Description</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                        <c:forEach items="${categoryList}" var="c">
                                            <tr>
                                                <td name="id">${c.getCategoryId()}</td>
                                                <td name="image" style="width: 200px"><img style="height: 200px; width: 200px; padding: 0" src="${c.getImg()}" alt="img" /></td>
                                                <td name="name">${c.getName()}</td>  
                                                <td name="description">${c.getDescription()}</td>
                                                <td>
                                                    <button type="button" class="btn btn-primary"
                                                            data-toggle="modal" data-target="#editCategoryModal"
                                                            onclick="editCategoryModal(this)">Edit</button>
                                                </td>
                                            </tr>      
                                        </c:forEach>
                                    </table>
                                </div>
                            </div>
                            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
                        </div>
                    </div>
                </div>
                <jsp:include page="../common/admin/footer.jsp"></jsp:include>
                </div>
            </div>

            <!-- Add Modal -->
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModal" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Add Category</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="addCategoryForm" action="category?action=add" method="post" enctype="multipart/form-data">
                                <!--Name-->
                                <div class="form-group">
                                    <label for="name">Name:</label>
                                    <input type="text" class="form-control" id="nameInput" name="name">
                                    <div id="nameError" class="error"></div>
                                </div>


                                <!--Image-->
                                <div class="form-group">
                                    <label for="image">Image: </label>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Upload</span>
                                        </div>
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="image" name="image" onchange="displayImage(this, 'previewImage')">
                                            <label class="custom-file-label" >Choose file</label>
                                        </div>
                                    </div>
                                    <img id="previewImage" src="#" alt="Preview"
                                         style="display: none; max-width: 300px; max-height: 300px;">

                                </div>
                                
                                <!--Description-->
                                <div class="form-group">
                                    <label for="description">Description:</label>
                                    <textarea class="form-control" name="description"></textarea>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" form="addCategoryForm" onclick="validateForm()">Add</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Update Modal -->
            <div class="modal fade" id="editCategoryModal" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Edit Category</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="editModalForm" action="category?action=update" method="POST" enctype="multipart/form-data">
                                <div class="form-group" style="display: none">
                                    <input type="text" class="form-control" id="idEditInput" name="id">
                                </div>
                                <div class="form-group">
                                    <label for="name">Name:</label>
                                    <input type="text" class="form-control" id="nameEditInput" name="name">
                                    <div id="nameEditError" class="error"></div>
                                </div>                              
                                <!-- img -->
                                <div class="form-group">
                                    <label for="image1">Image: </label>
                                    <div class="input-group mb-3">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text">Upload</span>
                                        </div>
                                        <div class="custom-file">
                                            <input type="file" class="custom-file-input" id="imageEdit" name="image"
                                                   onchange="displayImage2(this, 'previewImage2')">
                                            <label class="custom-file-label">Choose file</label>
                                        </div>
                                    </div>
                                    <img id="previewImage2" src="#" alt="Preview"
                                         style="display: none; max-width: 300px; max-height: 300px;">
                                    <input type="hidden" id="currentImage" name="currentImage2" value="">
                                </div>
                                <!-- Description -->
                                <div class="form-group">
                                    <label for="descriptionEditInput">Description:</label>
                                    <textarea class="form-control" id="descriptionEdit" name="description"></textarea>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary" form="editModalForm"
                                    onclick="validateForm2()">Update</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Notification Modal -->
            <div class="modal fade" id="notiModal" role="dialog" aria-labelledby="errorModal">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="notiModal">Notification</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p>${notification}</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    </body>

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

    
    <script>

    function validateForm() {
        let name = $('#nameInput').val();

        $('.error').html('');

        if (name.trim() === '') {
            $('#nameError').html('Name cannot be empty or contain spaces only!');
        }

        let error = '';
        $('.error').each(function () {
            error += $(this).html();
        });
        if (error === '') {
            $('#addCategoryForm').submit();
        } else {
            event.preventDefault();
        }
    }

    function displayImage(input, previewId) {
        var previewImage = document.getElementById(previewId);
        var file = input.files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            previewImage.src = e.target.result;
            previewImage.style.display = "block";
        };

        reader.readAsDataURL(file);
    }

    function validateForm2() {
        let name = $('#nameEditInput').val();

        $('.error').html('');

        if (name.trim() === '') {
            $('#nameEditError').html('Name cannot be empty');
        }

        let error = '';
        $('.error').each(function () {
            error += $(this).html();
        });
        if (error === '') {
            $('#editModalForm').submit();
        } else {
            event.preventDefault();
        }
    }

    function displayImage2(input, previewId) {
        var previewImage = document.getElementById(previewId);

        var file = input.files[0];
        var reader = new FileReader();

        reader.onload = function (e) {
            previewImage.src = e.target.result;
            previewImage.style.display = "block";
        };

        reader.readAsDataURL(file);
    }

    function editCategoryModal(button) {
        let id = $(button).closest('tr').find('td[name="id"]').text().trim();
        let name = $(button).closest('tr').find('td[name="name"]').text().trim();
        let image = $(button).closest('tr').find('td[name="image"]').find('img').attr('src');
        let description = $(button).closest('tr').find('td[name="description"]').text().trim();

        $('#idEditInput').val(id);
        $('#nameEditInput').val(name);
        $('#descriptionEdit').val(description);
        $('#previewImage2').attr('src', image);
        $('#previewImage2').css('display', 'block');
        $('#currentImage2').val(image);
    }

    //Display Error
    $(document).ready(function () {
        <c:if test="${notification != null}">
            $('#notiModal').modal('show');
        </c:if>
    });

    </script>

</html>