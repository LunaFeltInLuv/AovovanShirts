<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container bg-white p-5 rounded-4 shadow-sm">
    <h2 class="font-bold mb-4 text-dark"><i class="bi bi-clock-history text-warning me-2"></i>Lịch Sử Đơn Hàng Của Bạn</h2>

    <c:if test="${param.success eq 'true'}">
        <div class="alert bg-light-success text-success alert-dismissible fade show rounded-3 p-3 mb-4" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>
            Đặt hàng thành công! Đơn hàng của bạn đang chờ xử lý.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="alert bg-light-info text-info rounded-3 p-4" role="alert">
                <i class="bi bi-info-circle-fill me-2 fs-5"></i>
                Bạn chưa có đơn hàng nào. <a href="<c:url value='/products' />" class="alert-link font-bold text-decoration-none text-warning">Mua áo ngay!</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light text-secondary">
                        <tr>
                            <th class="ps-3">Mã đơn</th>
                            <th>Ngày đặt</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                            <th>Địa chỉ giao</th>
                            <th class="text-end pe-3">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td class="ps-3 font-bold text-dark">#${o.id}</td>
                                <td>${o.orderDate}</td>
                                <td><span class="text-danger font-semibold">${o.totalAmount} VNĐ</span></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.status eq 'pending'}"><span class="badge bg-light-warning text-warning">Chờ xác nhận</span></c:when>
                                        <c:when test="${o.status eq 'confirmed'}"><span class="badge bg-light-info text-info">Đã xác nhận</span></c:when>
                                        <c:when test="${o.status eq 'shipping'}"><span class="badge bg-light-primary text-primary">Đang giao</span></c:when>
                                        <c:when test="${o.status eq 'delivered'}"><span class="badge bg-light-success text-success">Đã giao</span></c:when>
                                        <c:otherwise><span class="badge bg-light-danger text-danger">${o.status}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td><span class="text-truncate d-inline-block" style="max-width: 250px;"><c:out value="${o.shippingAddress}"/></span></td>
                                <td class="text-end pe-3">
                                    <a href="<c:url value='/order-detail?id=${o.id}' />" class="btn btn-light-primary btn-sm font-semibold">Xem chi tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>
