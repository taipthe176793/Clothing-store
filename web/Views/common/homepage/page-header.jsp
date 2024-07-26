<%-- 
    Document   : page-header
    Created on : May 21, 2024, 8:48:54 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- Header -->
<header>
    <!-- Header desktop -->
    <div class="container-menu-desktop mb-5 pb-5">
        <!-- Topbar -->
        <div class="top-bar">
            <div class="content-topbar flex-sb-m h-full container">
                <div class="left-top-bar">
                    
                </div>

                <div class="right-top-bar flex-w h-full">

                    <c:set var="cookie" value="${pageContext.request.cookies}"></c:set>

                    <c:if test="${cookie.__d.value eq null}">
                        <a href="${pageContext.request.contextPath}/auth?action=login" class="flex-c-m trans-04 p-lr-25">
                            Login
                        </a>
                            <a href="${pageContext.request.contextPath}/auth?action=signup" class="flex-c-m trans-04 p-lr-25">
                            Register
                        </a>
                    </c:if>

                    <c:if test="${cookie.__d.value ne null}">
                        <a href="${pageContext.request.contextPath}/customer/profile?action=view" class="flex-c-m trans-04 p-lr-25">
                            My Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/auth?action=logout" class="flex-c-m trans-04 p-lr-25">
                            Logout
                        </a>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="wrap-menu-desktop">
            <nav class="limiter-menu-desktop container">

                <!-- Logo desktop -->
                <a href="${pageContext.request.contextPath}/home" class="logo">
                    <img src="${pageContext.request.contextPath}/images/icons/logo-01.jpg" alt="IMG-LOGO">
                </a>

                <!-- Menu desktop -->
                <div class="menu-desktop">
                    <ul class="main-menu">
                        <li class="active-menu">
                            <a href="${pageContext.request.contextPath}/home">Home</a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/shop">Shop</a>
                        </li>


                        <li>
                            <a href="${pageContext.request.contextPath}/blogs">Blog</a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/about">About</a>
                        </li>

                        <li>
                            <a href="${pageContext.request.contextPath}/contact">Contact</a>
                        </li>
                    </ul>
                </div>

                <!-- Icon header -->
                <div class="wrap-icon-header flex-w flex-r-m">

                    <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-cart <c:if test="${cookie.__c.value ne 'ccovzFT40cE5PzFXDMD/eQ=='}"> icon-header-noti</c:if>" 
                         data-notify="${cookie.__i.value.trim() eq "" ? "" : cookie.__i.value}">
                        <i onclick="location.href = '${pageContext.request.contextPath}/cart'" class="zmdi zmdi-shopping-cart"></i>
                    </div>

                    <a href="${pageContext.request.contextPath}/customer/wishlist" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti-wishlist" >
                        <i class="zmdi zmdi-favorite-outline"></i>
                    </a>
                </div>
            </nav>
        </div>
    </div>

</header>
