<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<div class="container bg-white p-5 shadow-sm" style="border-radius: 20px; border: 1px solid var(--border-color);">
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
        <h3 class="font-bold mb-0 text-dark"><i class="bi bi-receipt me-2" style="color: var(--primary-color);"></i>Chi Tiết Đơn Hàng #${order.id}</h3>
        <a href="<c:url value='/orders' />" class="btn btn-sm font-semibold px-3" style="background-color: var(--bg-color); color: var(--text-main); border: 1px solid var(--border-color); border-radius: 8px;"><i class="bi bi-arrow-left"></i> Quay lại</a>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-md-6">
            <div class="p-4 rounded-3 h-100" style="background-color: var(--bg-color); border: 1px solid var(--border-color);">
                <h5 class="font-bold text-dark mb-3">Thông Tin Đơn Hàng</h5>
                <p class="mb-2 font-semibold"><strong>Ngày đặt hàng:</strong> <span style="color: var(--text-muted);">${order.orderDate}</span></p>
                <p class="mb-2 font-semibold"><strong>Phương thức thanh toán:</strong> <span class="badge px-3 py-2" style="background-color: #F1F5F9; color: #475569; border: 1px solid #E2E8F0;">${order.paymentMethod}</span></p>
                <p class="mb-0 font-semibold">
                    <strong>Trạng thái:</strong> 
                    <c:choose>
                        <c:when test="${order.status eq 'pending'}"><span class="badge px-3 py-2 font-semibold" style="background-color: #FEF3C7; color: #B45309; border: 1px solid #FDE68A;">Chờ xác nhận</span></c:when>
                        <c:when test="${order.status eq 'confirmed'}"><span class="badge px-3 py-2 font-semibold" style="background-color: #E0F2FE; color: #0369A1; border: 1px solid #BAE6FD;">Đã xác nhận</span></c:when>
                        <c:when test="${order.status eq 'shipping'}"><span class="badge px-3 py-2 font-semibold" style="background-color: #EDE9FE; color: #6D28D9; border: 1px solid #DDD6FE;">Đang giao</span></c:when>
                        <c:when test="${order.status eq 'delivered'}"><span class="badge px-3 py-2 font-semibold" style="background-color: #D1FAE5; color: #047857; border: 1px solid #A7F3D0;">Đã giao</span></c:when>
                        <c:otherwise><span class="badge px-3 py-2 font-semibold" style="background-color: #FEE2E2; color: #B91C1C; border: 1px solid #FECACA;">${order.status}</span></c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-4 rounded-3 h-100" style="background-color: var(--bg-color); border: 1px solid var(--border-color);">
                <h5 class="font-bold text-dark mb-3">Địa Chỉ Giao Nhận</h5>
                <p class="mb-2 font-semibold"><strong>Địa chỉ giao:</strong> <span style="color: var(--text-muted);"><c:out value="${order.shippingAddress}"/></span></p>
                <p class="mb-0 font-semibold"><strong>Ghi chú:</strong> <span style="color: var(--text-muted);"><c:out value="${empty order.note ? 'Không có ghi chú' : order.note}"/></span></p>
            </div>
        </div>
    </div>

    <h5 class="font-bold text-dark mb-3 mt-5"><i class="bi bi-basket3 me-2" style="color: var(--primary-color);"></i>Sản Phẩm Đã Mua</h5>
    <div class="table-responsive">
        <table class="table align-middle">
            <thead style="background-color: var(--bg-color); border-bottom: 2px solid var(--border-color); color: var(--text-muted);">
                <tr>
                    <th class="ps-3 border-0">Sản phẩm</th>
                    <th class="border-0">Đơn giá</th>
                    <th class="border-0">Số lượng</th>
                    <th class="text-end pe-3 border-0">Thành tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="d" items="${order.details}">
                    <tr style="border-bottom: 1px solid var(--border-color);">
                        <td class="ps-3 py-3 border-0">
                            <div class="d-flex align-items-center">
                                <img src="${empty d.product.imageUrl ? pageContext.request.contextPath.concat('/assets/images/placeholder.svg') : d.product.imageUrl}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg';" class="rounded-3 me-3" style="width: 54px; height: 54px; object-fit: cover; border: 1px solid var(--border-color);">
                                <span class="font-bold text-dark"><c:out value="${d.product.name}"/></span>
                            </div>
                        </td>
                        <td class="border-0"><span class="font-semibold" style="color: var(--text-muted);"><fmt:formatNumber value="${d.price}" pattern="#,##0"/> VNĐ</span></td>
                        <td class="border-0"><span class="badge px-3 py-2 font-semibold" style="background-color: var(--bg-color); color: var(--text-muted); border: 1px solid var(--border-color);">${d.quantity}</span></td>
                        <td class="text-end pe-3 font-bold border-0" style="color: var(--primary-color);"><fmt:formatNumber value="${d.totalLine}" pattern="#,##0"/> VNĐ</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="text-end border-top mt-4 pt-4" style="border-color: var(--border-color) !important;">
        <h4 class="font-bold mb-0 text-dark">Tổng cộng: <span style="color: var(--primary-color);"><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VNĐ</span></h4>
    </div>
</div>
