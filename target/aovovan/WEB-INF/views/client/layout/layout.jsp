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
            background-color: #F8FAFC;
            color: #0F172A;
        }
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            color: #0F172A;
        }
        
        /* Modern Minimalist Header Bar */
        .site-header {
            background-color: #0F172A !important;
            border-bottom: 2px solid #64748B;
            height: auto !important;
            min-height: 70px;
            box-shadow: 0 4px 12px rgba(15, 23, 42, 0.15);
            transition: all 0.2s ease;
        }
        .nav-link {
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            font-size: 0.95rem;
            letter-spacing: 0.5px;
            transition: all 0.2s ease;
            color: #F8FAFC !important;
        }
        .nav-link:hover {
            color: #CBD5E1 !important;
        }
        .nav-link.active {
            background-color: #475569 !important;
            color: #FFFFFF !important;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(71, 85, 105, 0.35);
        }
        .text-warning {
            color: #CBD5E1 !important;
        }

        /* Solid Color Buttons with Light Drop Shadows */
        .btn {
            border-radius: 8px;
            font-family: 'Montserrat', sans-serif;
            font-weight: 600;
            transition: transform 0.15s ease, box-shadow 0.15s ease, background-color 0.15s ease;
        }
        .btn:hover {
            transform: translateY(-1px);
        }
        .btn:active {
            transform: translateY(0);
        }

        /* Primary Button: Solid Smoky Gray */
        .btn-warning {
            background-color: #475569 !important;
            border-color: #475569 !important;
            color: #FFFFFF !important;
            box-shadow: 0 2px 6px rgba(71, 85, 105, 0.28) !important;
        }
        .btn-warning:hover {
            background-color: #334155 !important;
            border-color: #334155 !important;
            color: #FFFFFF !important;
            box-shadow: 0 4px 12px rgba(51, 65, 85, 0.35) !important;
        }

        /* Secondary Outline Button: Solid White with Smoky Gray Border */
        .btn-outline-warning {
            background-color: #FFFFFF !important;
            border: 1.5px solid #64748B !important;
            color: #475569 !important;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.05) !important;
        }
        .btn-outline-warning:hover {
            background-color: #F1F5F9 !important;
            border-color: #334155 !important;
            color: #0F172A !important;
            box-shadow: 0 3px 8px rgba(71, 85, 105, 0.2) !important;
        }

        /* Danger Button: Solid Red */
        .btn-danger {
            background-color: #DC2626 !important;
            border-color: #DC2626 !important;
            color: #FFFFFF !important;
            box-shadow: 0 2px 6px rgba(220, 38, 38, 0.28) !important;
        }
        .btn-danger:hover {
            background-color: #B91C1C !important;
            border-color: #B91C1C !important;
            box-shadow: 0 4px 12px rgba(185, 28, 28, 0.35) !important;
        }

        .btn-outline-light {
            background-color: rgba(255, 255, 255, 0.1) !important;
            border: 1px solid rgba(255, 255, 255, 0.3) !important;
            color: #FFFFFF !important;
            box-shadow: 0 1px 4px rgba(0, 0, 0, 0.1) !important;
        }
        .btn-outline-light:hover {
            background-color: rgba(255, 255, 255, 0.2) !important;
            border-color: #FFFFFF !important;
            color: #FFFFFF !important;
            box-shadow: 0 3px 8px rgba(255, 255, 255, 0.2) !important;
        }

        .btn-dark {
            background-color: #1E293B !important;
            border-color: #1E293B !important;
            color: #FFFFFF !important;
            box-shadow: 0 2px 6px rgba(30, 41, 59, 0.25) !important;
        }
        .btn-dark:hover {
            background-color: #0F172A !important;
            border-color: #0F172A !important;
            box-shadow: 0 4px 10px rgba(15, 23, 42, 0.3) !important;
        }

        /* Modern Card Styling */
        .card {
            border-radius: 12px;
            border: 1px solid #E2E8F0 !important;
            background-color: #FFFFFF;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05), 0 4px 12px rgba(0, 0, 0, 0.03) !important;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.07) !important;
        }

        .site-footer {
            background-color: #0F172A !important;
            border-top: 1px solid #1E293B;
            font-size: 0.9rem;
        }

        /* Responsive Mobile Hamburger Menu Toggler */
        .navbar-toggler {
            border: 1.5px solid #64748B !important;
            background-color: rgba(100, 116, 139, 0.2) !important;
            padding: 0.4rem 0.65rem !important;
            border-radius: 8px !important;
            transition: all 0.2s ease;
            outline: none !important;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1) !important;
            min-width: 44px;
            min-height: 44px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        .navbar-toggler:hover, .navbar-toggler:focus {
            background-color: rgba(100, 116, 139, 0.35) !important;
            border-color: #CBD5E1 !important;
            box-shadow: 0 0 10px rgba(148, 163, 184, 0.4) !important;
        }
        .navbar-toggler-icon {
            background-image: none !important;
            display: flex;
            align-items: center;
            justify-content: center;
            width: auto;
            height: auto;
        }
        .navbar-toggler-icon::before {
            content: "\F479"; /* bi-list icon */
            font-family: "bootstrap-icons";
            font-size: 1.65rem;
            color: #CBD5E1;
        }

        /* Mobile Right Offcanvas Navigation Drawer (< 992px) */
        @media (max-width: 991.98px) {
            .navbar-collapse {
                position: fixed !important;
                top: 0 !important;
                right: 0 !important;
                left: auto !important;
                bottom: 0 !important;
                width: 290px !important;
                max-width: 85vw !important;
                height: 100vh !important;
                z-index: 1060 !important;
                background: #0F172A !important;
                border-left: 2px solid #64748B !important;
                border-radius: 16px 0 0 16px !important;
                padding: 1.5rem 1.25rem !important;
                margin-top: 0 !important;
                box-shadow: -8px 0 25px rgba(0, 0, 0, 0.5) !important;
                display: flex !important;
                flex-direction: column !important;
                justify-content: space-between !important;
                transform: translateX(100%) !important;
                transition: transform 0.25s ease-in-out, visibility 0.25s !important;
                visibility: hidden !important;
                overflow-y: auto !important;
            }
            .navbar-collapse.show {
                transform: translateX(0) !important;
                visibility: visible !important;
            }
            
            /* Clean Backdrop Overlay (Performance Optimized) */
            .offcanvas-backdrop-custom {
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                background: rgba(15, 23, 42, 0.6);
                z-index: 1050;
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.25s ease, visibility 0.25s ease;
            }
            .offcanvas-backdrop-custom.show {
                opacity: 1;
                visibility: visible;
            }

            .mobile-offcanvas-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding-bottom: 1.25rem;
                margin-bottom: 1.25rem;
                border-bottom: 1px solid #1E293B;
            }
            
            .mobile-offcanvas-close {
                background: #1E293B;
                border: 1px solid #334155;
                color: #FFFFFF;
                width: 38px;
                height: 38px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.2s ease;
                font-size: 1.1rem;
            }
            .mobile-offcanvas-close:hover {
                background: #DC2626;
                color: #FFFFFF;
                border-color: #DC2626;
            }

            .navbar-nav {
                margin-bottom: auto !important;
                width: 100%;
            }
            .nav-link {
                padding: 0.85rem 1rem !important;
                border-radius: 10px;
                display: flex;
                align-items: center;
                gap: 0.75rem;
                margin-bottom: 0.5rem;
                font-size: 1.05rem;
                font-weight: 600;
                background-color: #1E293B;
                border: 1px solid #334155;
                color: #FFFFFF !important;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            }
            .nav-link:hover {
                background-color: rgba(100, 116, 139, 0.3) !important;
                border-color: #64748B !important;
                color: #CBD5E1 !important;
            }
            .nav-link.active {
                background-color: #475569 !important;
                border-color: #475569 !important;
                color: #FFFFFF !important;
                font-weight: 700;
                box-shadow: 0 2px 8px rgba(71, 85, 105, 0.4);
            }
            .user-mobile-actions {
                border-top: 1px solid #1E293B;
                padding-top: 1.25rem;
                margin-top: 1.5rem;
                flex-direction: column;
                align-items: stretch !important;
                width: 100%;
                gap: 0.75rem !important;
            }
            .user-mobile-actions .btn {
                width: 100%;
                padding: 0.7rem 1rem;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1rem;
                font-weight: 600;
                border-radius: 8px;
            }
            .user-greeting {
                background-color: #1E293B;
                border: 1px solid #334155;
                padding: 0.75rem 1rem;
                border-radius: 8px;
                border-left: 4px solid #64748B;
                text-align: center;
                width: 100%;
            }
        }
    </style>
