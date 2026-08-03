<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container bg-white p-4 rounded shadow-sm">
    <div class="row">
        <div class="col-md-5">
            <img src="${empty product.imageUrl ? 'https://via.placeholder.com/400x400?text=Ao+Vo+Van' : product.imageUrl}" class="img-fluid rounded border" alt="${product.name}">
        </div>
        <div class="col-md-7">
            <h2 class="font-weight-bold text-dark"><c:out value="${product.name}"/></h2>
            <p class="badge bg-warning text-dark me-2"><c:out value="${product.category}"/></p>
            <p class="badge bg-secondary">Tồn kho: ${product.stockQuantity}</p>
            <h3 class="text-danger font-weight-bold my-3">${product.price} VNĐ</h3>
            <p class="text-secondary"><c:out value="${product.description}"/></p>

            <form action="<c:url value='/cart/add' />" method="post" class="mt-4">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="row g-3 align-items-center mb-3">
                    <div class="col-auto">
                        <label class="col-form-label font-weight-bold">Số lượng:</label>
                    </div>
                    <div class="col-auto">
                        <input type="number" name="quantity" class="form-control" value="1" min="1" max="${product.stockQuantity}" style="width: 100px;">
                    </div>
                </div>
                <button type="submit" class="btn btn-warning btn-lg text-dark font-weight-bold"><i class="bi bi-cart-plus me-1"></i> Thêm vào giỏ hàng</button>
            </form>
        </div>
    </div>
</div>
