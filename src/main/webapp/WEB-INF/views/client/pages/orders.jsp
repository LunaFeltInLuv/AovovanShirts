<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="vi_VN"/>

<div class="container bg-white p-5 shadow-sm" style="border-radius: 20px; border: 1px solid var(--border-color);">
    <h2 class="font-bold mb-4 text-dark"><i class="bi bi-clock-history me-2" style="color: var(--primary-color);"></i>Lịch Sử Đơn Hàng Của Bạn</h2>

    <c:if test="${param.success eq 'true'}">
        <div class="alert alert-dismissible fade show rounded-3 p-3 mb-4 font-semibold" style="background-color: #ECFDF5; color: #047857; border: 1px solid #A7F3D0;" role="alert">
            <i class="bi bi-check-circle-fill me-2"></i>
            Đặt hàng thành công! Đơn hàng của bạn đang chờ xử lý.
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="alert rounded-3 p-4 font-semibold" style="background-color: var(--bg-color); color: var(--text-muted); border: 1px solid var(--border-color);" role="alert">
                <i class="bi bi-info-circle-fill me-2 fs-5" style="color: var(--primary-color);"></i>
                Bạn chưa có đơn hàng nào. <a href="<c:url value='/products' />" class="alert-link font-bold text-decoration-none" style="color: var(--primary-color);">Mua áo ngay!</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table align-middle">
                    <thead style="background-color: var(--bg-color); border-bottom: 2px solid var(--border-color); color: var(--text-muted);">
                        <tr>
                            <th class="ps-3 border-0">Mã đơn</th>
                            <th class="border-0">Ngày đặt</th>
                            <th class="border-0">Tổng tiền</th>
                            <th class="border-0">Trạng thái</th>
                            <th class="border-0">Địa chỉ giao</th>
                            <th class="text-end pe-3 border-0">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="o" items="${orders}">
                            <tr style="border-bottom: 1px solid var(--border-color);">
                                <td class="ps-3 font-bold text-dark border-0">#${o.id}</td>
                                <td class="font-semibold border-0" style="color: var(--text-muted);">${o.orderDate}</td>
                                <td class="border-0"><span class="font-bold" style="color: var(--primary-color);"><fmt:formatNumber value="${o.totalAmount}" pattern="#,##0"/> VNĐ</span></td>
                                <td class="border-0">
                                    <c:choose>
                                        <c:when test="${o.status eq 'pending'}"><span class="badge px-3 py-2 font-semibold" style="background-color: #FEF3C7; color: #B45309; border: 1px solid #FDE68A;">Chờ xác nhận</span></c:when>
                                        <c:when test="${o.status eq 'confirmed'}"><span class="badge px-3 py-2 font-semibold" style="background-color: #E0F2FE; color: #0369A1; border: 1px solid #BAE6FD;">Đã xác nhận</span></c:when>
                                        <c:when test="${o.status eq 'shipping'}"><span class="badge px-3 py-2 font-semibold" style="background-color: #EDE9FE; color: #6D28D9; border: 1px solid #DDD6FE;">Đang giao</span></c:when>
                                        <c:when test="${o.status eq 'delivered'}"><span class="badge px-3 py-2 font-semibold" style="background-color: #D1FAE5; color: #047857; border: 1px solid #A7F3D0;">Đã giao</span></c:when>
                                        <c:otherwise><span class="badge px-3 py-2 font-semibold" style="background-color: #FEE2E2; color: #B91C1C; border: 1px solid #FECACA;">${o.status}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="border-0"><span class="text-truncate d-inline-block font-semibold" style="max-width: 250px; color: var(--text-muted);"><c:out value="${o.shippingAddress}"/></span></td>
                                <td class="text-end pe-3 border-0">
                                    <a href="<c:url value='/order-detail?id=${o.id}' />" class="btn btn-sm font-semibold px-3" style="background-color: var(--bg-color); color: var(--primary-color); border: 1px solid var(--border-color); border-radius: 8px;">Xem chi tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>
