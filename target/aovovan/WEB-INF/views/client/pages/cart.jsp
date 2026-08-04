<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container bg-white p-5 rounded-4 shadow-sm">
    <h2 class="font-bold mb-4 text-dark"><i class="bi bi-cart4 text-warning me-2"></i>Giỏ Hàng Của Bạn</h2>

    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="alert bg-light-info text-info rounded-3 p-4" role="alert">
                <i class="bi bi-info-circle-fill me-2 fs-5"></i>
                Giỏ hàng của bạn đang trống! <a href="<c:url value='/products' />" class="alert-link font-bold text-decoration-none">Vào cửa hàng mua áo ngay.</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table align-middle">
                    <thead class="table-light text-secondary">
                        <tr>
                            <th class="ps-3">Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th style="width: 160px;">Số lượng</th>
                            <th>Thành tiền</th>
                            <th class="text-end pe-3">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="totalSum" value="0" />
                        <c:forEach var="item" items="${cartItems}">
                            <c:set var="lineTotal" value="${item.product.price * item.quantity}" />
                            <c:set var="totalSum" value="${totalSum + lineTotal}" />
                            <tr>
                                <td class="ps-3">
                                    <div class="d-flex align-items-center">
                                        <img src="${empty item.product.imageUrl ? 'https://via.placeholder.com/80?text=Shirt' : item.product.imageUrl}" class="rounded-3 me-3 border" style="width: 64px; height: 64px; object-fit: cover;">
                                        <div>
                                            <h6 class="mb-0 font-bold text-dark"><c:out value="${item.product.name}"/></h6>
                                        </div>
                                    </div>
                                </td>
                                <td><span class="font-semibold text-secondary">${item.product.price} VNĐ</span></td>
                                <td>
                                    <form action="<c:url value='/cart/update' />" method="post" class="d-flex align-items-center">
                                        <input type="hidden" name="productId" value="${item.productId}">
                                        <input type="number" name="quantity" class="form-control form-control-sm text-center me-1" value="${item.quantity}" min="1" max="${item.product.stockQuantity}" style="width: 60px; height: 32px; border-radius: 6px;">
                                        <button type="submit" class="btn btn-light-primary btn-sm px-2" title="Cập nhật"><i class="bi bi-arrow-clockwise"></i></button>
                                    </form>
                                </td>
                                <td><span class="text-danger font-semibold">${lineTotal} VNĐ</span></td>
                                <td class="text-end pe-3">
                                    <form action="<c:url value='/cart/remove' />" method="post" class="d-inline">
                                        <input type="hidden" name="productId" value="${item.productId}">
                                        <button type="submit" class="btn btn-light-danger btn-sm font-semibold px-3">
                                            <i class="bi bi-trash-fill me-1"></i> Xóa
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mt-5 pt-4 border-top gap-3">
                <a href="<c:url value='/products' />" class="btn btn-outline-dark font-semibold"><i class="bi bi-arrow-left me-1"></i> Tiếp tục mua hàng</a>
                <div class="text-end">
                    <h4 class="font-bold text-dark">Tổng tiền: <span class="text-danger">${totalSum} VNĐ</span></h4>
                    <a href="<c:url value='/checkout' />" class="btn btn-warning btn-lg font-bold text-white mt-2 px-4 py-2 text-uppercase">
                        TIẾN HÀNH THANH TOÁN <i class="bi bi-credit-card-2-back ms-2"></i>
                    </a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
