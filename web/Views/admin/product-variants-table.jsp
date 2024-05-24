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
        <title>Light Bootstrap Dashboard - Free Bootstrap 4 Admin Template by Creative Tim</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" name="viewport" />

        <link rel="canonical" href="https://www.creative-tim.com/product/light-bootstrap-dashboard">

        <meta name="keywords" content="creative tim, html dashboard, html css dashboard, web dashboard, freebie, free bootstrap dashboard, bootstrap, css3 dashboard, bootstrap admin, light bootstrap dashboard, frontend, responsive bootstrap dashboard, bootstrap 4 admin, bootstrap 4 template, bootstrap 4 dashboard, bootstrap 4, free bootstrap 4">
        <meta name="description" content="A bootstrap 4 admin dashboard template designed to be simple and beautiful.">

        <meta itemprop="name" content="Light Bootstrap Dashboard - Free Bootstrap 4 Admin Template by Creative Tim">
        <meta itemprop="description" content="A bootstrap 4 admin dashboard template designed to be simple and beautiful.">
        <meta itemprop="image" content="https://s3.amazonaws.com/creativetim_bucket/products/32/original/opt_lbd_thumbnail.jpg">

        <meta name="twitter:card" content="product">
        <meta name="twitter:site" content="@creativetim">
        <meta name="twitter:title" content="Light Bootstrap Dashboard - Free Bootstrap 4 Admin Template by Creative Tim">
        <meta name="twitter:description" content="A bootstrap 4 admin dashboard template designed to be simple and beautiful.">
        <meta name="twitter:creator" content="@creativetim">
        <meta name="twitter:image" content="https://s3.amazonaws.com/creativetim_bucket/products/32/original/opt_lbd_thumbnail.jpg">
        <meta name="twitter:data1" content="Light Bootstrap Dashboard - Free Bootstrap 4 Admin Template by Creative Tim">
        <meta name="twitter:label1" content="Product Type">
        <meta name="twitter:data2" content="Free">
        <meta name="twitter:label2" content="Price">

        <meta property="fb:app_id" content="655968634437471">
        <meta property="og:title" content="Light Bootstrap Dashboard - Free Bootstrap 4 Admin Template by Creative Tim">
        <meta property="og:type" content="article">
        <meta property="og:url" content="https://demos.creative-tim.com/light-bootstrap-dashboard/dashboard">
        <meta property="og:image" content="https://s3.amazonaws.com/creativetim_bucket/products/32/original/opt_lbd_thumbnail.jpg">
        <meta property="og:description" content="A bootstrap 4 admin dashboard template designed to be simple and beautiful.">
        <meta property="og:site_name" content="Creative Tim">

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
                                                <th>Action</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <c:forEach items="${variantsList}" var="variant">
                                            <tr>
                                                <td>${variant.getProductVariantId()}</td>
                                                <td>${product.getName()}</td>
                                                <td>${variant.getColor()}</td>
                                                <td>${variant.getSize()}</td>
                                                <td>${variant.getQuantity()}</td>
                                                <td >
                                                    <form action="" method="post">
                                                        <button class="btn btn-primary">Update</button>
                                                    </form>
                                                </td>
                                                <td>
                                                    <form action="" method="post">
                                                        <button class="btn btn-danger">Delete</button>
                                                    </form>
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

        <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vedd3670a3b1c4e178fdfb0cc912d969e1713874337387" integrity="sha512-EzCudv2gYygrCcVhu65FkAxclf3mYM6BCwiGUm6BEuLzSb5ulVhgokzCZED7yMIkzYVg65mxfIBNdNra5ZFNyQ==" data-cf-beacon='{"rayId":"885a481028a48591","version":"2024.4.1","token":"1b7cbb72744b40c580f8633c6b62637e"}'
        crossorigin="anonymous"></script>
    </body>

    <script src="${pageContext.request.contextPath}/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/core/popper.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/core/bootstrap.min.js" type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-switch.js"></script>

    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB2Yno10-YTnLjjn_Vtk0V8cdcY5lC4plU"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/chartist.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/jquery.sharrre.js"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-notify.js"></script>

    <script src="${pageContext.request.contextPath}/js/light-bootstrap-dashboard.js?v=2.0.1" type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/js/demo.js"></script>



    <script src="${pageContext.request.contextPath}/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/vendor/chart.js/Chart.min.js"></script>
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
                            function validateForm() {
                                let quantity = $('#quantity').val();

                                //xoá thông báo lỗi hiện tại
                                $('.error').html('');

                                if (quantity === '') {
                                    $('#quantityError').html('Quantity cannot be empty!');
                                } else if (!$.isNumeric(quantity) || parseFloat(quantity) < 0) {
                                    $('#quantityError').html('Quantity must greater than 0');
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


    </script>

</html>