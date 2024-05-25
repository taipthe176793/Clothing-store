<%-- 
    Document   : signup
    Created on : May 22, 2024, 12:00:35 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/authentication.css">
    </head>
    <body>
        <div class="wrapper" style="background-image: url('${pageContext.request.contextPath}/images/signup/auth-bg-l.jpg');">
            <div class="inner">
                <div class="image-holder">
                    <img src="${pageContext.request.contextPath}/images/signup/auth-bg-s.jpg" style="height: 90%; margin-top: 20px" alt>
                </div>
                <form id="signupForm" action="auth?action=signup" method="post" onsubmit="return validateForm()">
                    <h3>Sign Up</h3>
                    <div class="form-wrapper">
                        <input name="fullname" type="text" placeholder="Full Name" class="form-control" required>
                    </div>
                    <div class="form-wrapper">
                        <input name="user" type="text" placeholder="Username" class="form-control" pattern=".{6,}$" required>
                        <i class="zmdi zmdi-account"></i>
                    </div>
                    <div class="form-wrapper">
                        <input name="email" type="email" placeholder="Email Address" class="form-control" required>
                        <i class="zmdi zmdi-email"></i>
                    </div>
                    <div class="form-wrapper">
                        <input name="phone" type="text" placeholder="Phone Number" class="form-control" pattern="^0\d{9}$"  required>
                    </div>
                    <div class="form-wrapper">
                        <input name="pass" type="password" placeholder="Password" class="form-control" pattern="^.{8,}$"  required>
                        <i class="zmdi zmdi-lock"></i>
                    </div>
                    <div class="form-wrapper">
                        <input name="confirm-pass" type="password" placeholder="Confirm Password" class="form-control" required>
                        <i class="zmdi zmdi-lock"></i>
                    </div>
                    ${error}
                    ${Success}
                    <button type="submit" style="margin-bottom: 10px;">Register
                        <i class="zmdi zmdi-arrow-right"></i>
                    </button>
                    <div style="text-align: center;">Or you can sign in <a href="auth?action=login">Here</a></div>
                </form>
            </div>
        </div>

        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
        <script>
            window.dataLayer = window.dataLayer || [];

            function gtag() {
                dataLayer.push(arguments);
            }
            gtag('js', new Date());

            gtag('config', 'UA-23581568-13');
        </script>
        <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vedd3670a3b1c4e178fdfb0cc912d969e1713874337387" integrity="sha512-EzCudv2gYygrCcVhu65FkAxclf3mYM6BCwiGUm6BEuLzSb5ulVhgokzCZED7yMIkzYVg65mxfIBNdNra5ZFNyQ==" data-cf-beacon='{"rayId":"88761a3dfc270ebd","version":"2024.4.1","token":"cd0b4b3a733644fc843ef0b185f98241"}'
        crossorigin="anonymous"></script>
        
        <script>
            function validateForm() {
                var usernamePattern = /^.{6,}$/;
                var phonePattern = /^0\d{9}$/;
                var passwordPattern = /^.{8,}$/;
                
                var username = doccument.form["signupForm"]["user"].value;
                var phone = document.forms["signupForm"]["phone"].value;
                var password = document.forms["signupForm"]["pass"].value;
                
                if(!usernamePattern.test(user)){
                    alert("Username must be at least 6 characters")
                    return false;
                }

                if (!phonePattern.test(phone)) {
                    alert("Phone number must be 10 digits and start with 0.");
                    return false;
                }

                if (!passwordPattern.test(password)) {
                    alert("Password must be at least 8 characters.");
                    return false;
                }

                return true;
            }
        </script>
    </body>
</html>
