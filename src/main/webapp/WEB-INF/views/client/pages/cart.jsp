<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container bg-white p-4 rounded shadow-sm">
    <h2 class="font-weight-bold mb-4"><i class="bi bi-cart4 text-warning me-2"></i>Giỏ Hàng Của Bạn</h2>

    <c:choose>
        <c:when test="${empty cartItems}">
            <div class="alert alert-info" role="alert">
                Giỏ hàng của bạn đang trống! <a href="<c:url value='/products' />" class="alert-link">Vào cửa hàng mua áo ngay.</a>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th style="width: 150px;">Số lượng</th>
                        <th>Thành tiền</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="totalSum" value="0" />
                    <c:forEach var="item" items="${cartItems}">
                        <c:set var="lineTotal" value="${item.product.price * item.quantity}" />
                        <c:set var="totalSum" value="${totalSum + lineTotal}" />
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="${empty item.product.imageUrl ? 'https://via.placeholder.com/80?text=Shirt' : item.product.imageUrl}" class="img-thumbnail me-3" style="width: 60px; height: 60px; object-fit: cover;">
                                    <div>
                                        <h6 class="mb-0 font-weight-bold"><c:out value="${item.product.name}"/></h6>
                                    </div>
                                </div>
                            </td>
                            <td class="text-danger font-weight-bold">${item.product.price} VNĐ</td>
                            <td>
                                <form action="<c:url value='/cart/update' />" method="post" class="d-flex">
                                    <input type="hidden" name="productId" value="${item.productId}">
                                    <input type="number" name="quantity" class="form-control form-control-sm me-1" value="${item.quantity}" min="1" max="${item.product.stockQuantity}">
                                    <button type="submit" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-clockwise"></i></button>
                                </form>
                            </td>
                            <td class="text-danger font-weight-bold">${lineTotal} VNĐ</td>
                            <td>
                                <form action="<c:url value='/cart/remove' />" method="post">
                                    <input type="hidden" name="productId" value="${item.productId}">
                                    <button type="submit" class="btn btn-outline-danger btn-sm"><i class="bi bi-trash"></i> Xóa</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                <a href="<c:url value='/products' />" class="btn btn-outline-dark"><i class="bi bi-arrow-left"></i> Tiếp tục mua hàng</a>
                <div class="text-end">
                    <h4 class="font-weight-bold">Tổng tiền: <span class="text-danger">${totalSum} VNĐ</span></h4>
                    <a href="<c:url value='/checkout' />" class="btn btn-warning btn-lg font-weight-bold text-dark mt-2">TIẾN HÀNH THANH TOÁN <i class="bi bi-credit-card ms-1"></i></a>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
</div>
