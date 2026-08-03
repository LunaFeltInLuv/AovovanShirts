<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${empty pageTitle ? 'Quản trị - Áo Vớ Vẩn' : pageTitle}" /></title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/vendors/bootstrap-icons/bootstrap-icons.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/css/app.css' />">
</head>

<body>
    <div id="app">
        <div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="logo">
                            <a href="<c:url value='/admin/products' />" class="text-warning font-weight-bold h4 text-decoration-none">
                                <i class="bi bi-shield-lock me-1"></i>VỚ VẦN ADMIN
                            </a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">Menu Quản trị</li>

                        <li class="sidebar-item ${activePage eq 'products' ? 'active' : ''}">
                            <a href="<c:url value='/admin/products' />" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>Quản lý sản phẩm</span>
                            </a>
                        </li>

                        <li class="sidebar-item ${activePage eq 'users' ? 'active' : ''}">
                            <a href="<c:url value='/admin/users' />" class='sidebar-link'>
                                <i class="bi bi-people-fill"></i>
                                <span>Quản lý người dùng</span>
                            </a>
                        </li>

                        <li class="sidebar-item ${activePage eq 'orders' ? 'active' : ''}">
                            <a href="<c:url value='/admin/orders' />" class='sidebar-link'>
                                <i class="bi bi-file-earmark-spreadsheet-fill"></i>
                                <span>Quản lý đơn hàng</span>
                            </a>
                        </li>

                        <li class="sidebar-title">Hệ thống</li>

                        <li class="sidebar-item">
                            <a href="<c:url value='/home' />" class='sidebar-link text-info'>
                                <i class="bi bi-house-door"></i>
                                <span>Về trang chủ Client</span>
                            </a>
                        </li>
                        <li class="sidebar-item">
                            <a href="<c:url value='/logout' />" class='sidebar-link text-danger'>
                                <i class="bi bi-box-arrow-right"></i>
                                <span>Đăng xuất</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="main">
            <header class="mb-3">
                <nav class="navbar navbar-expand navbar-light bg-light py-2 px-3 shadow-sm rounded">
                    <div class="container-fluid justify-content-between">
                        <span class="navbar-text font-weight-bold">
                            Hệ thống Quản Trị Áo Vớ Vẩn
                        </span>
                        <div>
                            <span class="me-3">Tài khoản: <strong><c:out value="${sessionScope.user.name}"/></strong></span>
                        </div>
                    </div>
                </nav>
            </header>

            <div class="page-heading">
                <h3><c:out value="${pageTitle}" /></h3>
            </div>

            <div class="page-content">
                <jsp:include page="${contentPage}" />
            </div>

            <footer class="mt-4">
                <div class="footer clearfix mb-0 text-muted">
                    <div class="float-start">
                        <p>2026 &copy; Áo Vớ Vẩn Admin Dashboard</p>
                    </div>
                </div>
            </footer>
        </div>
    </div>

    <script src="<c:url value='/assets/js/app.js' />"></script>
</body>
</html>
