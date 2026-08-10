<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <fmt:setLocale value="vi_VN" />

            <div class="container">
                <div
                    class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 border-bottom pb-3 gap-3">
                    <h2 class="font-bold text-dark mb-0 fs-3"><i class="bi bi-grid me-2"
                            style="color: var(--accent-color);"></i>Danh Sách Sản Phẩm</h2>
                    <form action="<c:url value='/products' />" method="get" style="max-width: 350px; width: 100%;">
                        <div class="input-group rounded-3" style="box-shadow: 0 4px 12px rgba(0,0,0,0.05);">
                            <input class="form-control" type="search" name="keyword" value="${keyword}"
                                placeholder="Tìm kiếm áo..." aria-label="Search"
                                style="border-color: var(--border-color); border-radius: 12px 0 0 12px; padding: 0.75rem 1rem;">
                            <button class="btn btn-warning px-3" type="submit" style="border-radius: 0 12px 12px 0;"><i
                                    class="bi bi-search"></i> Tìm</button>
                        </div>
                    </form>
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
                                </div>
                                <div class="card-body d-flex flex-column p-3 p-md-4">
                                    <span class="small text-uppercase font-semibold mb-1"
                                        style="color: var(--text-muted);">
                                        <c:out value="${p.category}" />
                                    </span>

                                    <h5 class="card-title text-dark font-bold mb-2 fs-6">
                                        <c:out value="${p.name}" />
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