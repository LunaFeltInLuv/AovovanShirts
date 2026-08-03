<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${empty pageTitle ? 'Áo Vớ Vẩn - Thời Trang Độc Lạ' : pageTitle}" /></title>
    
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/vendors/bootstrap-icons/bootstrap-icons.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/css/app.css' />">
</head>
<body class="client-layout d-flex flex-column min-vh-100">
    <header class="site-header bg-dark text-white sticky-top py-2 shadow">
        <div class="container d-flex justify-content-between align-items-center">
            <a class="navbar-brand text-warning fw-bold fs-3" href="<c:url value='/home' />">
                <i class="bi bi-shop me-2"></i>ÁO VỚ VẦN
            </a>

            <nav class="nav nav-pills">
                <a class="nav-link text-white ${activePage eq 'home' ? 'active bg-warning text-dark font-weight-bold' : ''}" href="<c:url value='/home' />">Trang chủ</a>
                <a class="nav-link text-white ${activePage eq 'products' ? 'active bg-warning text-dark font-weight-bold' : ''}" href="<c:url value='/products' />">Sản phẩm</a>
                
                <c:if test="${not empty sessionScope.user}">
                    <a class="nav-link text-white ${activePage eq 'cart' ? 'active bg-warning text-dark font-weight-bold' : ''}" href="<c:url value='/cart' />">
                        <i class="bi bi-cart4"></i> Giỏ hàng
                    </a>
                    <a class="nav-link text-white ${activePage eq 'orders' ? 'active bg-warning text-dark font-weight-bold' : ''}" href="<c:url value='/orders' />">Đơn hàng</a>
                </c:if>
            </nav>

            <div class="auth-buttons">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <span class="me-2 text-info">Xin chào, <strong><c:out value="${sessionScope.user.name}"/></strong></span>
                        <a class="btn btn-outline-light btn-sm me-1" href="<c:url value='/admin/products' />"><i class="bi bi-speedometer2"></i> Quản trị</a>
                        <a class="btn btn-danger btn-sm" href="<c:url value='/logout' />"><i class="bi bi-box-arrow-right"></i> Thoát</a>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-outline-warning btn-sm me-2" href="<c:url value='/login' />">Đăng nhập</a>
                        <a class="btn btn-warning btn-sm" href="<c:url value='/register' />">Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>

    <main class="site-main flex-grow-1 py-4 bg-light">
        <jsp:include page="${contentPage}" />
    </main>

    <footer class="site-footer bg-dark text-white py-3 mt-auto">
        <div class="container text-center">
            <p class="mb-0">© 2026 <strong>Áo Vớ Vẩn</strong> - Thương Hiệu Thời Trang Độc Lạ. All rights reserved.</p>
        </div>
    </footer>

    <script src="<c:url value='/assets/js/bootstrap.bundle.min.js' />"></script>
    <script src="<c:url value='/assets/js/app.js' />"></script>
</body>
</html>
