<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký - Áo Vớ Vẩn</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Montserrat:wght@700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/assets/css/bootstrap.css' />">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #F43F5E 0%, #8B5CF6 100%);
            --primary-color: #8B5CF6;
            --surface-color: #FFFFFF;
            --bg-color: #F8FAFC;
            --text-main: #0F172A;
            --text-muted: #64748B;
        }
        
        html, body {
            height: 100%;
            margin: 0;
            background-color: var(--bg-color);
            font-family: 'Inter', sans-serif;
            color: var(--text-main);
        }
        
        #auth {
            height: 100%;
            overflow-x: hidden;
        }

        .auth-logo a {
            font-family: 'Montserrat', sans-serif;
            font-weight: 900;
            font-size: 1.75rem;
            letter-spacing: -0.05em;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-decoration: none;
        }

        #auth-left {
            padding: 2rem 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: 100%;
        }

        .auth-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 2.8rem;
            font-weight: 800;
            letter-spacing: -0.03em;
            margin-bottom: 0.5rem;
            color: var(--text-main);
        }

        .auth-subtitle {
            color: var(--text-muted);
            font-size: 1.05rem;
            margin-bottom: 2.5rem;
            font-weight: 400;
        }

        /* Modern Input Styling */
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

        /* Modern Gradient Button */
        .btn-modern {
            background: var(--primary-gradient);
            color: white !important;
            border: none;
            border-radius: 12px;
            padding: 0.9rem 1.5rem;
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

        /* Right Side Image */
        #auth-right {
            height: 100vh;
            background: url('https://images.unsplash.com/photo-1550614000-4b95d466f2bd?q=80&w=1400&auto=format&fit=crop') center center / cover no-repeat;
            position: relative;
        }

        #auth-right::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(135deg, rgba(244, 63, 94, 0.2) 0%, rgba(139, 92, 246, 0.4) 100%);
            mix-blend-mode: overlay;
        }
        
        .auth-link {
            color: var(--primary-color);
            font-weight: 700;
            text-decoration: none;
            transition: color 0.2s ease;
        }
        
        .auth-link:hover {
            color: #F43F5E;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div id="auth">
        <div class="row h-100 g-0">
            <div class="col-lg-5 col-12 d-flex flex-column" style="overflow-y: auto;">
                <div id="auth-left">
                    <div class="auth-logo mb-4">
                        <a href="<c:url value='/home' />">ÁO VỚ VẦN</a>
                    </div>
                    
                    <h1 class="auth-title">Đăng Ký</h1>
                    <p class="auth-subtitle">Tạo tài khoản và trải nghiệm mua sắm ngay.</p>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" style="border-radius: 12px; font-weight: 500; padding: 0.8rem 1rem; margin-bottom: 1.5rem;">
                            <c:out value="${error}" />
                        </div>
                    </c:if>

                    <form action="<c:url value='/register' />" method="post">
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <input type="text" name="username" class="form-control form-control-modern" placeholder="Tên đăng nhập" required autofocus>
                            </div>
                            <div class="col-md-6">
                                <input type="password" name="password" class="form-control form-control-modern" placeholder="Mật khẩu" required>
                            </div>
                        </div>
                        
                        <div class="form-group mb-3">
                            <input type="text" name="name" class="form-control form-control-modern" placeholder="Họ và tên" required>
                        </div>
                        
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <input type="text" name="phone" class="form-control form-control-modern" placeholder="Số điện thoại" required>
                            </div>
                            <div class="col-md-6">
                                <input type="email" name="email" class="form-control form-control-modern" placeholder="Email" required>
                            </div>
                        </div>
                        
                        <div class="form-group mb-4">
                            <input type="text" name="address" class="form-control form-control-modern" placeholder="Địa chỉ giao hàng (Tùy chọn)">
                        </div>

                        <button type="submit" class="btn btn-modern w-100 mb-4">TẠO TÀI KHOẢN</button>

                    </form>
                    
                    <div class="text-center mt-auto pb-4">
                        <p class="text-muted">Đã có tài khoản? <a href="<c:url value='/login' />" class="auth-link">Đăng nhập</a>.</p>
                        <p class="mt-2"><a href="<c:url value='/home' />" class="text-muted text-decoration-none hover-underline">Quay lại trang chủ</a></p>
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
