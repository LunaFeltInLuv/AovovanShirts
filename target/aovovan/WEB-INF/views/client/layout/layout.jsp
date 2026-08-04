<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><c:out value="${empty pageTitle ? 'Áo Vớ Vẩn - Thời Trang Độc Lạ' : pageTitle}" /></title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/vendors/bootstrap-icons/bootstrap-icons.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/css/app.css' />">
    <style>
        body {
            font-family: 'Nunito', 'Montserrat', sans-serif;
            background-color: #FAFAF9;
            color: #0C0A09;
        }
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
        }
        .site-header {
            background-color: #1C1917 !important;
            border-bottom: 2px solid #A16207;
        }
        .nav-link {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }
        .nav-link:hover {
            color: #A16207 !important;
        }
        .nav-link.active {
            background-color: #A16207 !important;
            color: #FFFFFF !important;
            border-radius: 4px;
        }
        .text-warning {
            color: #A16207 !important;
        }
        .btn-warning {
            background-color: #A16207 !important;
            border-color: #A16207 !important;
            color: #FFFFFF !important;
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-warning:hover {
            background-color: #854d0e !important;
            border-color: #854d0e !important;
            color: #FFFFFF !important;
            box-shadow: 0 4px 10px rgba(161, 98, 7, 0.3);
        }
        .card {
            border-radius: 12px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08) !important;
        }
        .site-footer {
            background-color: #1C1917 !important;
            border-top: 1px solid #2e2a27;
            font-size: 0.9rem;
        }
    </style>
</head>
<body class="client-layout d-flex flex-column min-vh-100">
    <header class="site-header navbar navbar-expand-lg navbar-dark sticky-top py-3 shadow-sm">
        <div class="container">
            <a class="navbar-brand text-warning fw-bold fs-3 d-flex align-items-center" href="<c:url value='/home' />">
                <i class="bi bi-shop me-2"></i>ÁO VỚ VẦN
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#clientNavbar" aria-controls="clientNavbar" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="clientNavbar">
                <nav class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4 gap-2">
                    <a class="nav-link text-white px-3 ${activePage eq 'home' ? 'active' : ''}" href="<c:url value='/home' />">Trang chủ</a>
                    <a class="nav-link text-white px-3 ${activePage eq 'products' ? 'active' : ''}" href="<c:url value='/products' />">Sản phẩm</a>
                    <c:if test="${not empty sessionScope.user}">
                        <a class="nav-link text-white px-3 ${activePage eq 'cart' ? 'active' : ''}" href="<c:url value='/cart' />">
                            <i class="bi bi-cart4 me-1"></i> Giỏ hàng
                        </a>
                        <a class="nav-link text-white px-3 ${activePage eq 'orders' ? 'active' : ''}" href="<c:url value='/orders' />">Đơn hàng</a>
                    </c:if>
                </nav>
                <div class="d-flex align-items-center gap-3">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <span class="text-white-50 small">Xin chào, <strong class="text-white"><c:out value="${sessionScope.user.name}"/></strong></span>
                            <c:if test="${sessionScope.isAdmin eq true}">
                                <a class="btn btn-outline-light btn-sm font-semibold" href="<c:url value='/admin/products' />"><i class="bi bi-speedometer2 me-1"></i> Quản trị</a>
                            </c:if>
                            <a class="btn btn-danger btn-sm font-semibold" href="<c:url value='/logout' />"><i class="bi bi-box-arrow-right me-1"></i> Thoát</a>
                        </c:when>
                        <c:otherwise>
                            <a class="btn btn-outline-warning btn-sm font-semibold px-3" href="<c:url value='/login' />">Đăng nhập</a>
                            <a class="btn btn-warning btn-sm font-semibold px-3" href="<c:url value='/register' />">Đăng ký</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </header>

    <main class="site-main flex-grow-1 py-5">
        <jsp:include page="${contentPage}" />
    </main>

    <footer class="site-footer text-white-50 py-4 mt-auto">
        <div class="container text-center">
            <p class="mb-0">© 2026 <strong class="text-white">Áo Vớ Vẩn</strong> - Thương Hiệu Thời Trang Độc Lạ. All rights reserved.</p>
        </div>
    </footer>

    <!-- Toast Notification Container -->
    <div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 1090;">
        <div id="cartToast" class="toast align-items-center text-white bg-dark border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body d-flex align-items-center py-3 fs-6 font-semibold">
                    <i id="toastIcon" class="bi bi-check-circle-fill text-warning me-2 fs-5"></i>
                    <span id="toastMessage">Đã thêm sản phẩm vào giỏ hàng thành công!</span>
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>

    <script src="<c:url value='/assets/js/bootstrap.bundle.min.js' />"></script>
    <script src="<c:url value='/assets/js/app.js' />"></script>
    <script>
        function showToast(message, isSuccess = true) {
            const toastEl = document.getElementById('cartToast');
            const toastMsg = document.getElementById('toastMessage');
            const toastIcon = document.getElementById('toastIcon');

            if (toastMsg) toastMsg.textContent = message;
            if (toastIcon) {
                toastIcon.className = isSuccess 
                    ? 'bi bi-check-circle-fill text-warning me-2 fs-5' 
                    : 'bi bi-exclamation-triangle-fill text-danger me-2 fs-5';
            }

            if (toastEl && window.bootstrap) {
                const toast = new bootstrap.Toast(toastEl, { delay: 3500 });
                toast.show();
            }
        }

        document.addEventListener('submit', function(e) {
            const form = e.target;
            if (form && form.getAttribute('action') && form.getAttribute('action').includes('/cart/add')) {
                e.preventDefault();
                const formData = new URLSearchParams(new FormData(form));

                fetch(form.action, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                        'X-Requested-With': 'XMLHttpRequest'
                    },
                    body: formData.toString()
                })
                .then(res => {
                    if (res.redirected && res.url.includes('/login')) {
                        window.location.href = res.url;
                        return null;
                    }
                    return res.json();
                })
                .then(data => {
                    if (data) {
                        showToast(data.message || 'Đã thêm sản phẩm vào giỏ hàng!', data.success);
                    }
                })
                .catch(err => {
                    console.error(err);
                    showToast('Đã thêm sản phẩm vào giỏ hàng thành công!', true);
                });
            }
        });
    </script>
</body>
</html>
