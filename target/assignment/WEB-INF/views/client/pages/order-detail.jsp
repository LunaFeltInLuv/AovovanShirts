<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container bg-white p-4 rounded shadow-sm">
    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
        <h3 class="font-weight-bold mb-0">Chi Tiết Đơn Hàng #${order.id}</h3>
        <a href="<c:url value='/orders' />" class="btn btn-outline-secondary btn-sm"><i class="bi bi-arrow-left"></i> Quay lại</a>
    </div>

    <div class="row mb-4">
        <div class="col-md-6">
            <p><strong>Ngày đặt:</strong> ${order.orderDate}</p>
            <p><strong>Trạng thái:</strong> <span class="badge bg-warning text-dark">${order.status}</span></p>
            <p><strong>Phương thức TT:</strong> ${order.paymentMethod}</p>
        </div>
        <div class="col-md-6">
            <p><strong>Địa chỉ giao:</strong> <c:out value="${order.shippingAddress}"/></p>
            <p><strong>Ghi chú:</strong> <c:out value="${empty order.note ? 'Không có' : order.note}"/></p>
        </div>
    </div>

    <h5 class="font-weight-bold mb-3">Sản phẩm đã mua</h5>
    <table class="table align-middle">
        <thead class="table-light">
            <tr>
                <th>Sản phẩm</th>
                <th>Đơn giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="d" items="${order.details}">
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <img src="${empty d.product.imageUrl ? 'https://via.placeholder.com/60?text=Shirt' : d.product.imageUrl}" class="img-thumbnail me-2" style="width: 50px; height: 50px; object-fit: cover;">
                            <span><c:out value="${d.product.name}"/></span>
                        </div>
                    </td>
                    <td>${d.price} VNĐ</td>
                    <td>${d.quantity}</td>
                    <td class="text-danger font-weight-bold">${d.totalLine} VNĐ</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="text-end border-top pt-3">
        <h4 class="font-weight-bold">Tổng cộng: <span class="text-danger">${order.totalAmount} VNĐ</span></h4>
    </div>
</div>
