<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Hero Banner styled with Liquid Glass aesthetics -->
<div class="jumbotron p-5 rounded-4 shadow-sm mb-5 text-white position-relative overflow-hidden" 
     style="background: linear-gradient(135deg, #1C1917 0%, #44403C 100%); border: 1px solid rgba(255,255,255,0.1);">
    <div class="position-absolute top-0 start-0 w-100 h-100 opacity-25" 
         style="background: radial-gradient(circle at 80% 20%, #A16207 0%, transparent 50%); pointer-events: none;"></div>
    <div class="container position-relative z-1 py-3">
        <h1 class="display-4 font-bold mb-2">Thời Trang Độc Lạ - ÁO VỚ VẦN</h1>
        <p class="lead text-white-50 mb-4" style="max-width: 600px;">Bộ sưu tập áo thời trang cực ngầu, thiết kế độc bản và chất lượng cao dành cho thế hệ trẻ năng động.</p>
        <hr class="my-4 border-white-50 opacity-25">
        <a class="btn btn-warning btn-lg font-semibold px-4 py-2 text-uppercase" href="<c:url value='/products' />" role="button">
            Khám phá ngay <i class="bi bi-arrow-right ms-2"></i>
        </a>
    </div>
</div>

<div class="container px-0">
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
        <h3 class="font-bold text-dark mb-0"><i class="bi bi-fire text-danger me-2"></i>Sản Phẩm Mới Nhất</h3>
        <a href="<c:url value='/products' />" class="text-warning text-decoration-none font-semibold">Xem tất cả <i class="bi bi-chevron-right fs-7"></i></a>
    </div>
    
    <div class="row">
        <c:forEach var="p" items="${products}">
            <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                <div class="card h-100 shadow-sm border-0 bg-white">
                    <div class="position-relative overflow-hidden">
                        <img src="${empty p.imageUrl ? 'https://via.placeholder.com/300x300?text=Ao+Vo+Van' : p.imageUrl}" class="card-img-top" alt="${p.name}" style="height: 240px; object-fit: cover; transition: transform 0.5s ease;">
                        <span class="badge bg-dark position-absolute top-3 start-3 px-3 py-2 font-semibold shadow-sm" style="top: 15px; left: 15px;">Hot</span>
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
