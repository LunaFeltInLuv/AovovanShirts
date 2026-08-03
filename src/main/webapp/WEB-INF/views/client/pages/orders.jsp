<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container bg-white p-4 rounded shadow-sm">
    <h2 class="font-weight-bold mb-4"><i class="bi bi-clock-history text-warning me-2"></i>Lịch Sử Đơn Hàng Của Bạn</h2>

    <c:if test="${param.success eq 'true'}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            Đặt hàng thành công! Đơn hàng của bạn đang chờ xử lý.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="alert alert-info" role="alert">
                Bạn chưa có đơn hàng nào. <a href="<c:url value='/products' />" class="alert-link">Mua áo ngay!</a>
            </div>
        </c:when>
        <c:otherwise>
            <table class="table table-hover align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Mã đơn</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                        <th>Trạng thái</th>
                        <th>Địa chỉ giao</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="o" items="${orders}">
                        <tr>
                            <td><strong>#${o.id}</strong></td>
                            <td>${o.orderDate}</td>
                            <td class="text-danger font-weight-bold">${o.totalAmount} VNĐ</td>
                            <td>
                                <c:choose>
                                    <c:when test="${o.status eq 'pending'}"><span class="badge bg-warning text-dark">Chờ xác nhận</span></c:when>
                                    <c:when test="${o.status eq 'confirmed'}"><span class="badge bg-info text-dark">Đã xác nhận</span></c:when>
                                    <c:when test="${o.status eq 'shipping'}"><span class="badge bg-primary">Đang giao</span></c:when>
                                    <c:when test="${o.status eq 'delivered'}"><span class="badge bg-success">Đã giao</span></c:when>
                                    <c:otherwise><span class="badge bg-secondary">${o.status}</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:out value="${o.shippingAddress}"/></td>
                            <td>
                                <a href="<c:url value='/order-detail?id=${o.id}' />" class="btn btn-outline-dark btn-sm">Xem chi tiết</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
