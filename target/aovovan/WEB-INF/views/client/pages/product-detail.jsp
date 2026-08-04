<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container bg-white p-5 rounded-4 shadow-sm">
    <div class="row g-5">
        <div class="col-md-5">
            <div class="p-2 border rounded-4 bg-light d-flex align-items-center justify-content-center overflow-hidden">
                <img src="${empty product.imageUrl ? 'https://via.placeholder.com/400x400?text=Ao+Vo+Van' : product.imageUrl}" class="img-fluid rounded-3" alt="${product.name}" style="max-height: 420px; object-fit: cover;">
            </div>
        </div>
        <div class="col-md-7 d-flex flex-column justify-content-center">
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="<c:url value='/home' />" class="text-warning text-decoration-none font-semibold">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="<c:url value='/products' />" class="text-warning text-decoration-none font-semibold">Sản phẩm</a></li>
                    <li class="breadcrumb-item active" aria-current="page"><c:out value="${product.name}"/></li>
                </ol>
            </nav>
            <h1 class="font-bold text-dark mb-2"><c:out value="${product.name}"/></h1>
            <div class="d-flex align-items-center gap-2 mb-3">
                <span class="badge bg-light-secondary text-secondary px-3 py-2 font-semibold"><c:out value="${product.category}"/></span>
                <span class="badge bg-light-success text-success px-3 py-2 font-semibold">Tồn kho: ${product.stockQuantity}</span>
            </div>
            <h2 class="text-danger font-bold my-3">${product.price} VNĐ</h2>
            <div class="mb-4">
                <h6 class="font-bold text-secondary mb-2">Mô tả sản phẩm:</h6>
                <p class="text-secondary mb-0" style="line-height: 1.6;"><c:out value="${product.description}"/></p>
            </div>

            <form action="<c:url value='/cart/add' />" method="post" class="mt-2 border-top pt-4">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="d-flex align-items-center gap-3 mb-3">
                    <label class="form-label font-bold text-secondary mb-0">Số lượng mua:</label>
                    <input type="number" name="quantity" class="form-control text-center" value="1" min="1" max="${product.stockQuantity}" style="width: 80px; height: 42px; border-radius: 8px;">
                </div>
                <button type="submit" class="btn btn-warning btn-lg font-bold text-white px-4 py-2 w-100 w-md-auto">
                    <i class="bi bi-cart-plus-fill me-2"></i> THÊM VÀO GIỎ HÀNG
                </button>
            </form>
        </div>
    </div>
</div>
