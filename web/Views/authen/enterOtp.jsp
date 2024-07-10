<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Enter OTP</title>
    <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css' rel='stylesheet'>
    <link href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css' rel='stylesheet'>
    <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <style>
        body {
            background-color: #eee;
            color: #505050;
            font-family: "Rubik", Helvetica, Arial, sans-serif;
            font-size: 14px;
            font-weight: normal;
            line-height: 1.5;
            text-transform: none;
        }
        .container {
            background-color: #eee;
            padding: 12px;
            border: none;
        }
        .placeicon {
            font-family: fontawesome;
        }
        .custom-control-label::before {
            background-color: #dee2e6;
            border: #dee2e6;
        }
        .btn {
            font-size: 13px;
        }
        .form-control:focus {
            color: #495057;
            background-color: #fff;
            border-color: #76b7e9;
            outline: 0;
            box-shadow: 0 0 0 0px #28a745;
        }
        .text-primary {
            color: #007bff !important;
        }
        .padding-bottom-3x {
            padding-bottom: 12px !important;
        }
        .form-container {
            padding: 12px;
            background-color: #fff;
        }
        .btn-info {
            background-color: #28a745;
            border-color: #28a745;
        }
        .btn-info:hover {
            background-color: #218838;
            border-color: #1e7e34;
        }
        .bg-light {
            background-color: #fff;
        }
        .footer-section {
            margin-top: 12px;
        }
    </style>
</head>
<body oncontextmenu='return false' class='snippet-body'>

    <div class="container padding-bottom-3x mb-2 mt-5">
        <div class="row justify-content-center">
            <div class="col-12 col-md-9 col-lg-7 col-xl-6 mt-5">
                <div class="form-container bg-white rounded mt-2 mb-2 px-0">
                    <div class="row justify-content-center align-items-center pt-3">
                        <h1><strong>Enter OTP</strong></h1>
                    </div>
                    <div class="pt-3 pb-3">
                        <form class="form-horizontal" action="auth?action=validateOtp" method="POST" onsubmit="return validateForm()">
                            <div class="form-group row justify-content-center px-3">
                                <div class="col-9 px-0">
                                    <input type="text" name="otp" placeholder="&#xf084; &nbsp; Enter OTP" class="form-control border-info placeicon">
                                </div>
                            </div>
                            <div class="form-group row justify-content-center">
                                <div class="col-3 px-3 mt-3">
                                    <input type="submit" value="Verify OTP" class="btn btn-block btn-info">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="mx-0 px-0 bg-light">
                        <div class="px-4 pt-5">
                            <hr>
                        </div>
                        <div class="pt-2">
                            <div class="row justify-content-center">
                                <h5>Don't have an Account?<span><a href="auth?action=signup" class="text-primary"> Register Now!</a></span></h5>
                            </div>
                            <div class="row justify-content-center align-items-center pt-4 pb-5">
                                <div class="col-4"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type='text/javascript' src='https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js'></script>
</body>
</html>
