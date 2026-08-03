<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
        <h2 class="font-weight-bold text-dark"><i class="bi bi-grid me-2"></i>Danh Sách Áo Vớ Vẩn</h2>
        <form class="d-flex" action="<c:url value='/products' />" method="get">
            <input class="form-control me-2" type="search" name="keyword" value="${keyword}" placeholder="Tìm kiếm áo..." aria-label="Search">
            <button class="btn btn-warning" type="submit"><i class="bi bi-search"></i> Tìm</button>
        </form>
    </div>

    <div class="row">
        <c:forEach var="p" items="${products}">
            <div class="col-md-3 mb-4">
                <div class="card h-100 shadow-sm border-0">
                    <img src="${empty p.imageUrl ? 'https://via.placeholder.com/300x300?text=Ao+Vo+Van' : p.imageUrl}" class="card-img-top" alt="${p.name}" style="height: 220px; object-fit: cover;">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title font-weight-bold"><c:out value="${p.name}"/></h5>
                        <p class="text-muted small mb-1"><c:out value="${p.category}"/></p>
                        <p class="card-text text-danger font-weight-bold fs-5">${p.price} VNĐ</p>
                        <div class="mt-auto d-flex justify-content-between">
                            <a href="<c:url value='/product-detail?id=${p.id}' />" class="btn btn-outline-dark btn-sm">Xem chi tiết</a>
                            <form action="<c:url value='/cart/add' />" method="post">
                                <input type="hidden" name="productId" value="${p.id}">
                                <button type="submit" class="btn btn-warning btn-sm"><i class="bi bi-cart-plus"></i> Thêm</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
