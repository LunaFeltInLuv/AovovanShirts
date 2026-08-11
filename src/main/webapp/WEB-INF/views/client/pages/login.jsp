<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Áo Vớ Vẩn</title>
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
            padding: 4rem 3rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
            height: 100%;
        }

        .auth-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 3rem;
            font-weight: 800;
            letter-spacing: -0.03em;
            margin-bottom: 0.5rem;
            color: var(--text-main);
        }

        .auth-subtitle {
            color: var(--text-muted);
            font-size: 1.1rem;
            margin-bottom: 3rem;
            font-weight: 400;
        }

        /* Modern Input Styling */
        .form-control-modern {
            padding: 1rem 1.25rem;
            font-size: 1rem;
            background-color: #F1F5F9;
            border: 2px solid transparent;
            border-radius: 16px;
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
            border-radius: 16px;
            padding: 1rem 1.5rem;
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            font-size: 1.1rem;
            letter-spacing: 0.5px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 10px 25px -5px rgba(139, 92, 246, 0.4);
        }

        .btn-modern:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -5px rgba(244, 63, 94, 0.4);
        }

        .btn-modern:active {
            transform: translateY(0);
        }

        /* Social Buttons */
        .btn-social {
            background-color: var(--surface-color);
            border: 2px solid #E2E8F0;
            color: var(--text-main);
            border-radius: 16px;
            padding: 0.85rem;
            font-weight: 600;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .btn-social:hover {
            background-color: #F8FAFC;
            border-color: #CBD5E1;
            transform: translateY(-2px);
        }

        .divider {
            display: flex;
            align-items: center;
            text-align: center;
            margin: 2rem 0;
            color: #94A3B8;
            font-size: 0.9rem;
            font-weight: 500;
        }
        .divider::before, .divider::after {
            content: '';
            flex: 1;
            border-bottom: 2px solid #F1F5F9;
        }
        .divider:not(:empty)::before {
            margin-right: 1em;
        }
        .divider:not(:empty)::after {
            margin-left: 1em;
        }

        /* Right Side Image */
        #auth-right {
            height: 100vh;
            background: url('https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=1400&auto=format&fit=crop') center center / cover no-repeat;
            position: relative;
        }

        #auth-right::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(135deg, rgba(139, 92, 246, 0.2) 0%, rgba(244, 63, 94, 0.4) 100%);
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
            <div class="col-lg-5 col-12 d-flex flex-column">
                <div id="auth-left">
                    <div class="auth-logo mb-5">
                        <a href="<c:url value='/home' />">ÁO VỚ VẦN</a>
                    </div>
                    
                    <h1 class="auth-title">Đăng Nhập</h1>
                    <p class="auth-subtitle">Chào mừng trở lại! Vui lòng nhập thông tin.</p>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" style="border-radius: 12px; font-weight: 500;">
                            <c:out value="${error}" />
                        </div>
                    </c:if>
                    <c:if test="${param.registered eq 'true'}">
                        <div class="alert alert-success" style="border-radius: 12px; font-weight: 500;">
                            Đăng ký thành công! Vui lòng đăng nhập.
                        </div>
                    </c:if>

                    <form action="<c:url value='/login' />" method="post">
                        <div class="form-group mb-4">
                            <input type="text" name="username" class="form-control form-control-modern" placeholder="Tên đăng nhập" required autofocus>
                        </div>
                        <div class="form-group mb-4 position-relative">
                            <input type="password" id="loginPassword" name="password" class="form-control form-control-modern pe-5" placeholder="Mật khẩu" required>
                            <button type="button" class="btn border-0 position-absolute end-0 top-50 translate-middle-y me-2 text-muted p-0 d-flex align-items-center justify-content-center" style="width: 38px; height: 38px; background: transparent; z-index: 10;" onclick="togglePasswordVisibility('loginPassword', this)">
                                <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                </svg>
                            </button>
                        </div>
                        
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="rememberMe">
                                <label class="form-check-label text-muted" for="rememberMe">
                                    Ghi nhớ
                                </label>
                            </div>
                            <a href="#" class="auth-link" style="font-size: 0.9rem;">Quên mật khẩu?</a>
                        </div>

                        <button type="submit" class="btn btn-modern w-100 mb-3">ĐĂNG NHẬP</button>
                        
                        <div class="divider">HOẶC</div>
                        
                        <div class="row g-3 mb-5">
                            <div class="col-6">
                                <button type="button" class="btn w-100 btn-social">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z" fill="#4285F4"/>
                                        <path d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z" fill="#34A853"/>
                                        <path d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z" fill="#FBBC05"/>
                                        <path d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z" fill="#EA4335"/>
                                    </svg>
                                    Google
                                </button>
                            </div>
                            <div class="col-6">
                                <button type="button" class="btn w-100 btn-social">
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M24 12.07C24 5.41 18.63 0 12 0S0 5.4 0 12.07C0 18.1 4.39 23.1 10.13 24v-8.44H7.08v-3.49h3.04V9.41c0-3.02 1.8-4.7 4.54-4.7 1.31 0 2.68.24 2.68.24v2.97h-1.5c-1.5 0-1.96.93-1.96 1.89v2.26h3.32l-.53 3.5h-2.8V24C19.62 23.1 24 18.1 24 12.07" fill="#1877F2"/>
                                    </svg>
                                    Facebook
                                </button>
                            </div>
                        </div>

                    </form>
                    
                    <script>
                        function togglePasswordVisibility(inputId, btn) {
                            const input = document.getElementById(inputId);
                            if (!input) return;
                            const isPassword = input.type === 'password';
                            input.type = isPassword ? 'text' : 'password';
                            btn.innerHTML = isPassword ? `
                                <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858-5.908a10.018 10.018 0 014.122-.988c4.478 0 8.268 2.943 9.542 7a10.025 10.025 0 01-4.132 5.411m0 0L21 21M3 3l18 18" />
                                </svg>
                            ` : `
                                <svg width="20" height="20" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z" />
                                </svg>
                            `;
                        }
                    </script>
                    
                    <div class="text-center mt-auto">
                        <p class="text-muted">Chưa có tài khoản? <a href="<c:url value='/register' />" class="auth-link">Tạo ngay</a>.</p>
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
