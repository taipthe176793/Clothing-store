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
    </head>

    <body>

        <jsp:include page="common/homepage/page-header.jsp"></jsp:include>

           
        <!-- Title page -->
        <section class="bg-img1 txt-center p-lr-15 p-tb-92" style="background-image: url('${pageContext.request.contextPath}/images/blog/bg-02.jpg');">
            <h2 class="ltext-105 cl0 txt-center">
                Blog
            </h2>
        </section>


        <!-- Content page -->
        <section class="bg0 p-t-62 p-b-60">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 col-lg-12 p-b-80">
                        <div class="p-r-45 p-r-0-lg">
                            
                            <!-- item blog -->
                            <c:forEach items="${blogs}" var="i">
                                <div class="p-b-63">
                                <a href="blog-detail?id=${i.blogId}" class="hov-img0 how-pos5-parent">
                                    <img src="${i.image}" alt="IMG-BLOG">
                                </a>

                                <div class="p-t-32">
                                    <h4 class="p-b-15">
                                        <a href="blog-detail?id=${i.blogId}" class="ltext-108 cl2 hov-cl1 trans-04">
                                            ${i.title}
                                        </a>
                                    </h4>

                                    <p class="stext-117 cl6">
                                          
                                    <div class="flex-w flex-sb-m p-t-18">
                                    

                                        <a href="blog-detail?id=${i.blogId}" class="stext-101 cl2 hov-cl1 trans-04 m-tb-10">
                                            Continue Reading

                                            <i class="fa fa-long-arrow-right m-l-9"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            </c:forEach>
                           

                            <!-- Pagination -->
                            
                        </div>
                    </div>

                    <div class="col-md-4 col-lg-3 p-b-80">
                        
                    </div>
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

    </body>

</html>
