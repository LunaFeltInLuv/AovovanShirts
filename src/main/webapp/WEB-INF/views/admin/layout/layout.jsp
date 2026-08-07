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
    <link rel="stylesheet" href="<c:url value='/assets/vendors/perfect-scrollbar/perfect-scrollbar.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/vendors/bootstrap-icons/bootstrap-icons.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/css/app.css' />">
    <style>
        body {
            font-family: 'Nunito', sans-serif;
            background-color: #F8FAFC;
        }
        .burger-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 44px;
            height: 44px;
            border-radius: 10px;
            background-color: #ffffff;
            border: 1.5px solid #CBD5E1;
            color: #1E293B;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            transition: transform 0.15s ease, box-shadow 0.15s ease;
            text-decoration: none !important;
        }
        .burger-btn:hover, .burger-btn:focus {
            background-color: #F1F5F9;
            color: #475569;
            border-color: #475569;
            transform: translateY(-1px);
            box-shadow: 0 4px 10px rgba(71, 85, 105, 0.2);
        }
        .burger-btn i {
            font-size: 1.5rem;
            line-height: 1;
        }

        .btn {
            border-radius: 8px;
            font-weight: 600;
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }
        .btn:hover {
            transform: translateY(-1px);
        }
        
        @media screen and (max-width: 1199px) {
            #sidebar-backdrop {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100vw;
                height: 100vh;
                background-color: rgba(15, 23, 42, 0.55);
                z-index: 998;
                opacity: 0;
                transition: opacity 0.25s ease;
            }
            #sidebar-backdrop.show {
                display: block;
                opacity: 1;
            }
            #sidebar {
                z-index: 999 !important;
            }
        }
    </style>
</head>

<body>
    <div id="app">
        <div id="sidebar-backdrop"></div>
        <div id="sidebar" class="active">
            <div class="sidebar-wrapper active">
                <div class="sidebar-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="logo">
                            <a href="<c:url value='/admin' />" class="text-warning font-weight-bold h4 text-decoration-none">
                                <i class="bi bi-shield-lock me-1"></i>VỚ VẦN ADMIN
                            </a>
                        </div>
                        <div class="toggler">
                            <a href="#" class="sidebar-hide d-xl-none d-block"><i class="bi bi-x bi-middle"></i></a>
                        </div>
                    </div>
                </div>
                <div class="sidebar-menu">
                    <ul class="menu">
                        <li class="sidebar-title">Menu Quản trị</li>

                        <li class="sidebar-item ${activePage eq 'dashboard' ? 'active' : ''}">
                            <a href="<c:url value='/admin' />" class='sidebar-link'>
                                <i class="bi bi-speedometer2"></i>
                                <span>Tổng quan</span>
                            </a>
                        </li>

                        <li class="sidebar-item ${activePage eq 'products' ? 'active' : ''}">
                            <a href="<c:url value='/admin/products' />" class='sidebar-link'>
                                <i class="bi bi-grid-fill"></i>
                                <span>Quản lý sản phẩm</span>
                            </a>
                        </li>

                        <li class="sidebar-item ${activePage eq 'categories' ? 'active' : ''}">
                            <a href="<c:url value='/admin/categories' />" class='sidebar-link'>
                                <i class="bi bi-tags-fill"></i>
                                <span>Quản lý danh mục</span>
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
                <button class="sidebar-toggler btn x"><i class="bi bi-x"></i></button>
            </div>
        </div>

        <div id="main" class="layout-navbar">
            <header class="mb-3">
                <nav class="navbar navbar-expand navbar-light bg-light py-2 px-3 shadow-sm rounded">
                    <div class="container-fluid">
                        <a href="#" class="burger-btn d-block me-3">
                            <i class="bi bi-justify fs-3"></i>
                        </a>

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <span class="navbar-text font-weight-bold d-none d-md-block text-secondary">
                                Hệ thống Quản Trị Áo Vớ Vẩn
                            </span>
                            <div class="dropdown ms-auto">
                                <a href="#" data-bs-toggle="dropdown" aria-expanded="false" class="text-decoration-none text-dark">
                                    <div class="user-menu d-flex align-items-center">
                                        <div class="user-name text-end me-3">
                                            <h6 class="mb-0 text-gray-600 font-bold"><c:out value="${sessionScope.user.name}"/></h6>
                                            <p class="mb-0 text-sm text-gray-400">Admin</p>
                                        </div>
                                        <div class="user-img d-flex align-items-center">
                                            <div class="avatar avatar-md bg-warning text-dark font-bold d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; border-radius: 50%;">
                                                <i class="bi bi-person-circle fs-4"></i>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end shadow-sm" aria-labelledby="dropdownMenuButton">
                                    <li>
                                        <h6 class="dropdown-header">Xin chào, <c:out value="${sessionScope.user.name}"/>!</h6>
                                    </li>
                                    <li><a class="dropdown-item" href="<c:url value='/home' />"><i class="bi bi-house-door me-2"></i> Trang chủ</a></li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    <li><a class="dropdown-item text-danger" href="<c:url value='/logout' />"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </nav>
            </header>

            <div id="main-content">
                <div class="page-heading">
                    <h3><c:out value="${pageTitle}" /></h3>
                </div>

                <div class="page-content">
                    <jsp:include page="${contentPage}" />
                </div>

                <footer class="mt-4 pt-3 border-top">
                    <div class="footer clearfix mb-0 text-muted">
                        <div class="float-start">
                            <p>2026 &copy; Áo Vớ Vẩn Admin Dashboard</p>
                        </div>
                        <div class="float-end">
                            <p>Giao diện thiết kế theo Mazer</p>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
    </div>

    <script src="<c:url value='/assets/vendors/perfect-scrollbar/perfect-scrollbar.min.js' />"></script>
    <script src="<c:url value='/assets/js/bootstrap.bundle.min.js' />"></script>
    <script src="<c:url value='/assets/js/main.js' />"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const sidebar = document.getElementById('sidebar');
            const backdrop = document.getElementById('sidebar-backdrop');
            const burgerBtn = document.querySelector('.burger-btn');
            const sidebarHide = document.querySelector('.sidebar-hide');

            function updateBackdropState() {
                if (window.innerWidth < 1200 && sidebar && sidebar.classList.contains('active')) {
                    backdrop.classList.add('show');
                } else {
                    backdrop.classList.remove('show');
                }
            }

            if (burgerBtn) {
                burgerBtn.addEventListener('click', function() {
                    setTimeout(updateBackdropState, 50);
                });
            }
            if (sidebarHide) {
                sidebarHide.addEventListener('click', function() {
                    setTimeout(updateBackdropState, 50);
                });
            }
            if (backdrop) {
                backdrop.addEventListener('click', function() {
                    if (sidebar) sidebar.classList.remove('active');
                    backdrop.classList.remove('show');
                });
            }
            window.addEventListener('resize', function() {
                updateBackdropState();
            });
        });
    </script>
</body>
</html>
