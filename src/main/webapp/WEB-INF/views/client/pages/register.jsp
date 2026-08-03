<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký tài khoản - Áo Vớ Vẩn</title>
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.css' />">
    <link rel="stylesheet" href="<c:url value='/assets/vendors/bootstrap-icons/bootstrap-icons.css' />">
</head>
<body class="bg-light">
    <div class="container d-flex justify-content-center align-items-center py-5">
        <div class="card shadow-lg p-4" style="max-width: 480px; width: 100%;">
            <div class="text-center mb-3">
                <h2 class="text-warning font-weight-bold"><i class="bi bi-person-plus me-2"></i>TẠO TÀI KHOẢN</h2>
                <p class="text-muted">Gia nhập cộng đồng Áo Vớ Vẩn</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger p-2 fs-6" role="alert">
                    <c:out value="${error}" />
                </div>
            </c:if>

            <form action="<c:url value='/register' />" method="post">
                <div class="mb-2">
                    <label class="form-label font-weight-bold">Tên đăng nhập (*)</label>
                    <input type="text" name="username" class="form-control" placeholder="Tối thiểu 3 ký tự, không dấu cách" required>
                </div>
                <div class="mb-2">
                    <label class="form-label font-weight-bold">Mật khẩu (*)</label>
                    <input type="password" name="password" class="form-control" placeholder="Mật khẩu" required>
                </div>
                <div class="mb-2">
                    <label class="form-label font-weight-bold">Họ và tên (*)</label>
                    <input type="text" name="name" class="form-control" placeholder="Nguyễn Văn A" required>
                </div>
                <div class="mb-2">
                    <label class="form-label font-weight-bold">Số điện thoại (*)</label>
                    <input type="text" name="phone" class="form-control" placeholder="0912345678" required>
                </div>
                <div class="mb-2">
                    <label class="form-label font-weight-bold">Email (*)</label>
                    <input type="email" name="email" class="form-control" placeholder="example@gmail.com" required>
                </div>
                <div class="mb-3">
                    <label class="form-label font-weight-bold">Địa chỉ nhận hàng</label>
                    <input type="text" name="address" class="form-control" placeholder="Số nhà, Tên đường, Tỉnh/TP">
                </div>
                <button type="submit" class="btn btn-warning w-100 text-dark font-weight-bold py-2">ĐĂNG KÝ NGAY</button>
            </form>

            <div class="text-center mt-3">
                <span>Đã có tài khoản? </span>
                <a href="<c:url value='/login' />" class="text-warning font-weight-bold">Đăng nhập ngay</a>
            </div>
        </div>
    </div>
</body>
</html>
