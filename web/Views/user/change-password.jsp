<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Profile Template</title>
        <link rel="stylesheet" href="profile.css">
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
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/daterangepicker/daterangepicker.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/slick/slick.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/MagnificPopup/magnific-popup.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/vendor/perfect-scrollbar/perfect-scrollbar.css">
        <!--===============================================================================================-->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/util.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    </head>

    <body>
        <jsp:include page="../common/homepage/page-header.jsp"></jsp:include>

            <div class="container">
                <div class="card mt-5">
                    <div class="card-header">
                        <h3>Change Password</h3>
                    </div>
                    <div class="card-body">
                    <% String message = (String) request.getAttribute("message"); %>
                    <% if (message != null) { %>
                    <div class="alert alert-warning"><%= message %></div>
                    <% } %>
                    <form action="${pageContext.request.contextPath}/customer/change-password" method="post">
                        <div class="form-group">
                            <label class="form-label">Current password</label>
                            <input name="current_password" type="password" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">New password</label>
                            <input id="new_password" name="new_password" type="password" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Repeat new password</label>
                            <input id="repeat_new_password" name="repeat_new_password" type="password" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-dark">Change Password</button>
                        <a href="${pageContext.request.contextPath}/customer/profile?action=view" class="btn btn-default">Cancel</a>

                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="../common/homepage/page-footer.jsp"></jsp:include>
            <script data-cfasync="false" src="/cdn-cgi/scripts/5c5dd728/cloudflare-static/email-decode.min.js"></script>
            <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
            <script type="text/javascript">

            </script>
        </body>
        <script src="${pageContext.request.contextPath}/vendor/slick/slick.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/slick-custom.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</html>
