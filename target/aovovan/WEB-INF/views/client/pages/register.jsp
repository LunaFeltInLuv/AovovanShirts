<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản - Áo Vớ Vẩn</title>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/vendors/bootstrap-icons/bootstrap-icons.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/css/app.css' />">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            background-color: #FAFAF9;
        }
        #auth {
            height: 100%;
            overflow-x: hidden;
        }
        #auth-left {
            padding: 3rem 3rem;
        }
        .auth-logo {
            margin-bottom: 2rem;
        }
        .auth-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: #1C1917;
            margin-bottom: 0.5rem;
        }
        .auth-subtitle {
            color: #7c8db5;
            font-size: 1rem;
        }
        #auth-right {
            height: 100vh;
            background: linear-gradient(135deg, rgba(28,25,23,0.9) 0%, rgba(161,98,7,0.7) 100%), 
                        url('https://images.unsplash.com/photo-1523381210434-271e8be1f52b?q=80&w=1200') no-repeat center center;
            background-size: cover;
        }
        .form-control-xl {
            padding: 0.75rem 1rem 0.75rem 2.5rem !important;
            font-size: 1rem;
            border-radius: 8px;
        }
        .form-group[class*=has-icon-].has-icon-left .form-control-icon {
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
        }
        .btn-warning {
            background-color: #A16207 !important;
            border-color: #A16207 !important;
            color: #FFFFFF !important;
            font-weight: 600;
        }
        .btn-warning:hover {
            background-color: #854d0e !important;
            border-color: #854d0e !important;
            box-shadow: 0 4px 10px rgba(161, 98, 7, 0.3);
        }
        .text-warning {
            color: #A16207 !important;
        }
    </style>
</head>
<body>
    <div id="auth">
        <div class="row h-100 g-0">
            <div class="col-lg-5 col-12">
                <div id="auth-left">
                    <div class="auth-logo">
                        <a href="<c:url value='/home' />" class="text-warning font-bold fs-3 text-decoration-none">
                            <i class="bi bi-shop me-2"></i>ÁO VỚ VẦN
                        </a>
                    </div>
                    <h1 class="auth-title">Đăng Ký.</h1>
                    <p class="auth-subtitle mb-3">Tạo tài khoản của bạn để gia nhập gia đình Áo Vớ Vẩn.</p>

                    <c:if test="${not empty error}">
                        <div class="alert bg-light-danger text-danger rounded-3 mb-3 p-3" role="alert">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <c:out value="${error}" />
                        </div>
                    </c:if>

                    <form action="<c:url value='/register' />" method="post">
                        <div class="form-group position-relative has-icon-left mb-3">
                            <input type="text" name="username" class="form-control form-control-xl" placeholder="Tên đăng nhập (username)" required autofocus>
                            <div class="form-control-icon">
                                <i class="bi bi-person"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-3">
                            <input type="password" name="password" class="form-control form-control-xl" placeholder="Mật khẩu" required>
                            <div class="form-control-icon">
                                <i class="bi bi-shield-lock"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-3">
                            <input type="text" name="name" class="form-control form-control-xl" placeholder="Họ và tên" required>
                            <div class="form-control-icon">
                                <i class="bi bi-card-text"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-3">
                            <input type="text" name="phone" class="form-control form-control-xl" placeholder="Số điện thoại" required>
                            <div class="form-control-icon">
                                <i class="bi bi-phone"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-3">
                            <input type="email" name="email" class="form-control form-control-xl" placeholder="Địa chỉ email" required>
                            <div class="form-control-icon">
                                <i class="bi bi-envelope"></i>
                            </div>
                        </div>
                        <div class="form-group position-relative has-icon-left mb-3">
                            <input type="text" name="address" class="form-control form-control-xl" placeholder="Địa chỉ nhận hàng (không bắt buộc)">
                            <div class="form-control-icon">
                                <i class="bi bi-geo-alt"></i>
                            </div>
                        </div>
                        <button class="btn btn-warning btn-block btn-lg shadow-lg mt-2 py-2">ĐĂNG KÝ NGAY</button>
                    </form>
                    <div class="text-center mt-4 fs-5">
                        <p class="text-gray-600">Đã có tài khoản? <a href="<c:url value='/login' />" class="font-bold text-warning text-decoration-none">Đăng nhập ngay</a>.</p>
                        <p class="mt-2"><a href="<c:url value='/home' />" class="text-secondary text-decoration-none"><i class="bi bi-arrow-left"></i> Quay lại trang chủ</a></p>
                    </div>
                </div>
            </div>
            <div class="col-lg-7 d-none d-lg-block">
                <div id="auth-right"></div>
            </div>
        </div>
    </div>
</body>
</html>
