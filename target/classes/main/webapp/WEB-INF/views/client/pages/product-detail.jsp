<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<div class="container bg-white p-5 shadow-sm" style="border-radius: 20px; border: 1px solid var(--border-color);">
    <div class="row g-5">
        <div class="col-md-5">
            <div class="p-2 border rounded-4 d-flex align-items-center justify-content-center overflow-hidden" style="background-color: var(--bg-color); border-color: var(--border-color) !important;">
                <img src="${empty product.imageUrl ? pageContext.request.contextPath.concat('/assets/images/placeholder.svg') : product.imageUrl}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg';" class="img-fluid rounded-3" alt="${product.name}" style="max-height: 420px; object-fit: cover;">
            </div>
        </div>
        <div class="col-md-7 d-flex flex-column justify-content-center">
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="<c:url value='/home' />" class="text-decoration-none font-semibold" style="color: var(--text-muted);">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="<c:url value='/products' />" class="text-decoration-none font-semibold" style="color: var(--text-muted);">Sản phẩm</a></li>
                    <li class="breadcrumb-item active font-semibold" aria-current="page" style="color: var(--primary-color);"><c:out value="${product.name}"/></li>
                </ol>
            </nav>
            <h1 class="font-bold text-dark mb-2"><c:out value="${product.name}"/></h1>
            <div class="d-flex align-items-center gap-2 mb-3">
                <span class="badge px-3 py-2 font-semibold" style="background-color: var(--bg-color); color: var(--text-muted); border: 1px solid var(--border-color);"><c:out value="${product.category}"/></span>
                <span class="badge px-3 py-2 font-semibold" style="background-color: #ECFDF5; color: #047857; border: 1px solid #A7F3D0;">Tồn kho: ${product.stockQuantity}</span>
            </div>
            <h2 class="font-bold my-3" style="color: var(--primary-color);"><fmt:formatNumber value="${product.price}" pattern="#,##0"/> VNĐ</h2>
            <div class="mb-4">
                <h6 class="font-bold mb-2" style="color: var(--text-muted);">Mô tả sản phẩm:</h6>
                <p class="mb-0" style="color: var(--text-muted); line-height: 1.6;"><c:out value="${product.description}"/></p>
            </div>

            <form action="<c:url value='/cart/add' />" method="post" class="mt-2 border-top pt-4" style="border-color: var(--border-color) !important;">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="d-flex align-items-center gap-3 mb-4">
                    <label class="form-label font-bold mb-0" style="color: var(--text-muted);">Số lượng mua:</label>
                    <input type="number" name="quantity" class="form-control text-center font-semibold" value="1" min="1" max="${product.stockQuantity}" style="width: 90px; height: 45px; border-radius: 12px; background-color: var(--bg-color); border: 1px solid var(--border-color); color: var(--text-main);">
                </div>
                <button type="submit" class="btn btn-warning btn-lg font-bold text-white px-4 py-3 w-100 w-md-auto" style="border-radius: 12px;">
                    <i class="bi bi-cart-plus-fill me-2"></i> THÊM VÀO GIỎ HÀNG
                </button>
            </form>
        </div>
    </div>
</div>
