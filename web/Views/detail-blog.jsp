<%-- 
    Document   : blog
    Created on : May 19, 2024, 3:17:18 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Blog</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!--===============================================================================================-->
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
        <!--===============================================================================================-->
        <style>
            textarea {
                width: 100%;
                height: auto; /* Allows height to adjust based on content */
                min-height: 100px; /* Optional: Sets a minimum height */
                overflow: hidden; /* Hides the scrollbar, as height will adjust dynamically */
                white-space: pre-wrap; /* Ensures that text wraps correctly */
                box-sizing: border-box; /* Ensures padding and border are included in the element's total width and height */
                padding: 10px; /* Adds padding inside the textarea */
            }
        </style>

    </head>

    <body>

        <jsp:include page="common/homepage/page-header.jsp"></jsp:include>


            <!-- Title page -->
            <section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('${pageContext.request.contextPath}/images/blog/bg-02.jpg');">
            <h2 class="ltext-105 cl0 txt-center">
                Blog  detail
            </h2>
        </section>


        <!-- Content page -->
        <section class="bg0 p-t-62 p-b-30">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <h2 class="mt-4">${blog.title}</h2>
                        <img src="${blog.image}" class="img-fluid mt-3">

                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-12">
                        <textarea readonly>${blog.body}</textarea>
                        <p><strong>Created At:</strong> ${blog.createdAt}</p>
                    </div>
                </div>
                    <div class="text-center">
                        <button class="btn btn-secondary mt-5" onclick="location.href='blogs'">Back to Blog list</button>
                    </div>
            </div>
        </section>

        <jsp:include page="common/homepage/page-footer.jsp"></jsp:include>


            <!-- Back to top -->
            <div class="btn-back-to-top" id="myBtn">
                <span class="symbol-btn-back-to-top">
                    <i class="zmdi zmdi-chevron-up"></i>
                </span>
            </div>

            <!--===============================================================================================-->
            <script src="${pageContext.request.contextPath}/vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/popper.js"></script>
        <script src="${pageContext.request.contextPath}/vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/select2/select2.min.js"></script>
        <script>
            $(".js-select2").each(function () {
                $(this).select2({
                    minimumResultsForSearch: 20,
                    dropdownParent: $(this).next('.dropDownSelect2')
                });
            })
        </script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
        <script>
            $('.js-pscroll').each(function () {
                $(this).css('position', 'relative');
                $(this).css('overflow', 'hidden');
                var ps = new PerfectScrollbar(this, {
                    wheelSpeed: 1,
                    scrollingThreshold: 1000,
                    wheelPropagation: false,
                });

                $(window).on('resize', function () {
                    ps.update();
                })
            });
        </script>
        <!--===============================================================================================-->
        <script src="${pageContext.request.contextPath}/js/main.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var textareas = document.querySelectorAll('textarea');

                textareas.forEach(function (textarea) {
                    function adjustHeight() {
                        textarea.style.height = 'auto'; // Reset height to auto
                        textarea.style.height = (textarea.scrollHeight) + 'px'; // Set height to scrollHeight
                    }

                    textarea.addEventListener('input', adjustHeight); // Adjust height on input
                    adjustHeight(); // Adjust height on page load
                });
            });
        </script>


    </body>

</html>
