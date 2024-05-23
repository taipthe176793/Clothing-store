<%-- 
    Document   : dashboard
    Created on : May 23, 2024, 12:52:52 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8" />
        <link rel="apple-touch-icon" sizes="76x76" href="${pageContext.request.contextPath}/images/apple-icon.png">
        <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Light Bootstrap Dashboard - Free Bootstrap 4 Admin Template by Creative Tim</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" name="viewport" />

        <link rel="canonical" href="#/product/light-bootstrap-dashboard">

        <meta name="keywords" content="creative tim, html dashboard, html css dashboard, web dashboard, freebie, free bootstrap dashboard, bootstrap, css3 dashboard, bootstrap admin, light bootstrap dashboard, frontend, responsive bootstrap dashboard, bootstrap 4 admin, bootstrap 4 template, bootstrap 4 dashboard, bootstrap 4, free bootstrap 4">
        <meta name="description" content="A bootstrap 4 admin dashboard template designed to be simple and beautiful.">

        <meta itemprop="name" content="Light Bootstrap Dashboard - Free Bootstrap 4 Admin Template by Creative Tim">
        <meta itemprop="description" content="A bootstrap 4 admin dashboard template designed to be simple and beautiful.">
        <meta itemprop="image" content="https://s3.amazonaws.com/creativetim_bucket/products/32/original/opt_lbd_thumbnail.jpg">

        <meta name="twitter:card" content="product">
        <meta name="twitter:site" content="@creativetim">
        <meta name="twitter:title" content="Light Bootstrap Dashboard - Free Bootstrap 4 Admin Template by Creative Tim">
        <meta name="twitter:description" content="A bootstrap 4 admin dashboard template designed to be simple and beautiful.">
        <meta name="twitter:creator" content="@creativetim">
        <meta name="twitter:image" content="https://s3.amazonaws.com/creativetim_bucket/products/32/original/opt_lbd_thumbnail.jpg">
        <meta name="twitter:data1" content="Light Bootstrap Dashboard - Free Bootstrap 4 Admin Template by Creative Tim">
        <meta name="twitter:label1" content="Product Type">
        <meta name="twitter:data2" content="Free">
        <meta name="twitter:label2" content="Price">

        <meta property="fb:app_id" content="655968634437471">
        <meta property="og:title" content="Light Bootstrap Dashboard - Free Bootstrap 4 Admin Template by Creative Tim">
        <meta property="og:type" content="article">
        <meta property="og:url" content="https://demos.creative-tim.com/light-bootstrap-dashboard/dashboard">
        <meta property="og:image" content="https://s3.amazonaws.com/creativetim_bucket/products/32/original/opt_lbd_thumbnail.jpg">
        <meta property="og:description" content="A bootstrap 4 admin dashboard template designed to be simple and beautiful.">
        <meta property="og:site_name" content="Creative Tim">

        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />

        <link href="${pageContext.request.contextPath}/css/demo.css" rel="stylesheet" />

        <script>
            (function (w, d, s, l, i) {
                w[l] = w[l] || [];
                w[l].push({
                    'gtm.start': new Date().getTime(),
                    event: 'gtm.js'
                });
                var f = d.getElementsByTagName(s)[0],
                        j = d.createElement(s),
                        dl = l != 'dataLayer' ? '&l=' + l : '';
                j.async = true;
                j.src =
                        'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
                f.parentNode.insertBefore(j, f);
            })(window, document, 'script', 'dataLayer', 'GTM-NKDMSK6');
        </script>

    </head>

    <body>

        <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NKDMSK6"
                          height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>

        <div class="wrapper">
            <div class="sidebar" data-image="${pageContext.request.contextPath}/images/sidebar-5.jpg">

                <div class="sidebar-wrapper">
                    <div class="logo">
                        <a href="#" class="simple-text">
                            Creative Tim
                        </a>
                    </div>
                    <ul class="nav">
                        <li class="nav-item active">
                            <a class="nav-link" href="dashboard.html">
                                <i class="nc-icon nc-chart-pie-35"></i>
                                <p>Dashboard</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="./user.html">
                                <i class="nc-icon nc-circle-09"></i>
                                <p>User Profile</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="./table.html">
                                <i class="nc-icon nc-notes"></i>
                                <p>Table List</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="./typography.html">
                                <i class="nc-icon nc-paper-2"></i>
                                <p>Typography</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="./icons.html">
                                <i class="nc-icon nc-atom"></i>
                                <p>Icons</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="./maps.html">
                                <i class="nc-icon nc-pin-3"></i>
                                <p>Maps</p>
                            </a>
                        </li>
                        <li>
                            <a class="nav-link" href="./notifications.html">
                                <i class="nc-icon nc-bell-55"></i>
                                <p>Notifications</p>
                            </a>
                        </li>
                        <li class="nav-item active active-pro">
                            <a class="nav-link active" href="upgrade.html">
                                <i class="nc-icon nc-alien-33"></i>
                                <p>Upgrade to PRO</p>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="main-panel">

                <nav class="navbar navbar-expand-lg " color-on-scroll="500">
                    <div class=" container-fluid  ">
                        <a class="navbar-brand" href="#pablo"> Dashboard </a>
                        <button href class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" aria-controls="navigation-index" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                            <span class="navbar-toggler-bar burger-lines"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-end" id="navigation">
                            <ul class="nav navbar-nav mr-auto">
                                <li class="nav-item">
                                    <a href="#" class="nav-link" data-toggle="dropdown">
                                        <i class="nc-icon nc-palette"></i>
                                        <span class="d-lg-none">Dashboard</span>
                                    </a>
                                </li>
                                <li class="dropdown nav-item">
                                    <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                        <i class="nc-icon nc-planet"></i>
                                        <span class="notification">5</span>
                                        <span class="d-lg-none">Notification</span>
                                    </a>
                                    <ul class="dropdown-menu">
                                        <a class="dropdown-item" href="#">Notification 1</a>
                                        <a class="dropdown-item" href="#">Notification 2</a>
                                        <a class="dropdown-item" href="#">Notification 3</a>
                                        <a class="dropdown-item" href="#">Notification 4</a>
                                        <a class="dropdown-item" href="#">Another notification</a>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a href="#" class="nav-link">
                                        <i class="nc-icon nc-zoom-split"></i>
                                        <span class="d-lg-block">&nbsp;Search</span>
                                    </a>
                                </li>
                            </ul>
                            <ul class="navbar-nav ml-auto">
                                <li class="nav-item">
                                    <a class="nav-link" href="#pablo">
                                        <span class="no-icon">Account</span>
                                    </a>
                                </li>
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="https://example.com" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        <span class="no-icon">Dropdown</span>
                                    </a>
                                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                                        <a class="dropdown-item" href="#">Action</a>
                                        <a class="dropdown-item" href="#">Another action</a>
                                        <a class="dropdown-item" href="#">Something</a>
                                        <a class="dropdown-item" href="#">Something else here</a>
                                        <div class="divider"></div>
                                        <a class="dropdown-item" href="#">Separated link</a>
                                    </div>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="../auth?action=logout">
                                        <span class="no-icon">Log out</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>

                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="card ">
                                    <div class="card-header ">
                                        <h4 class="card-title">Email Statistics</h4>
                                        <p class="card-category">Last Campaign Performance</p>
                                    </div>
                                    <div class="card-body ">
                                        <div id="chartPreferences" class="ct-chart ct-perfect-fourth"></div>
                                    </div>
                                    <div class="card-footer ">
                                        <div class="legend">
                                            <i class="fa fa-circle text-info"></i> Open
                                            <i class="fa fa-circle text-danger"></i> Bounce
                                            <i class="fa fa-circle text-warning"></i> Unsubscribe
                                        </div>
                                        <hr>
                                        <div class="stats">
                                            <i class="fa fa-clock-o"></i> Campaign sent 2 days ago
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-8">
                                <div class="card ">
                                    <div class="card-header ">
                                        <h4 class="card-title">Users Behavior</h4>
                                        <p class="card-category">24 Hours performance</p>
                                    </div>
                                    <div class="card-body ">
                                        <div id="chartHours" class="ct-chart"></div>
                                    </div>
                                    <div class="card-footer ">
                                        <div class="legend">
                                            <i class="fa fa-circle text-info"></i> Open
                                            <i class="fa fa-circle text-danger"></i> Click
                                            <i class="fa fa-circle text-warning"></i> Click Second Time
                                        </div>
                                        <hr>
                                        <div class="stats">
                                            <i class="fa fa-history"></i> Updated 3 minutes ago
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="card ">
                                    <div class="card-header ">
                                        <h4 class="card-title">2017 Sales</h4>
                                        <p class="card-category">All products including Taxes</p>
                                    </div>
                                    <div class="card-body ">
                                        <div id="chartActivity" class="ct-chart"></div>
                                    </div>
                                    <div class="card-footer ">
                                        <div class="legend">
                                            <i class="fa fa-circle text-info"></i> Tesla Model S
                                            <i class="fa fa-circle text-danger"></i> BMW 5 Series
                                        </div>
                                        <hr>
                                        <div class="stats">
                                            <i class="fa fa-check"></i> Data information certified
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card  card-tasks">
                                    <div class="card-header ">
                                        <h4 class="card-title">Tasks</h4>
                                        <p class="card-category">Backend development</p>
                                    </div>
                                    <div class="card-body ">
                                        <div class="table-full-width">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check">
                                                                <label class="form-check-label">
                                                                    <input class="form-check-input" type="checkbox" value>
                                                                    <span class="form-check-sign"></span>
                                                                </label>
                                                            </div>
                                                        </td>
                                                        <td>Sign contract for "What are conference organizers afraid of?"</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                <i class="fa fa-edit"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check">
                                                                <label class="form-check-label">
                                                                    <input class="form-check-input" type="checkbox" value checked>
                                                                    <span class="form-check-sign"></span>
                                                                </label>
                                                            </div>
                                                        </td>
                                                        <td>Lines From Great Russian Literature? Or E-mails From My Boss?</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                <i class="fa fa-edit"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check">
                                                                <label class="form-check-label">
                                                                    <input class="form-check-input" type="checkbox" value checked>
                                                                    <span class="form-check-sign"></span>
                                                                </label>
                                                            </div>
                                                        </td>
                                                        <td>Flooded: One year later, assessing what was lost and what was found when a ravaging rain swept through metro Detroit
                                                        </td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                <i class="fa fa-edit"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check">
                                                                <label class="form-check-label">
                                                                    <input class="form-check-input" type="checkbox" checked>
                                                                    <span class="form-check-sign"></span>
                                                                </label>
                                                            </div>
                                                        </td>
                                                        <td>Create 4 Invisible User Experiences you Never Knew About</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                <i class="fa fa-edit"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check">
                                                                <label class="form-check-label">
                                                                    <input class="form-check-input" type="checkbox" value>
                                                                    <span class="form-check-sign"></span>
                                                                </label>
                                                            </div>
                                                        </td>
                                                        <td>Read "Following makes Medium better"</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                <i class="fa fa-edit"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <div class="form-check">
                                                                <label class="form-check-label">
                                                                    <input class="form-check-input" type="checkbox" value disabled>
                                                                    <span class="form-check-sign"></span>
                                                                </label>
                                                            </div>
                                                        </td>
                                                        <td>Unfollow 5 enemies from twitter</td>
                                                        <td class="td-actions text-right">
                                                            <button type="button" rel="tooltip" title="Edit Task" class="btn btn-info btn-simple btn-link">
                                                                <i class="fa fa-edit"></i>
                                                            </button>
                                                            <button type="button" rel="tooltip" title="Remove" class="btn btn-danger btn-simple btn-link">
                                                                <i class="fa fa-times"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <div class="card-footer ">
                                        <hr>
                                        <div class="stats">
                                            <i class="now-ui-icons loader_refresh spin"></i> Updated 3 minutes ago
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <footer class="footer">
                    <div class="container">
                        <nav>
                            <ul class="footer-menu">
                                <li>
                                    <a href="#">
                                        Home
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Company
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Portfolio
                                    </a>
                                </li>
                                <li>
                                    <a href="#">
                                        Blog
                                    </a>
                                </li>
                            </ul>
                            <p class="copyright text-center">
                                ©
                                <script>
                                    document.write(new Date().getFullYear())
                                </script>
                                <a href="#">Creative Tim</a>, made with love for a better web
                            </p>
                        </nav>
                    </div>
                </footer>
            </div>
        </div>
        <script>
            // Facebook Pixel Code Don't Delete
            !function (f, b, e, v, n, t, s) {
                if (f.fbq)
                    return;
                n = f.fbq = function () {
                    n.callMethod ?
                            n.callMethod.apply(n, arguments) : n.queue.push(arguments)
                };
                if (!f._fbq)
                    f._fbq = n;
                n.push = n;
                n.loaded = !0;
                n.version = '2.0';
                n.queue = [];
                t = b.createElement(e);
                t.async = !0;
                t.src = v;
                s = b.getElementsByTagName(e)[0];
                s.parentNode.insertBefore(t, s)
            }(window,
                    document, 'script', '//connect.facebook.net/en_US/fbevents.js');

            try {
                fbq('init', '111649226022273');
                fbq('track', "PageView");

            } catch (err) {
                console.log('Facebook Track Error:', err);
            }
        </script>
        <noscript>
        <images height="1" width="1" style="display:none"
             src="https://www.facebook.com/tr?id=111649226022273&ev=PageView&noscript=1"
             />
        </noscript>
        <script defer src="https://static.cloudflareinsights.com/beacon.min.js/vedd3670a3b1c4e178fdfb0cc912d969e1713874337387" integrity="sha512-EzCudv2gYygrCcVhu65FkAxclf3mYM6BCwiGUm6BEuLzSb5ulVhgokzCZED7yMIkzYVg65mxfIBNdNra5ZFNyQ==" data-cf-beacon='{"rayId":"885a446abb508591","version":"2024.4.1","token":"1b7cbb72744b40c580f8633c6b62637e"}'
        crossorigin="anonymous"></script>
    </body>

    <script src="${pageContext.request.contextPath}/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/core/popper.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/core/bootstrap.min.js" type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-switch.js"></script>

    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB2Yno10-YTnLjjn_Vtk0V8cdcY5lC4plU"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/chartist.min.js"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/jquery.sharrre.js"></script>

    <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-notify.js"></script>

    <script src="${pageContext.request.contextPath}/js/light-bootstrap-dashboard.js?v=2.0.1" type="text/javascript"></script>

    <script src="${pageContext.request.contextPath}/js/demo.js"></script>
    <script type="text/javascript">
            $(document).ready(function () {
                // Javascript method's body can be found in assets/js/demos.js
                demo.initDashboardPageCharts();

                demo.showNotification();

            });
    </script>

</html>