</head>
<body class="client-layout d-flex flex-column min-vh-100">
    <!-- Mobile Offcanvas Backdrop Overlay -->
    <div id="clientNavbarBackdrop" class="offcanvas-backdrop-custom"></div>

    <header class="site-header navbar navbar-expand-lg navbar-dark sticky-top py-3 shadow-sm">
        <div class="container d-flex align-items-center justify-content-between">
            <!-- Left Side: Brand Logo -->
            <a class="navbar-brand text-warning fw-bold fs-3 d-flex align-items-center" href="<c:url value='/home' />">
                <i class="bi bi-shop me-2"></i>ÁO VỚ VẦN
            </a>

            <!-- Right Side on Mobile: Hamburger Button -->
            <button class="navbar-toggler" type="button" id="btnToggleClientNav" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Right Offcanvas Navigation Drawer -->
            <div class="collapse navbar-collapse" id="clientNavbar">
                <div class="mobile-offcanvas-header d-lg-none">
                    <a class="navbar-brand text-warning fw-bold fs-4 d-flex align-items-center mb-0" href="<c:url value='/home' />">
                        <i class="bi bi-shop me-2"></i>ÁO VỚ VẦN
                    </a>
                    <button type="button" class="mobile-offcanvas-close" id="btnCloseClientNav" aria-label="Close">
                        <i class="bi bi-x-lg"></i>
                    </button>
                </div>
                <nav class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4 gap-2">
                    <a class="nav-link text-white px-3 ${activePage eq 'home' ? 'active' : ''}" href="<c:url value='/home' />">
                        <i class="bi bi-house-door me-1 text-warning"></i> Trang chủ
                    </a>
                    <a class="nav-link text-white px-3 ${activePage eq 'products' ? 'active' : ''}" href="<c:url value='/products' />">
                        <i class="bi bi-bag me-1 text-warning"></i> Sản phẩm
                    </a>
                    <c:if test="${not empty sessionScope.user}">
                        <a class="nav-link text-white px-3 ${activePage eq 'cart' ? 'active' : ''}" href="<c:url value='/cart' />">
                            <i class="bi bi-cart4 me-1 text-warning"></i> Giỏ hàng
                        </a>
                        <a class="nav-link text-white px-3 ${activePage eq 'orders' ? 'active' : ''}" href="<c:url value='/orders' />">
                            <i class="bi bi-receipt me-1 text-warning"></i> Đơn hàng
                        </a>
                    </c:if>
                </nav>
                <div class="d-flex align-items-center gap-3 user-mobile-actions">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="user-greeting">
                                <span class="text-white-50 small"><i class="bi bi-person-circle me-1 text-warning"></i> Xin chào, <strong class="text-white"><c:out value="${sessionScope.user.name}"/></strong></span>
                            </div>
                            <c:if test="${sessionScope.isAdmin eq true}">
                                <a class="btn btn-outline-light btn-sm font-semibold" href="<c:url value='/admin/products' />"><i class="bi bi-speedometer2 me-1"></i> Quản trị</a>
                            </c:if>
                            <a class="btn btn-danger btn-sm font-semibold" href="<c:url value='/logout' />"><i class="bi bi-box-arrow-right me-1"></i> Thoát</a>
                        </c:when>
                        <c:otherwise>
                            <a class="btn btn-outline-warning btn-sm font-semibold px-3" href="<c:url value='/login' />"><i class="bi bi-box-arrow-in-right me-1"></i> Đăng nhập</a>
                            <a class="btn btn-warning btn-sm font-semibold px-3" href="<c:url value='/register' />"><i class="bi bi-person-plus me-1"></i> Đăng ký</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </header>

    <main class="site-main flex-grow-1 py-3 py-md-5">
        <jsp:include page="${contentPage}" />
    </main>

    <footer class="site-footer text-white-50 py-4 mt-auto">
        <div class="container text-center">
            <p class="mb-0">© 2026 <strong class="text-white">Áo Vớ Vẩn</strong> - Thương Hiệu Thời Trang Độc Lạ. All rights reserved.</p>
        </div>
    </footer>

    <!-- Toast Notification Container -->
    <div class="toast-container position-fixed bottom-0 end-0 p-3" style="z-index: 1090; pointer-events: none;">
        <div id="cartToast" class="toast align-items-center text-white bg-dark border-0 shadow-lg" role="alert" aria-live="assertive" aria-atomic="true" style="pointer-events: auto;">
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
        document.addEventListener('DOMContentLoaded', function() {
            const toggleBtn = document.getElementById('btnToggleClientNav');
            const closeBtn = document.getElementById('btnCloseClientNav');
            const navbar = document.getElementById('clientNavbar');
            const backdrop = document.getElementById('clientNavbarBackdrop');

            function openNav() {
                if (navbar) navbar.classList.add('show');
                if (backdrop) backdrop.classList.show ? backdrop.classList.add('show') : backdrop.classList.add('show');
                if (toggleBtn) toggleBtn.setAttribute('aria-expanded', 'true');
                document.body.style.overflow = 'hidden';
            }

            function closeNav() {
                if (navbar) navbar.classList.remove('show');
                if (backdrop) backdrop.classList.remove('show');
                if (toggleBtn) toggleBtn.setAttribute('aria-expanded', 'false');
                document.body.style.overflow = '';
            }

            if (toggleBtn) {
                toggleBtn.addEventListener('click', function(e) {
                    e.preventDefault();
                    if (navbar && navbar.classList.contains('show')) {
                        closeNav();
                    } else {
                        openNav();
                    }
                });
            }

            if (closeBtn) closeBtn.addEventListener('click', closeNav);
            if (backdrop) backdrop.addEventListener('click', closeNav);

            window.addEventListener('resize', function() {
                if (window.innerWidth >= 992) {
                    closeNav();
                }
            });
        });

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
