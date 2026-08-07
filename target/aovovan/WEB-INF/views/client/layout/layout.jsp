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
        :root {
            --primary-gradient: linear-gradient(135deg, #F43F5E 0%, #8B5CF6 100%);
            --primary-color: #8B5CF6;
            --primary-color-hover: #7C3AED;
            --accent-color: #F43F5E;
            --surface-color: #FFFFFF;
            --bg-color: #F8FAFC;
            --text-main: #0F172A;
            --text-muted: #64748B;
            --border-color: #E2E8F0;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
        }
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Montserrat', sans-serif;
            font-weight: 800;
            color: var(--text-main);
            letter-spacing: -0.02em;
        }
        
        /* Modern Minimalist Header Bar */
        .site-header {
            background-color: var(--surface-color) !important;
            border-bottom: 1px solid var(--border-color);
            height: auto !important;
            min-height: 76px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.03);
            transition: all 0.2s ease;
        }
        .nav-link {
            font-family: 'Inter', sans-serif;
            font-weight: 600;
            font-size: 0.95rem;
            letter-spacing: 0.3px;
            transition: all 0.3s ease;
            color: var(--text-muted) !important;
        }
        .nav-link:hover {
            color: var(--primary-color) !important;
        }
        .nav-link.active {
            background: var(--primary-gradient) !important;
            color: #FFFFFF !important;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(139, 92, 246, 0.25);
        }
        
        /* Logo Text Gradient */
        .logo-text {
            font-family: 'Montserrat', sans-serif;
            font-weight: 900;
            font-size: 1.5rem;
            letter-spacing: -0.05em;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-decoration: none;
        }

        /* Gen Z Buttons */
        .btn {
            border-radius: 12px;
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            letter-spacing: 0.5px;
            border: none;
        }
        .btn:hover {
            transform: translateY(-3px);
        }
        .btn:active {
            transform: translateY(0);
        }

        /* Primary Button: Gradient */
        .btn-warning {
            background: var(--primary-gradient) !important;
            color: #FFFFFF !important;
            box-shadow: 0 6px 16px -4px rgba(139, 92, 246, 0.4) !important;
        }
        .btn-warning:hover {
            box-shadow: 0 10px 20px -4px rgba(244, 63, 94, 0.4) !important;
        }

        /* Secondary Outline Button */
        .btn-outline-warning {
            background-color: var(--surface-color) !important;
            border: 2px solid var(--primary-color) !important;
            color: var(--primary-color) !important;
            box-shadow: 0 4px 10px rgba(139, 92, 246, 0.1) !important;
        }
        .btn-outline-warning:hover {
            background: var(--primary-gradient) !important;
            border-color: transparent !important;
            color: #FFFFFF !important;
            box-shadow: 0 8px 16px rgba(139, 92, 246, 0.3) !important;
        }

        /* Danger Button: Red Accent */
        .btn-danger {
            background-color: var(--accent-color) !important;
            color: #FFFFFF !important;
            box-shadow: 0 6px 16px -4px rgba(244, 63, 94, 0.4) !important;
        }
        .btn-danger:hover {
            background-color: #E11D48 !important;
            box-shadow: 0 10px 20px -4px rgba(244, 63, 94, 0.5) !important;
        }

        /* Light Button */
        .btn-outline-light {
            background-color: #F1F5F9 !important;
            border: 2px solid transparent !important;
            color: var(--text-main) !important;
        }
        .btn-outline-light:hover {
            background-color: #E2E8F0 !important;
            color: var(--text-main) !important;
        }

        /* Modern Card Styling */
        .card {
            border-radius: 16px;
            border: 1px solid rgba(226, 232, 240, 0.8) !important;
            background-color: var(--surface-color);
            box-shadow: 0 10px 30px -10px rgba(0, 0, 0, 0.05) !important;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px -10px rgba(139, 92, 246, 0.12) !important;
        }

        .site-footer {
            background-color: var(--surface-color) !important;
            border-top: 1px solid var(--border-color);
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        /* Responsive Mobile Hamburger Menu Toggler */
        .navbar-toggler {
            border: none !important;
            background-color: #F1F5F9 !important;
            padding: 0.5rem !important;
            border-radius: 12px !important;
            transition: all 0.2s ease;
        }
        .navbar-toggler-icon::before {
            content: "\F479"; /* bi-list icon */
            font-family: "bootstrap-icons";
            font-size: 1.8rem;
            color: var(--text-main);
        }

        /* Mobile Right Offcanvas Navigation Drawer (< 992px) */
        @media (max-width: 991.98px) {
            .navbar-collapse {
                position: fixed !important;
                top: 0 !important;
                right: 0 !important;
                left: auto !important;
                bottom: 0 !important;
                width: 320px !important;
                max-width: 85vw !important;
                height: 100vh !important;
                z-index: 1060 !important;
                background: var(--surface-color) !important;
                border-left: 1px solid var(--border-color) !important;
                border-radius: 24px 0 0 24px !important;
                padding: 2rem 1.5rem !important;
                box-shadow: -10px 0 40px rgba(0, 0, 0, 0.1) !important;
                display: flex !important;
                flex-direction: column !important;
                transform: translateX(100%) !important;
                transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1), visibility 0.3s !important;
                visibility: hidden !important;
                overflow-y: auto !important;
            }
            .navbar-collapse.show {
                transform: translateX(0) !important;
                visibility: visible !important;
            }
            
            .offcanvas-backdrop-custom {
                background: rgba(15, 23, 42, 0.4);
                backdrop-filter: blur(4px);
            }

            .mobile-offcanvas-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding-bottom: 1.5rem;
                margin-bottom: 1.5rem;
                border-bottom: 1px solid var(--border-color);
            }
            
            .mobile-offcanvas-close {
                background: #F1F5F9;
                border: none;
                color: var(--text-main);
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
            }

            .nav-link {
                padding: 1rem 1.25rem !important;
                border-radius: 12px;
                background-color: #F8FAFC;
                color: var(--text-main) !important;
                box-shadow: none;
                border: 1px solid var(--border-color);
            }
            .user-mobile-actions {
                border-top: 1px solid var(--border-color);
            }
            .user-greeting {
                background-color: #F8FAFC;
                border: 1px solid var(--border-color);
                border-left: 4px solid var(--primary-color);
                color: var(--text-main) !important;
            }
            .user-greeting strong {
                color: var(--primary-color) !important;
            }
            .user-greeting .text-white-50 {
                color: var(--text-muted) !important;
            }
        }
    </style>
