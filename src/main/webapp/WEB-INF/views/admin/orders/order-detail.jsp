<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="card shadow-sm border-0 p-4">
    <div class="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
        <h4 class="card-title mb-0">Chi Tiết Đơn Hàng #${order.id} (Admin)</h4>
        <a href="<c:url value='/admin/orders' />" class="btn btn-secondary btn-sm"><i class="bi bi-arrow-left"></i> Quay lại</a>
    </div>

    <div class="row mb-3">
        <div class="col-md-6">
            <p><strong>Khách hàng ID:</strong> ${order.userId}</p>
            <p><strong>Ngày tạo đơn:</strong> ${order.orderDate}</p>
            <p><strong>Trạng thái:</strong> <span class="badge bg-warning text-dark">${order.status}</span></p>
        </div>
        <div class="col-md-6">
            <p><strong>Địa chỉ nhận hàng:</strong> <c:out value="${order.shippingAddress}"/></p>
            <p><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</p>
            <p><strong>Ghi chú:</strong> <c:out value="${empty order.note ? 'Không' : order.note}"/></p>
        </div>
    </div>

    <h5 class="font-weight-bold mb-3">Mặt hàng mua</h5>
    <table class="table align-middle">
        <thead class="table-dark">
            <tr>
                <th>Mã SP</th>
                <th>Tên sản phẩm</th>
                <th>Đơn giá</th>
                <th>Số lượng</th>
                <th>Thành tiền</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="d" items="${order.details}">
                <tr>
                    <td>${d.productId}</td>
                    <td>
                        <div class="d-flex align-items-center">
                            <img src="${empty d.product.imageUrl ? 'https://via.placeholder.com/50?text=Shirt' : d.product.imageUrl}" class="rounded me-2" style="width: 40px; height: 40px; object-fit: cover;">
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
        <h4 class="font-weight-bold">Tổng đơn hàng: <span class="text-danger">${order.totalAmount} VNĐ</span></h4>
    </div>
</div>
