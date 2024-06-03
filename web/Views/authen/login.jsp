<%-- 
    Document   : login
    Created on : May 22, 2024, 12:00:23 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Play:wght@400;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/fonts/material-design-iconic-font/css/material-design-iconic-font.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/authentication.css">
        <style>
            body {
                font-family: 'Play', sans-serif;
            }
            h3 {
                font-weight: 700;
            }
            .form-control {
                font-weight: 400;
            }
            .form-wrapper i {
                font-weight: 500;
            }
        </style>
    </head>
    <body>
        <div class="wrapper" style="background-image: url('${pageContext.request.contextPath}/images/login/bg-registration-form.jpg');">
            <div class="inner">
                <div class="image-holder">
                    <img src="${pageContext.request.contextPath}/images/login/registration-form.jpg" alt>
                </div>
                <form id="loginForm" action="auth?action=login" method="post" onsubmit="return validateLoginForm()" novalidate>
                    <h3>Login</h3>
                    <div class="form-wrapper">
                        <input name="user" type="text" placeholder="Username or Email" class="form-control" required>
                        <i class="zmdi zmdi-account"></i>
                    </div>
                    <div class="form-wrapper">
                        <input name="pass" type="password" placeholder="Password" class="form-control" required>
                        <i class="zmdi zmdi-lock"></i>
                    </div>
                    <div> <a style="text-decoration: none" href="auth?action=resetPass">Forget password?</a></div>
                    <div style="color: red; margin-top: 10px;">${error}</div>
                    <button type="submit">Login
                        <i class="zmdi zmdi-arrow-right"></i>
                    </button>
                    <!-- or login by google -->
                    <div class="signup-link">Don't have an account yet? <a style="text-decoration: none" href="auth?action=signup">Sign Up Now</a></div>
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
                    function validateLoginForm() {
                        var usernameOrEmailPattern = /^(?!.*\s).+$/;
                        var passwordPattern = /^(?!.*\s).{8,}$/;

                        var form = document.forms["loginForm"];
                        var usernameOrEmail = form["user"];
                        var password = form["pass"];

                        var isValid = true;

                        if (!usernameOrEmailPattern.test(usernameOrEmail.value)) {
                            usernameOrEmail.setCustomValidity("Username or Email must not contain spaces.");
                            isValid = false;
                        } else {
                            usernameOrEmail.setCustomValidity("");
                        }

                        if (!passwordPattern.test(password.value)) {
                            password.setCustomValidity("Password must be at least 8 characters without spaces.");
                            isValid = false;
                        } else {
                            password.setCustomValidity("");
                        }

                        if (!isValid) {
                            form.reportValidity();
                        }

                        return isValid;
                    }
        </script>
    </body>
</html>