</head>
<body class="client-layout d-flex flex-column min-vh-100">
    <!-- Mobile Offcanvas Backdrop Overlay -->
    <div id="clientNavbarBackdrop" class="offcanvas-backdrop-custom"></div>

    <header class="site-header navbar navbar-expand-lg navbar-light sticky-top py-3 shadow-sm">
        <div class="container d-flex align-items-center justify-content-between">
            <!-- Left Side: Brand Logo -->
            <a class="navbar-brand logo-text d-flex align-items-center" href="<c:url value='/home' />">
                ÁO VỚ VẦN
            </a>

            <!-- Right Side on Mobile: Hamburger Button -->
            <button class="navbar-toggler" type="button" id="btnToggleClientNav" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Right Offcanvas Navigation Drawer -->
            <div class="collapse navbar-collapse" id="clientNavbar">
                <div class="mobile-offcanvas-header d-lg-none">
                    <a class="navbar-brand logo-text d-flex align-items-center mb-0" href="<c:url value='/home' />">
                        ÁO VỚ VẦN
                    </a>
                    <button type="button" class="mobile-offcanvas-close" id="btnCloseClientNav" aria-label="Close">
                        <i class="bi bi-x-lg"></i>
                    </button>
                </div>
                <nav class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4 gap-2">
                    <a class="nav-link px-3 ${activePage eq 'home' ? 'active' : ''}" href="<c:url value='/home' />">
                        Trang chủ
                    </a>
                    <a class="nav-link px-3 ${activePage eq 'products' ? 'active' : ''}" href="<c:url value='/products' />">
                        Sản phẩm
                    </a>
                    <c:if test="${not empty sessionScope.user}">
                        <a class="nav-link px-3 ${activePage eq 'cart' ? 'active' : ''}" href="<c:url value='/cart' />">
                            Giỏ hàng
                        </a>
                        <a class="nav-link px-3 ${activePage eq 'orders' ? 'active' : ''}" href="<c:url value='/orders' />">
                            Đơn hàng
                        </a>
                    </c:if>
                </nav>
                <div class="d-flex align-items-center gap-3 user-mobile-actions">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <div class="user-greeting px-3 py-2 rounded-3">
                                <span class="text-muted small"><i class="bi bi-person-circle me-1" style="color: var(--primary-color);"></i> Xin chào, <strong class="text-dark"><c:out value="${sessionScope.user.name}"/></strong></span>
                            </div>
                            <a class="btn btn-outline-light btn-sm font-semibold px-3" href="<c:url value='/profile' />">Hồ sơ</a>
                            <c:if test="${sessionScope.isAdmin eq true}">
                                <a class="btn btn-outline-light btn-sm font-semibold" href="<c:url value='/admin/products' />"><i class="bi bi-speedometer2 me-1"></i> Quản trị</a>
                            </c:if>
                            <a class="btn btn-danger btn-sm font-semibold px-3" href="<c:url value='/logout' />">Thoát</a>
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

    <main class="site-main flex-grow-1 py-3 py-md-5">
        <jsp:include page="${contentPage}" />
    </main>

    <footer class="site-footer py-4 mt-auto">
        <div class="container text-center">
            <p class="mb-0">© 2026 <strong style="color: var(--text-main);">Áo Vớ Vẩn</strong> - Thương Hiệu Thời Trang Độc Lạ. All rights reserved.</p>
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
