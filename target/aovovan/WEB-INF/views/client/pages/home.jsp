<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <fmt:setLocale value="vi_VN" />

            <!-- Hero Banner with Modern Minimalist Aesthetics -->
            <div class="jumbotron p-4 p-md-5 mb-5 text-white position-relative overflow-hidden"
                style="background: var(--primary-gradient); border-radius: 20px; box-shadow: 0 10px 30px -10px rgba(139, 92, 246, 0.4);">
                <div class="position-absolute top-0 end-0 w-50 h-100 opacity-25 d-none d-md-block"
                    style="background: radial-gradient(circle at 70% 30%, rgba(255,255,255,0.3) 0%, transparent 60%); pointer-events: none;">
                </div>
                <div class="container position-relative z-1 py-3">
                    <span class="badge text-white font-semibold px-3 py-2 mb-3"
                        style="background-color: rgba(255,255,255,0.2) !important; backdrop-filter: blur(4px); border-radius: 8px;">BST
                        2026</span>
                    <h1 class="display-5 font-bold mb-3 text-white"
                        style="font-family: 'Montserrat', sans-serif; letter-spacing: -0.03em;">Thời Trang Độc Lạ
                        <br />ÁO VỚ VẦN</h1>
                    <p class="lead mb-4 text-white-50" style="max-width: 600px; font-weight: 500;">Bộ sưu tập áo thời
                        trang cực ngầu, thiết kế độc bản và chất lượng cao dành cho thế hệ trẻ năng động.</p>
                    <a class="btn btn-light btn-lg font-bold px-4 py-2 text-uppercase"
                        href="<c:url value='/products' />" role="button"
                        style="color: var(--primary-color) !important; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.1);">
                        Khám phá ngay <i class="bi bi-arrow-right ms-2"></i>
                    </a>
                </div>
            </div>

            <div class="container px-0">
                <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
                    <h3 class="font-bold text-dark mb-0 fs-4"><i class="bi bi-fire me-2"
                            style="color: var(--accent-color);"></i>Sản Phẩm Mới Nhất</h3>
                    <a href="<c:url value='/products' />" class="text-decoration-none font-semibold"
                        style="color: var(--primary-color) !important;">Xem tất cả <i
                            class="bi bi-chevron-right fs-7"></i></a>
                </div>

                <div class="row g-3 g-md-4">
                    <c:forEach var="p" items="${products}">
                        <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                            <div class="card h-100 border-0 position-relative">
                                <div class="position-relative overflow-hidden" style="border-radius: 16px 16px 0 0;">
                                    <img src="${empty p.imageUrl ? pageContext.request.contextPath.concat('/assets/images/placeholder.svg') : p.imageUrl}"
                                        onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg';"
                                        class="card-img-top" alt="${p.name}"
                                        style="height: 240px; object-fit: cover; transition: transform 0.3s ease;">
                                    <span class="badge position-absolute px-3 py-2 font-semibold shadow-sm"
                                        style="top: 12px; left: 12px; background: var(--accent-color); border-radius: 8px;">Hot</span>
                                </div>
                                <div class="card-body d-flex flex-column p-3 p-md-4">
                                    <span class="small text-uppercase font-semibold mb-1"
                                        style="color: var(--text-muted);">
                                        <c:out value="${p.category}" />
                                    </span>
                                    <h5 class="card-title text-dark font-bold mb-2 fs-6">
                                        <a href="<c:url value='/product-detail?id=${p.id}' />"
                                            class="text-decoration-none text-dark">
                                            <c:out value="${p.name}" />
                                        </a>
                                    </h5>
                                    <p class="card-text font-bold fs-5 mb-3"
                                        style="color: var(--primary-color) !important;">
                                        <fmt:formatNumber value="${p.price}" pattern="#,##0" /> VNĐ
                                    </p>
                                    <div class="mt-auto d-flex justify-content-between gap-2 position-relative z-1">
                                        <a href="<c:url value='/product-detail?id=${p.id}' />"
                                            class="btn btn-outline-warning btn-sm font-semibold flex-grow-1">Chi
                                            tiết</a>
                                        <form action="<c:url value='/cart/add' />" method="post" class="d-inline">
                                            <input type="hidden" name="productId" value="${p.id}">
                                            <button type="submit" class="btn btn-warning btn-sm px-3"
                                                title="Thêm vào giỏ"><i class="bi bi-cart-plus-fill"></i></button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>