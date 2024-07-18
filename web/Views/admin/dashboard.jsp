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
        <title>Dashboard</title>
        <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no" name="viewport" />

        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" />
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/light-bootstrap-dashboard.css?v=2.0.1" rel="stylesheet" />
        <link href="${pageContext.request.contextPath}/css/demo.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <style>
            .chart-container {
                position: relative;
                height: 300px;
            }

            .info-card {
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .info-card .card-body {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .info-card .card-body-icon {
                font-size: 2.5rem;
                opacity: 0.5;
            }

            .info-card .card-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .breadcrumb {
                background-color: rgba(0, 0, 0, 0);
            }

            .pie-chart-container {
                display: flex;
                justify-content: center;
                align-items: center;
            }
        </style>
    </head>

    <body>

        <div class="wrapper">

            <jsp:include page="../common/admin/side-bar.jsp"></jsp:include>

                <div class="main-panel">

                <jsp:include page="../common/admin/header.jsp"></jsp:include>

                    <div class="content">
                        <div class="container-fluid">

                            <div class="row">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="dashboard">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item active">Overview</li>
                                </ol>
                            </div>

                            <div class="row">
                                <div class="col-xl-3 col-sm-6 mb-3">
                                    <div class="card info-card text-white bg-info o-hidden h-100">

                                        <div class="card-body">
                                            <div>
                                                <p>Revenue Growth</p>
                                                <h3>${revenueGrowth}%</h3>
                                        </div>
                                        <div class="card-body-icon">
                                            <i class="fa-solid fa-chart-line"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 mb-3">
                                <div class="card info-card text-white bg-success o-hidden h-100">
                                    <div class="card-body">
                                        <div>
                                            <p>Total Sales</p>
                                            <h3>$${salesThisMonth}</h3>
                                        </div>
                                        <div class="card-body-icon">
                                            <i class="fa-solid fa-dollar-sign"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 mb-3">
                                <div class="card info-card text-white bg-warning o-hidden h-100">
                                    <div class="card-body">
                                        <div>
                                            <p>Total Orders</p>
                                            <h3>${orders} orders</h3>
                                        </div>
                                        <div class="card-body-icon">
                                            <i class="fa-solid fa-file-invoice"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-sm-6 mb-3">
                                <div class="card info-card text-white bg-secondary o-hidden h-100">
                                    <div class="card-body">
                                        <div>
                                            <p>New Blogs</p>
                                            <h3>${noOfBlogs} ${noOfBlogs > 1 ? "blogs" : "blog"}</h3>
                                        </div>
                                        <div class="card-body-icon">
                                            <i class="fa-regular fa-newspaper"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mt-3 ">
                            <div class="col-md-6">
                                <div class="card" style="padding-bottom: 21px">
                                    <div class="card-body">
                                        <form id="filter-date" action="dashboard" method="post">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h4 style="padding: 0; margin: 0">Total Revenue</h4>
                                                </div>
                                                <div class="mb-3 d-flex" style="width: 50%">
                                                    <select name="year" class="form-control mr-1" id="yearFilter" onchange="filterData()">
                                                        <option value="2024" <c:if test="${year == 2024 && year ne null}">selected</c:if>>2024</option>
                                                        <option value="2023" <c:if test="${year == 2023 && year ne null}">selected</c:if>>2023</option>
                                                        </select>
                                                        <select name="month" class="form-control" id="monthFilter" onchange="filterData()">
                                                            <option value="0" <c:if test="${month == 0 && month ne null}">selected</c:if>>All Month</option>
                                                        <option value="1" <c:if test="${month == 1 && month ne null}">selected</c:if>>January</option>
                                                        <option value="2" <c:if test="${month == 2 && month ne null}">selected</c:if>>February</option>
                                                        <option value="3" <c:if test="${month == 3 && month ne null}">selected</c:if>>March</option>
                                                        <option value="4" <c:if test="${month == 4 && month ne null}">selected</c:if>>April</option>
                                                        <option value="5" <c:if test="${month == 5 && month ne null}">selected</c:if>>May</option>
                                                        <option value="6" <c:if test="${month == 6 && month ne null}">selected</c:if>>June</option>
                                                        <option value="7" <c:if test="${month == 7 && month ne null}">selected</c:if>>July</option>
                                                        <option value="8" <c:if test="${month == 8 && month ne null}">selected</c:if>>August</option>
                                                        <option value="9" <c:if test="${month == 9 && month ne null}">selected</c:if>>September</option>
                                                        <option value="10" <c:if test="${month == 10 && month ne null}">selected</c:if>>October</option>
                                                        <option value="11" <c:if test="${month == 11 && month ne null}">selected</c:if>>November</option>
                                                        <option value="12" <c:if test="${month == 12 && month ne null}">selected</c:if>>December</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </form>

                                            <div class="chart-container">
                                                <canvas id="revenueChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="card">
                                        <div class="card-header">
                                            <h4 class="card-title">Revenue by Category</h4>
                                            <hr />
                                        </div>
                                        <div class="card-body pie-chart-container">
                                            <div class="chart-container">
                                                <canvas id="productPieChart"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                <jsp:include page="../common/admin/footer.jsp"></jsp:include>
                </div>
            </div>

            <script src="${pageContext.request.contextPath}/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/core/popper.min.js" type="text/javascript"></script>
        <script src="${pageContext.request.contextPath}/js/core/bootstrap.min.js" type="text/javascript"></script>

        <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-switch.js"></script>
        <script src="${pageContext.request.contextPath}/js/plugins/jquery.sharrre.js"></script>

        <script src="${pageContext.request.contextPath}/js/plugins/bootstrap-notify.js"></script>

        <script src="${pageContext.request.contextPath}/js/light-bootstrap-dashboard.js?v=2.0.1" type="text/javascript"></script>

        <script src="${pageContext.request.contextPath}/js/demo.js"></script>
        <script type="text/javascript">
                                                            let revenuesData = ${revenues};
                                                            let labelsData = JSON.parse('${labelsData}');
                                                            let pieChartLabels = JSON.parse('${pieChartLabels}');
                                                            let pieChartRevenues = ${pieChartRevenues};
                                                            let yearFilter = ${year ne null ? year : 2024};
                                                            let monthFilter = ${month ne null ? month : 0};

                                                            let currentDate = new Date();
                                                            let currentMonth = currentDate.getMonth() + 1;
                                                            let currentDay = currentDate.getDate() + 1;
                                                            let currentYear = currentDate.getFullYear();
                                                            if (yearFilter === currentYear && currentMonth > monthFilter) {
                                                                revenuesData = revenuesData.slice(0, currentMonth);
                                                            }

                                                            const ctxLine = document.getElementById('revenueChart').getContext('2d');
                                                            const revenueChart = new Chart(ctxLine, {
                                                                type: 'line',
                                                                data: {
                                                                    labels: labelsData,
                                                                    datasets: [{
                                                                            label: 'Total Revenue',
                                                                            data: revenuesData,
                                                                            backgroundColor: 'rgba(54, 162, 235, 0.2)',
                                                                            borderColor: 'rgba(54, 162, 235, 1)',
                                                                            borderWidth: 1,
                                                                            fill: true,
                                                                        }]
                                                                },
                                                                options: {
                                                                    responsive: true,
                                                                    scales: {
                                                                        y: {
                                                                            beginAtZero: true,
                                                                            ticks: {
                                                                                callback: function (value, index, values) {
                                                                                    return '$' + value.toLocaleString();
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            });

                                                            const ctxPie = document.getElementById('productPieChart').getContext('2d');
                                                            const productPieChart = new Chart(ctxPie, {
                                                                type: 'pie',
                                                                data: {
                                                                    labels: pieChartLabels,
                                                                    datasets: [{
                                                                            label: 'Revenue by Category',
                                                                            data: pieChartRevenues,
                                                                            backgroundColor: [
                                                                                'rgba(255, 99, 132, 0.2)',
                                                                                'rgba(54, 162, 235, 0.2)',
                                                                                'rgba(255, 206, 86, 0.2)',
                                                                                'rgba(75, 192, 192, 0.2)',
                                                                                'rgba(153, 102, 255, 0.2)',
                                                                                'rgba(255, 159, 64, 0.2)',
                                                                                'rgba(199, 199, 199, 0.2)',
                                                                                'rgba(83, 102, 255, 0.2)'
                                                                            ],
                                                                            borderColor: [
                                                                                'rgba(255, 99, 132, 1)',
                                                                                'rgba(54, 162, 235, 1)',
                                                                                'rgba(255, 206, 86, 1)',
                                                                                'rgba(75, 192, 192, 1)',
                                                                                'rgba(153, 102, 255, 1)',
                                                                                'rgba(255, 159, 64, 1)',
                                                                                'rgba(199, 199, 199, 1)',
                                                                                'rgba(83, 102, 255, 1)'
                                                                            ],
                                                                            borderWidth: 1,
                                                                        }]
                                                                },
                                                                options: {
                                                                    responsive: true,
                                                                    plugins: {
                                                                        legend: {
                                                                            position: 'right',
                                                                            labels: {
                                                                                font: {
                                                                                    size: 14
                                                                                },
                                                                                color: '#333'
                                                                            }
                                                                        },
                                                                        tooltip: {
                                                                            callbacks: {
                                                                                label: function (context) {
                                                                                    let label = context.label || '';
                                                                                    if (label) {
                                                                                        label += ': ';
                                                                                    }
                                                                                    label += '$' + context.raw.toLocaleString();
                                                                                    return label;
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            });

                                                            function filterData() {
                                                                document.querySelector('#filter-date').submit();
                                                            }
        </script>

    </body>

</html>
