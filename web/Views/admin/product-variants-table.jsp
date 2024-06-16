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
        <title>Manage Variants</title>
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
                                    <a href="../dashboard">Dashboard</a>
                                </li>
                                <li class="breadcrumb-item">
                                    <a href="../product">Products</a>
                                </li>
                                <li class="breadcrumb-item active">${product.getName()}</li>
                        </ol>

                        <div class="card mb-3">
                            <div class="card-header d-flex justify-content-between">
                                <div>
                                    <i class="fas fa-table"></i>
                                    Product's variants List
                                </div>
                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#addModal">
                                    Add New Variant
                                </button>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                        <thead>
                                            <tr>
                                                <th>Variant Id</th>
                                                <th>Product Name</th>
                                                <th>Color</th>
                                                <th>Size</th>
                                                <th>Quantity</th>
                                                <th width="10%">Action</th>
                                            </tr>
                                        </thead>
                                        <c:forEach items="${variantsList}" var="variant">
                                            <tr>
                                                <td name="id">${variant.getProductVariantId()}</td>
                                                <td>${product.getName()}</td>
                                                <td name="color">${variant.getColor()}</td>
                                                <td name="size">${variant.getSize()}</td>
                                                <td name="quantity">${variant.getQuantity()}</td>
                                                <td class="d-flex justify-content-center">
                                                    <button type="button" class="btn btn-primary"
                                                            data-toggle="modal" data-target="#editProductModal"
                                                            onclick="editProductModal(this)">Edit</button>
                                                    <button type="button" class="btn btn-danger" 
                                                            data-toggle="modal" data-target="#delete-product-modal"
                                                            onclick="deleteProductModal(${variant.getProductVariantId()})">Delete</button>
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


            <!-- Modal -->
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModal" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addBookModalLabel">Add</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="addProductForm" action="variants?pId=${product.getProductId()}&&action=add" method="post">
                            <!--Color-->
                            <div class="form-group">
                                <label for="color">Color: </label>
                                <div class="input-group">
                                    <select class="custom-select" id="color" name="color">
                                        <option selected value="White">White</option>
                                        <option value="Cream">Cream</option>
                                        <option value="Black">Black</option>
                                        <option value="Gray">Gray</option>
                                        <option value="Pink">Pink</option>
                                        <option value="Red">Red</option>
                                        <option value="Orange">Orange</option>
                                        <option value="Beige">Beige</option>
                                        <option value="Brown">Brown</option>
                                        <option value="Yellow">Yellow</option>
                                        <option value="Moss Green">Moss Green</option>
                                        <option value="Green">Green</option>
                                        <option value="Mint">Mint</option>
                                        <option value="Navy">Navy</option>
                                        <option value="Purple">Purple</option>
                                    </select>
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button">Color</button>
                                    </div>
                                </div>
                            </div>
                            <!--Size-->
                            <div class="form-group">
                                <label for="size">Size: </label>
                                <div class="input-group">
                                    <select class="custom-select" id="size" name="size">
                                        <option selected="" value="S">S</option>
                                        <option value="M">M</option>
                                        <option value="L">L</option>
                                        <option value="XL">XL</option>
                                    </select>
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button">Size</button>
                                    </div>
                                </div>
                            </div>
                            <!--Quantity-->
                            <div class="form-group">
                                <label for="quantity">Quantity:</label>
                                <input type="text" class="form-control" id="quantity" name="quantity">
                                <div id="quantityError" class="error"></div>
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
                        <h5 class="modal-title" id="">Edit Variant</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="editModalForm" action="variants?action=update" method="POST" >
                            <div class="form-group" style="display: none">
                                <input type="text" class="form-control" id="idEditInput" name="vId">
                            </div>
                            <!--Color-->
                            <div class="form-group">
                                <label for="category">Color: </label>
                                <div class="input-group">
                                    <select class="custom-select" id="colorEditInput" name="color">
                                        <option selected value="White">White</option>
                                        <option value="Cream">Cream</option>
                                        <option value="Black">Black</option>
                                        <option value="Gray">Gray</option>
                                        <option value="Pink">Pink</option>
                                        <option value="Red">Red</option>
                                        <option value="Orange">Orange</option>
                                        <option value="Beige">Beige</option>
                                        <option value="Brown">Brown</option>
                                        <option value="Yellow">Yellow</option>
                                        <option value="Moss Green">Moss Green</option>
                                        <option value="Green">Green</option>
                                        <option value="Mint">Mint</option>
                                        <option value="Navy">Navy</option>
                                        <option value="Purple">Purple</option>
                                    </select>
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button">Color</button>
                                    </div>
                                </div>
                            </div>
                            <!--Size-->
                            <div class="form-group">
                                <label for="category">Size: </label>
                                <div class="input-group">
                                    <select class="custom-select" id="sizeEditInput" name="size">
                                        <option selected="" value="S">S</option>
                                        <option value="M">M</option>
                                        <option value="L">L</option>
                                        <option value="XL">XL</option>
                                    </select>
                                    <div class="input-group-append">
                                        <button class="btn btn-outline-secondary" type="button">Size</button>
                                    </div>
                                </div>
                            </div>
                            <!--Quantity -->
                            <div class="form-group">
                                <label for="quantity">Quantity:</label>
                                <input type="text" class="form-control" id="quantityEditInput" name="quantity">
                                <div id="quantityEditError" class="error"></div>
                            </div>
                            <div class="form-group" hidden="">
                                <input type="text" name="pId" value="${product.getProductId()}"/>
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
                        <p>Are you sure you want to delete this variant?</p>
                    </div>
                    <div class="modal-footer">
                        <form action="variants?action=delete" method="POST">
                            <div class="form-group" style="display: none">
                                <input type="text" class="form-control" id="idDeleteInput" name="vId">
                            </div>
                            <input type="hidden" class="form-control" name="pId" value="${product.getProductId()}">
                            <button type="submit" class="btn btn-danger">Yes</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                        </form>
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
            let quantity = $('#quantity').val();

            //xoá thông báo lỗi hiện tại
            $('.error').html('');

            if (quantity.trim() === '') {
                $('#quantityError').html('Quantity cannot be empty!');
            } else if (!$.isNumeric(quantity) || parseFloat(quantity) < 0) {
                $('#quantityError').html('Invalid quantity');
            }

            // Kiểm tra nếu không có lỗi thì submit form
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

        function validateForm2() {
            let quantity = $('#quantityEditInput').val();

            $('.error').html('');

            if (quantity.trim() === '') {
                $('#quantityEditError').html('Quantity cannot be empty');
            } else if (!$.isNumeric(quantity) || parseFloat(quantity) < 0) {
                $('#quantityEditError').html('Invalid quantity');
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

        function editProductModal(button) {
            let id = $(button).closest('tr').find('td[name="id"]').text().trim();
            let colorText = $(button).closest('tr').find('td[name="color"]').text().trim();
            let sizeText = $(button).closest('tr').find('td[name="size"]').text().trim();
            let quantity = $(button).closest('tr').find('td[name="quantity"]').text().trim();

            $('#idEditInput').val(id);
            $('#quantityEditInput').val(quantity);

            $('#colorEditInput option').each(function () {
                if ($(this).text() === colorText) {
                    $(this).prop('selected', true);
                }
            });
            $('#sizeEditInput option').each(function () {
                if ($(this).text() === sizeText) {
                    $(this).prop('selected', true);
                }
            });
        }

        function deleteProductModal(id) {
            let inputId = document.querySelector("#idDeleteInput");
            inputId.value = id;
        }

        //Display Error
        $(document).ready(function () {
        <c:if test="${notification != null}">
            $('#notiModal').modal('show');
        </c:if>
        });

    </script>

</html>