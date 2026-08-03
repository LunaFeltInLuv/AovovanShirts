<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - Áo Vớ Vẩn</title>
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/vendors/bootstrap-icons/bootstrap-icons.css' />">
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center vh-100">
        <div class="card shadow-lg p-4" style="max-width: 420px; width: 100%;">
            <div class="text-center mb-4">
                <h2 class="text-warning font-weight-bold"><i class="bi bi-shop me-2"></i>ÁO VỚ VẦN</h2>
                <p class="text-muted">Đăng nhập tài khoản của bạn</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger p-2 fs-6" role="alert">
                    <c:out value="${error}" />
                </div>
            </c:if>
            <c:if test="${param.registered eq 'true'}">
                <div class="alert alert-success p-2 fs-6" role="alert">
                    Đăng ký tài khoản thành công! Vui lòng đăng nhập.
                </div>
            </c:if>

            <form action="<c:url value='/login' />" method="post">
                <div class="mb-3">
                    <label class="form-label font-weight-bold">Tên đăng nhập</label>
                    <input type="text" name="username" class="form-control" placeholder="Nhập username" required autofocus>
                </div>
                <div class="mb-3">
                    <label class="form-label font-weight-bold">Mật khẩu</label>
                    <input type="password" name="password" class="form-control" placeholder="Nhập mật khẩu" required>
                </div>
                <button type="submit" class="btn btn-warning w-100 text-dark font-weight-bold py-2">ĐĂNG NHẬP</button>
            </form>

            <div class="text-center mt-3">
                <span>Chưa có tài khoản? </span>
                <a href="<c:url value='/register' />" class="text-warning font-weight-bold">Đăng ký ngay</a>
            </div>
            <div class="text-center mt-2">
                <a href="<c:url value='/home' />" class="text-secondary text-decoration-none"><i class="bi bi-arrow-left"></i> Quay lại trang chủ</a>
            </div>
        </div>
    </div>
</body>
</html>
