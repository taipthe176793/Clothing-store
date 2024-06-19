<%-- 
    Document   : wishlist
    Created on : 16 thg 6, 2024, 03:59:36
    Author     : caoqu
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Wishlist</title>
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/icons/favicon.png" />
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/bootstrap/css/bootstrap.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/iconic/css/material-design-iconic-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/fonts/linearicons-v1.0.0/icon-font.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animate/animate.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/css-hamburgers/hamburgers.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/animsition/css/animsition.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/select2/select2.min.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/util.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/wishlist.css">
    </head>
    <body>
        <jsp:include page="common/homepage/page-header.jsp"></jsp:include>
            <!-- Wishlist content -->
            <div class="container">
                <h1>Your Wishlist</h1>
            <c:choose>
                <c:when test="${empty favoriteProducts}">
                    <p>No products in wishlist.</p>
                </c:when>
                <c:otherwise>
                    <div class="table-wishlist">
                        <table class="table table-bordered table-hover">
                            <thead class="thead-light">
                                <tr>
                                    <th scope="col" width="45%">Product Name</th>
                                    <th scope="col" width="15%">Unit Price</th>
                                    <th scope="col" width="15%">Total Quantity</th>
                                    <th scope="col" width="15%">Status1</th>
                                    <th scope="col" width="15%">Status2</th>
                                    <th scope="col" width="10%"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${favoriteProducts}" var="product">
                                    <tr>
                                        <td>
                                            <div class="display-flex align-center">
                                                <div class="img-product">
                                                    <img src="${product.getImg1()}" style="height: 100px; width: auto;" alt="Product Image">
                                                </div>
                                                <div class="name-product">
                                                    <a href="${pageContext.request.contextPath}/product?id=${product.getProductId()}" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">${product.getName()}</a>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="price">$${product.getPrice()}</td>
                                        <td>
                                            <c:set var="totalQuantity" value="0"/>
                                            <c:forEach items="${product.variantList}" var="variant">
                                                <c:set var="totalQuantity" value="${totalQuantity + variant.quantity}"/>
                                            </c:forEach>
                                            ${totalQuantity}
                                        </td>                                      
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.variantList}">
                                                    <c:set var="inStock" value="false" />
                                                    <c:forEach items="${product.variantList}" var="variant">
                                                        <c:if test="${variant.quantity > 0}">
                                                            <c:set var="inStock" value="true" />
                                                        </c:if>
                                                    </c:forEach>
                                                    <c:choose>
                                                        <c:when test="${inStock}">
                                                            <span class="in-stock-box">In Stock</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="in-stock-box">Sold out</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="in-stock-box">Sold out</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <<td>
                                            ${product.isIsDelete() ? "Inactive" : "Active"}
                                        </td>

                                        <td>
                                            <form action="${pageContext.request.contextPath}/customer/wishlist" method="post">
                                                <input type="hidden" name="productId" value="${product.getProductId()}">
                                                <input type="hidden" name="action" value="remove">
                                                <button type="submit" class="btn btn-danger btn-sm">
                                                    <i class="far fa-trash-alt"></i> Remove
                                                </button>
                                            </form>

                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <jsp:include page="./common/homepage/page-footer.jsp"></jsp:include>
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
        <script src="${pageContext.request.contextPath}/js/main.js"></script>
    </body>
</html>

