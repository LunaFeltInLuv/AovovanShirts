<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
    :root {
        --primary-gradient: linear-gradient(135deg, #F43F5E 0%, #8B5CF6 100%);
        --primary-color: #8B5CF6;
        --surface-color: #FFFFFF;
        --bg-color: #F8FAFC;
        --text-main: #0F172A;
        --text-muted: #64748B;
    }
    
    .profile-container {
        max-width: 800px;
        margin: 0 auto;
        padding: 2rem 15px;
        font-family: 'Inter', sans-serif;
    }

    .profile-header {
        text-align: center;
        margin-bottom: 2.5rem;
    }

    .profile-header h1 {
        font-family: 'Montserrat', sans-serif;
        font-weight: 800;
        font-size: 2.5rem;
        background: var(--primary-gradient);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        margin-bottom: 0.5rem;
    }

    .profile-header p {
        color: var(--text-muted);
        font-size: 1.1rem;
    }

    .profile-card {
        background-color: var(--surface-color);
        border-radius: 20px;
        box-shadow: 0 10px 40px -10px rgba(139, 92, 246, 0.1);
        padding: 3rem;
        border: 1px solid rgba(226, 232, 240, 0.8);
    }

    .form-control-modern {
        padding: 0.85rem 1.25rem;
        font-size: 1rem;
        background-color: #F1F5F9;
        border: 2px solid transparent;
        border-radius: 12px;
        color: var(--text-main);
        transition: all 0.3s ease;
        font-weight: 500;
    }
    
    .form-control-modern::placeholder {
        color: #94A3B8;
        font-weight: 400;
    }

    .form-control-modern:focus {
        background-color: var(--surface-color);
        border-color: var(--primary-color);
        box-shadow: 0 0 0 4px rgba(139, 92, 246, 0.15);
        outline: none;
    }

    .form-label-modern {
        font-weight: 600;
        color: var(--text-main);
        margin-bottom: 0.5rem;
        font-size: 0.95rem;
    }

    .btn-modern {
        background: var(--primary-gradient);
        color: white !important;
        border: none;
        border-radius: 12px;
        padding: 0.9rem 2rem;
        font-family: 'Montserrat', sans-serif;
        font-weight: 700;
        font-size: 1.1rem;
        letter-spacing: 0.5px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        box-shadow: 0 8px 20px -5px rgba(139, 92, 246, 0.4);
    }

    .btn-modern:hover {
        transform: translateY(-3px);
        box-shadow: 0 12px 25px -5px rgba(244, 63, 94, 0.4);
    }

    .btn-modern:active {
        transform: translateY(0);
    }

    .alert-custom {
        border-radius: 12px;
        font-weight: 500;
        padding: 1rem 1.25rem;
        margin-bottom: 2rem;
        border: none;
    }

    .alert-success-custom {
        background-color: #ECFDF5;
        color: #047857;
    }

    .alert-danger-custom {
        background-color: #FEF2F2;
        color: #B91C1C;
    }

    .avatar-wrapper {
        width: 100px;
        height: 100px;
        border-radius: 50%;
        background: var(--primary-gradient);
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 2rem auto;
        color: white;
        font-size: 2.5rem;
        font-weight: 700;
        box-shadow: 0 8px 20px -5px rgba(139, 92, 246, 0.4);
    }
</style>

<div class="profile-container">
    <div class="profile-header">
        <h1>Hồ Sơ Cá Nhân</h1>
        <p>Cập nhật thông tin của bạn để chúng tôi phục vụ tốt hơn</p>
    </div>

    <div class="profile-card">
        
        <div class="avatar-wrapper">
            ${not empty sessionScope.user.name ? sessionScope.user.name.substring(0, 1).toUpperCase() : 'U'}
        </div>

        <c:if test="${not empty successMessage}">
            <div class="alert alert-custom alert-success-custom">
                <c:out value="${successMessage}" />
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-custom alert-danger-custom">
                <c:out value="${errorMessage}" />
            </div>
        </c:if>

        <form action="<c:url value='/profile' />" method="post">
            
            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <label class="form-label-modern">Tên đăng nhập</label>
                    <input type="text" class="form-control form-control-modern" value="${sessionScope.user.username}" disabled style="background-color: #F8FAFC; color: #94A3B8;">
                    <small class="text-muted mt-1 d-block">Tên đăng nhập không thể thay đổi.</small>
                </div>
                <div class="col-md-6">
                    <label class="form-label-modern">Họ và tên</label>
                    <input type="text" name="name" class="form-control form-control-modern" value="${sessionScope.user.name}" required>
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-6">
                    <label class="form-label-modern">Số điện thoại</label>
                    <input type="text" name="phone" class="form-control form-control-modern" value="${sessionScope.user.phone}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label-modern">Email</label>
                    <input type="email" name="email" class="form-control form-control-modern" value="${sessionScope.user.email}" required>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label-modern">Địa chỉ giao hàng</label>
                <input type="text" name="address" class="form-control form-control-modern" value="${sessionScope.user.address}">
            </div>

            <div class="mb-4">
                <label class="form-label-modern">Mật khẩu cũ</label>
                <input type="password" name="oldPassword" class="form-control form-control-modern" placeholder="Để trống nếu không muốn thay đổi mật khẩu">
            </div>

            <div class="row g-4 mb-5">
                <div class="col-md-6">
                    <label class="form-label-modern">Mật khẩu mới</label>
                    <input type="password" name="newPassword" class="form-control form-control-modern" placeholder="Nhập mật khẩu mới">
                </div>
                <div class="col-md-6">
                    <label class="form-label-modern">Nhập lại mật khẩu mới</label>
                    <input type="password" name="confirmPassword" class="form-control form-control-modern" placeholder="Nhập lại mật khẩu mới">
                </div>
            </div>

            <div class="d-flex justify-content-center">
                <button type="submit" class="btn btn-modern">LƯU THAY ĐỔI</button>
            </div>
        </form>
    </div>
</div>
