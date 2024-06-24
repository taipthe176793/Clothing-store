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
                <form id="signupForm" action="auth?action=signup" method="post" onsubmit="return validateForm()" novalidate>
                    <h3>Sign Up</h3>
                    <div class="form-wrapper">
                        <label>Full Name *</label>
                        <input name="fullname" type="text"  class="form-control" required>
                    </div>
                    <div class="form-wrapper">
                        <label>Username *</label>
                        <input name="user" type="text"  class="form-control" required>
                        <i class="zmdi zmdi-account"></i>
                    </div>

                    <div class="form-wrapper">
                        <label>Email Address *</label>
                        <input name="email" type="email" class="form-control" required>
                        <i class="zmdi zmdi-email"></i>
                    </div>
                    <div class="form-wrapper">
                        <label>Phone Number *</label>
                        <input name="phone" type="text" class="form-control" required>
                    </div>
                    <div class="form-wrapper">
                        <label>Password *</label>
                        <input name="pass" type="password"  class="form-control" required>
                        <i class="zmdi zmdi-lock"></i>
                    </div>
                    <div class="form-wrapper">
                        <lable>Confirm Password *</lable>
                        <input name="confirm-pass" type="password"  class="form-control" required>
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
        <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vedd3670a3b1c4e178fdfb0cc912d969e1713874337387" integrity="sha512-EzCudv2gYygrCcVhu65FkAxclf3mYM6BCwiGUm6BEuLzSb5ulVhgokzCZED7yMIkzYVg65mxfIBNdNra5ZFNyQ==" data-cf-beacon='{"rayId":"88761a3dfc270ebd","version":"2024.4.1","token":"cd0b4b3a733644fc843ef0b185f98241"}' crossorigin="anonymous"></script>

        <script>
                    function validateForm() {
                        let usernamePattern = /^(?!.*\s).{6,}$/;
                        let phonePattern = /^(?!.*\s)0\d{9}$/;
                        let passwordPattern = /^(?!.*\s).{8,}$/;
                        let emailPattern = /^[^@]+@[^@]+\.[^@]+$/;

                        let form = document.forms["signupForm"];
                        let username = form["user"];
                        let phone = form["phone"];
                        let password = form["pass"];
                        let fullname = form["fullname"];
                        let email = form["email"];

                        let isValid = true;
                        if (fullname.value.trim() === "") {
                            fullname.setCustomValidity("Fullname cannot be empty!!!");
                            isValid = false;
                        }
                        if (!usernamePattern.test(username.value) || username.value.trim() === "") {
                            username.setCustomValidity("Username must be at least 6 characters without spaces.");
                            isValid = false;
                        } else {
                            username.setCustomValidity("");
                        }

                        if (!phonePattern.test(phone.value) || phone.value.trim() === "") {
                            phone.setCustomValidity("Phone number must be 10 digits and start with 0 without spaces.");
                            isValid = false;
                        } else {
                            phone.setCustomValidity("");
                        }

                        if (!passwordPattern.test(password.value) || password.value.trim() === "") {
                            password.setCustomValidity("Password must be at least 8 characters without spaces.");
                            isValid = false;
                        } else {
                            password.setCustomValidity("");
                        }
                        if (!emailPattern.test(email.value)) {
                            email.setCustomValidity("Please enter a valid email address.");
                            isValid = false;
                        } else {
                            email.setCustomValidity("");
                        }

                        if (!isValid) {
                            form.reportValidity();
                        }

                        return isValid;
                    }
        </script>
         <script>
                    function validateForm() {
                        let usernamePattern = /^(?!.*\s).{6,}$/;
                        let phonePattern = /^(?!.*\s)0\d{9}$/;
                        let passwordPattern = /^(?!.*\s).{8,}$/;
                        let emailPattern = /^[^@]+@[^@]+\.[^@]+$/;

                        let form = document.forms["signupForm"];
                        let username = form["user"];
                        let phone = form["phone"];
                        let password = form["pass"];
                        let fullname = form["fullname"];
                        let email = form["email"];
                        let confirmPassword = form["confirm-pass"];

                        let isValid = true;

                        // Reset custom validity messages
                        fullname.setCustomValidity("");
                        username.setCustomValidity("");
                        phone.setCustomValidity("");
                        password.setCustomValidity("");
                        email.setCustomValidity("");
                        confirmPassword.setCustomValidity("");

                        // Validate Fullname
                        if (fullname.value.trim() === "") {
                            fullname.setCustomValidity("Fullname cannot be empty!!!");
                            isValid = false;
                        }

                        // Validate Username
                        if (!usernamePattern.test(username.value)) {
                            username.setCustomValidity("Username must be at least 6 characters without spaces.");
                            isValid = false;
                        }

                        // Validate Phone
                        if (!phonePattern.test(phone.value)) {
                            phone.setCustomValidity("Phone number must be 10 digits and start with 0 without spaces.");
                            isValid = false;
                        }

                        // Validate Password
                        if (!passwordPattern.test(password.value)) {
                            password.setCustomValidity("Password must be at least 8 characters without spaces.");
                            isValid = false;
                        }

                        // Validate Confirm Password
                        if (password.value !== confirmPassword.value) {
                            confirmPassword.setCustomValidity("Confirm Password not match.");
                            isValid = false;
                        }

                        // Validate Email
                        if (!emailPattern.test(email.value)) {
                            email.setCustomValidity("Please enter a valid email address.");
                            isValid = false;
                        }

                        if (!isValid) {
                            form.reportValidity();
                        }

                        return isValid;
                    }
        </script>
    </body>
</html>
