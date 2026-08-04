<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 border-bottom pb-3 gap-3">
        <h2 class="font-bold text-dark mb-0"><i class="bi bi-grid me-2 text-warning"></i>Danh Sách Sản Phẩm</h2>
        <form action="<c:url value='/products' />" method="get" style="max-width: 350px; width: 100%;">
            <div class="input-group shadow-sm rounded">
                <input class="form-control" type="search" name="keyword" value="${keyword}" placeholder="Tìm kiếm áo..." aria-label="Search">
                <button class="btn btn-warning px-3" type="submit"><i class="bi bi-search"></i> Tìm</button>
            </div>
        </form>
    </div>

    <div class="row">
        <c:forEach var="p" items="${products}">
            <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                <div class="card h-100 shadow-sm border-0 bg-white">
                    <div class="position-relative overflow-hidden">
                        <img src="${empty p.imageUrl ? 'https://via.placeholder.com/300x300?text=Ao+Vo+Van' : p.imageUrl}" class="card-img-top" alt="${p.name}" style="height: 240px; object-fit: cover;">
                    </div>
                    <div class="card-body d-flex flex-column p-4">
                        <span class="text-muted small text-uppercase font-semibold mb-1"><c:out value="${p.category}"/></span>
                        <h5 class="card-title text-dark font-bold mb-2"><c:out value="${p.name}"/></h5>
                        <p class="card-text text-danger font-bold fs-5 mb-3">${p.price} VNĐ</p>
                        <div class="mt-auto d-flex justify-content-between gap-2">
                            <a href="<c:url value='/product-detail?id=${p.id}' />" class="btn btn-outline-dark btn-sm font-semibold flex-grow-1">Chi tiết</a>
                            <form action="<c:url value='/cart/add' />" method="post" class="d-inline">
                                <input type="hidden" name="productId" value="${p.id}">
                                <button type="submit" class="btn btn-warning btn-sm px-3"><i class="bi bi-cart-plus-fill"></i></button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
