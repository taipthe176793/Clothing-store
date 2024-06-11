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
        <title>Sign in</title>
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
                    <h3>Sign In</h3>
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
                    <div style="text-align: center; margin: 10px 0;">Or</div>
                    <button onclick="location.href='https://accounts.google.com/o/oauth2/auth?scope=email%20profile%20openid&redirect_uri=http://localhost:8080/SWP391_SE1817/auth?action=loginWithGoogle&response_type=code&client_id=927392698257-i0te23e7qorb6jr5upat4d8ae26ih03f.apps.googleusercontent.com&approval_prompt=force'" class="gsi-material-button">
                        <div class="gsi-material-button-state"></div>
                        <div class="gsi-material-button-content-wrapper">
                            <div class="gsi-material-button-icon">
                                <svg version="1.1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 48 48" xmlns:xlink="http://www.w3.org/1999/xlink" style="display: block;">
                                <path fill="#EA4335" d="M24 9.5c3.54 0 6.71 1.22 9.21 3.6l6.85-6.85C35.9 2.38 30.47 0 24 0 14.62 0 6.51 5.38 2.56 13.22l7.98 6.19C12.43 13.72 17.74 9.5 24 9.5z"></path>
                                <path fill="#4285F4" d="M46.98 24.55c0-1.57-.15-3.09-.38-4.55H24v9.02h12.94c-.58 2.96-2.26 5.48-4.78 7.18l7.73 6c4.51-4.18 7.09-10.36 7.09-17.65z"></path>
                                <path fill="#FBBC05" d="M10.53 28.59c-.48-1.45-.76-2.99-.76-4.59s.27-3.14.76-4.59l-7.98-6.19C.92 16.46 0 20.12 0 24c0 3.88.92 7.54 2.56 10.78l7.97-6.19z"></path>
                                <path fill="#34A853" d="M24 48c6.48 0 11.93-2.13 15.89-5.81l-7.73-6c-2.15 1.45-4.92 2.3-8.16 2.3-6.26 0-11.57-4.22-13.47-9.91l-7.98 6.19C6.51 42.62 14.62 48 24 48z"></path>
                                <path fill="none" d="M0 0h48v48H0z"></path>
                                </svg>
                            </div>
                            <span class="gsi-material-button-contents">Continue with Google</span>
                            <span style="display: none;">Continue with Google</span>
                        </div>
                    </button>
                    <!<!-- signup -->
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
                        
                        if (!usernameOrEmailPattern.test(usernameOrEmail.value) || usernameOrEmail.value.trim() === "") {
                            usernameOrEmail.setCustomValidity("Username or Email must not contain spaces.");
                            isValid = false;
                        } else {
                            usernameOrEmail.setCustomValidity("");
                        }
                        
                        if (!passwordPattern.test(password.value) || password.value.trim() === "") {
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
