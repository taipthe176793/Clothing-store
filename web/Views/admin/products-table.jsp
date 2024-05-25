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
        <title>Manage Products</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" name="viewport" />


        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />

        <link href="${pageContext.request.contextPath}/css/demo.css" rel="stylesheet" />

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
                                <li class="breadcrumb-item active">Products</li>
                            </ol>



                            <div class="card mb-3">
                                <div class="card-header d-flex justify-content-between">
                                    <div>
                                        <i class="fas fa-table"></i>
                                        Products List
                                    </div>
                                    <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addModal">
                                        Add New Product
                                    </button>
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>Id</th>
                                                    <th>Name</th>
                                                    <th>Description</th>
                                                    <th>Price</th>
                                                    <th>Image 1</th>
                                                    <th>Image 2</th>
                                                    <th>Image 3</th>
                                                    <th>Category</th>
                                                    <th>Variants</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                        <c:forEach items="${productList}" var="product">
                                            <tr>
                                                <td name="id">${product.getProductId()}</td>
                                                <td name="name">${product.getName()}</td>
                                                <td name="description">${product.getDescription()}</td>
                                                <td name="price">$${product.getPrice()}</td>
                                                <td name="img1"><img style="height: 100px" src="${product.getImg1()}" alt="img1" /></td>
                                                <td name="img2"><img style="height: 100px" src="${product.getImg2()}" alt="img2" /></td>
                                                <td name="img3"><img style="height: 100px" src="${product.getImg3()}" alt="img3" /></td>
                                                    <c:forEach items="${categoryList}" var="category">
                                                        <c:if test="${product.getCategoryId() == category.getCategoryId()}">
                                                        <td name="category">${category.getName()}</td>
                                                    </c:if>
                                                </c:forEach>
                                                <td>
                                                    <a class="d-flex justify-content-center" 
                                                       href="product/variants?pId=${product.getProductId()}"><i class="fa fa-eye"></i></a>
                                                </td>
                                                <td class="d-flex justify-content-center">
                                                    <button type="button" class="btn btn-primary"
                                                            data-toggle="modal" data-target="#editProductModal"
                                                            onclick="editProductModal(this)">Edit</button>
                                                    <button type="button" class="btn btn-danger" 
                                                            data-toggle="modal" data-target="#delete-product-modal"
                                                            onclick="deleteProductModal(${product.getProductId()})">Delete</button>
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
                            <h5 class="modal-title" id="">Add Product</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="addProductForm" action="product?action=add" method="post" enctype="multipart/form-data">
                                <!--Name-->
                                <div class="form-group">
                                    <label for="name">Name:</label>
                                    <input type="text" class="form-control" id="nameInput" name="name">
                                    <div id="nameError" class="error"></div>
                                </div>
                                <!--Price-->
                                <div class="form-group">
                                    <label for="price">Price:</label>
                                    <input type="text" class="form-control" id="priceInput" name="price">
                                    <div id="priceError" class="error"></div>
                                </div>
                                <!--Category-->
                                <div class="form-group">
                                    <label for="category">Category: </label>
                                    <div class="input-group">
                                        <select class="custom-select" id="category" name="categoryId">
                                        <c:forEach items="${categoryList}" var="c">
                                            <option value="${c.getCategoryId()}">${c.getName()}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button">Category</button>
                                    </div>
                                </div>
                            </div>
                            <!--Image 1-->
                            <div class="form-group">
                                <label for="image1">Image 1: </label>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">Upload</span>
                                    </div>
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="image1" name="image1" onchange="displayImage(this, 'previewImage1')">
                                        <label class="custom-file-label" >Choose file</label>
                                    </div>
                                </div>
                                <img id="previewImage1" src="#" alt="Preview"
                                     style="display: none; max-width: 300px; max-height: 300px;">

                            </div>
                            <!--Image 2-->
                            <div class="form-group">
                                <label for="image2">Image 2: </label>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">Upload</span>
                                    </div>
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="image2" name="image2" onchange="displayImage(this, 'previewImage2')">
                                        <label class="custom-file-label" >Choose file</label>
                                    </div>
                                </div>
                                <img id="previewImage2" src="#" alt="Preview"
                                     style="display: none; max-width: 300px; max-height: 300px;">

                            </div>
                            <!--Image 3-->
                            <div class="form-group">
                                <label for="image3">Image 3: </label>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">Upload</span>
                                    </div>
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="image3" name="image3" onchange="displayImage(this, 'previewImage3')">
                                        <label class="custom-file-label" >Choose file</label>
                                    </div>
                                </div>
                                <img id="previewImage3" src="#" alt="Preview"
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
                        <button type="submit" class="btn btn-primary" form="addProductForm" onclick="validateForm()">Add</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Update Modal -->
        <div class="modal fade" id="editProductModal" tabindex="-1" role="dialog" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Edit Product</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="editModalForm" action="product?action=update" method="POST" enctype="multipart/form-data">
                            <div class="form-group" style="display: none">
                                <input type="text" class="form-control" id="idEditInput" name="id">
                            </div>
                            <div class="form-group">
                                <label for="name">Name:</label>
                                <input type="text" class="form-control" id="nameEditInput" name="name">
                                <div id="nameEditError" class="error"></div>
                            </div>
                            <div class="form-group">
                                <label for="price">Price:</label>
                                <input type="text" class="form-control" id="priceEditInput" name="price">
                                <div id="priceEditError" class="error"></div>
                            </div>
                            <div class="form-group">
                                <label for="category">Category: </label>
                                <div class="input-group">
                                    <select class="custom-select" id="categoryEditInput" name="categoryId">
                                        <c:forEach items="${categoryList}" var="c">
                                            <option value="${c.getCategoryId()}">${c.getName()}</option>
                                        </c:forEach>
                                    </select>
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button">Category</button>
                                    </div>
                                </div>
                            </div>
                            <!-- img1 -->
                            <div class="form-group">
                                <label for="image1">Image 1: </label>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">Upload</span>
                                    </div>
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="imageEdit" name="image1"
                                               onchange="displayImage2(this, 'previewImageU1')">
                                        <label class="custom-file-label">Choose file</label>
                                    </div>
                                </div>
                                <img id="previewImageU1" src="#" alt="Preview"
                                     style="display: none; max-width: 300px; max-height: 300px;">
                                <input type="hidden" id="currentImage1" name="currentImage1" value="">
                            </div>
                            <!-- img2 -->
                            <div class="form-group">
                                <label for="image2">Image 2: </label>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">Upload</span>
                                    </div>
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="imageEdit" name="image2"
                                               onchange="displayImage2(this, 'previewImageU2')">
                                        <label class="custom-file-label">Choose file</label>
                                    </div>
                                </div>
                                <img id="previewImageU2" src="#" alt="Preview"
                                     style="display: none; max-width: 300px; max-height: 300px;">
                                <input type="hidden" id="currentImage2" name="currentImage2" value="">
                            </div>
                            <!-- img3 -->
                            <div class="form-group">
                                <label for="image3">Image 3: </label>
                                <div class="input-group mb-3">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">Upload</span>
                                    </div>
                                    <div class="custom-file">
                                        <input type="file" class="custom-file-input" id="imageEdit" name="image3"
                                               onchange="displayImage2(this, 'previewImageU3')">
                                        <label class="custom-file-label">Choose file</label>
                                    </div>
                                </div>
                                <img id="previewImageU3" src="#" alt="Preview"
                                     style="display: none; max-width: 300px; max-height: 300px;">
                                <input type="hidden" id="currentImage3" name="currentImage3" value="">
                            </div>
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

        <!-- Delete Modal -->
        <div class="modal fade" id="delete-product-modal" tabindex="-1" role="dialog" aria-labelledby="delete-modal-label" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="delete-modal-label">Delete confirmation</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to delete this product?</p>
                    </div>
                    <div class="modal-footer">
                        <form action="product?action=delete" method="POST">
                            <div class="form-group" style="display: none">
                                <input type="text" class="form-control" id="idDeleteInput" name="id" value="">
                            </div>
                            <button type="submit" class="btn btn-danger">Yes</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Error Modal -->
        <div class="modal fade" id="errorModal" role="dialog" aria-labelledby="errorModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="errorModal">Error</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>${error}</p>
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
    <script src="${pageContext.request.contextPath}/js/plugins/chartist.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugins/jquery.sharrre.js"></script>
    <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-notify.js"></script>
    <script src="${pageContext.request.contextPath}/js/light-bootstrap-dashboard.js?v=2.0.1" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/demo.js"></script>


    <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/datatables/jquery.dataTables.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/datatables/dataTables.bootstrap4.js"></script>
    <script src="${pageContext.request.contextPath}/js/sb-admin.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>
    <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>
    <script src="${pageContext.request.contextPath}/js/demo/datatables-demo.js"></script>
    <script src="${pageContext.request.contextPath}/js/demo/chart-area-demo.js"></script>
    <script src="${pageContext.request.contextPath}/js/colReorder-dataTables-min.js"></script>
    <script src="${pageContext.request.contextPath}/js/colReorder-bootstrap4-min.js"></script>

    <script>
    </script>

    <script>

        function validateForm() {
            let name = $('#nameInput').val();
            let price = $('#priceInput').val();

            $('.error').html('');

            if (name === '') {
                $('#nameError').html('Name cannot be empty!');
            }

            if (price === '') {
                $('#priceError').html('Price cannot be empty!');
            } else if (!$.isNumeric(price) || parseFloat(price) < 0) {
                $('#priceError').html('Price must greater than 0');
            }

            let error = '';
            $('.error').each(function () {
                error += $(this).html();
            });
            if (error === '') {
                $('#addProductForm').submit();
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
            let price = $('#priceEditInput').val();

            $('.error').html('');

            if (name === '') {
                $('#nameEditError').html('Name cannot be empty');
            }

            if (price === '') {
                $('#priceEditError').html('Price cannot be empty');
            } else if (!$.isNumeric(price) || parseFloat(price) < 0) {
                $('#priceEditError').html('Price must greater than 0');
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

        function editProductModal(button) {
            let id = $(button).closest('tr').find('td[name="id"]').text().trim();
            let name = $(button).closest('tr').find('td[name="name"]').text().trim();
            let price = $(button).closest('tr').find('td[name="price"]').text().trim().replace('$', '');
            let categoryText = $(button).closest('tr').find('td[name="category"]').text().trim();
            let description = $(button).closest('tr').find('td[name="description"]').text().trim();
            let img1 = $(button).closest('tr').find('td[name="img1"]').find('img').attr('src');
            let img2 = $(button).closest('tr').find('td[name="img2"]').find('img').attr('src');
            let img3 = $(button).closest('tr').find('td[name="img3"]').find('img').attr('src');

            $('#idEditInput').val(id);
            $('#nameEditInput').val(name);
            $('#priceEditInput').val(price);

            $('#categoryEditInput option').each(function () {
                if ($(this).text() === categoryText) {
                    $(this).prop('selected', true);
                }
            });
            $('#descriptionEdit').val(description);
            $('#previewImageU1').attr('src', img1);
            $('#previewImageU1').css('display', 'block');
            $('#currentImage1').val(img1);
            $('#previewImageU2').attr('src', img2);
            $('#previewImageU2').css('display', 'block');
            $('#currentImage2').val(img2);
            $('#previewImageU3').attr('src', img3);
            $('#previewImageU3').css('display', 'block');
            $('#currentImage3').val(img3);
        }

        function deleteProductModal(id) {
            let inputId = document.querySelector("#idDeleteInput");
            inputId.value = id;
        }

        //Display Error
        $(document).ready(function () {
        <c:if test="${error != null}">
            $('#errorModal').modal('show');
        </c:if>
        });

    </script>




</html>