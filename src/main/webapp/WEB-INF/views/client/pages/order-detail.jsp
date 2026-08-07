<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<div class="container bg-white p-5 rounded-4 shadow-sm">
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-3">
        <h3 class="font-bold mb-0 text-dark"><i class="bi bi-receipt me-2 text-warning"></i>Chi Tiết Đơn Hàng #${order.id}</h3>
        <a href="<c:url value='/orders' />" class="btn btn-outline-dark btn-sm font-semibold"><i class="bi bi-arrow-left"></i> Quay lại</a>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="font-bold text-dark mb-3">Thông Tin Đơn Hàng</h5>
                <p class="mb-2"><strong>Ngày đặt hàng:</strong> <span class="text-secondary">${order.orderDate}</span></p>
                <p class="mb-2"><strong>Phương thức thanh toán:</strong> <span class="badge bg-dark">${order.paymentMethod}</span></p>
                <p class="mb-0">
                    <strong>Trạng thái:</strong> 
                    <c:choose>
                        <c:when test="${order.status eq 'pending'}"><span class="badge bg-light-warning text-warning">Chờ xác nhận</span></c:when>
                        <c:when test="${order.status eq 'confirmed'}"><span class="badge bg-light-info text-info">Đã xác nhận</span></c:when>
                        <c:when test="${order.status eq 'shipping'}"><span class="badge bg-light-primary text-primary">Đang giao</span></c:when>
                        <c:when test="${order.status eq 'delivered'}"><span class="badge bg-light-success text-success">Đã giao</span></c:when>
                        <c:otherwise><span class="badge bg-light-danger text-danger">${order.status}</span></c:otherwise>
                    </c:choose>
                </p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="p-3 bg-light rounded border h-100">
                <h5 class="font-bold text-dark mb-3">Địa Chỉ Giao Nhận</h5>
                <p class="mb-2"><strong>Địa chỉ giao:</strong> <span class="text-secondary"><c:out value="${order.shippingAddress}"/></span></p>
                <p class="mb-0"><strong>Ghi chú:</strong> <span class="text-secondary"><c:out value="${empty order.note ? 'Không có ghi chú' : order.note}"/></span></p>
            </div>
        </div>
    </div>

    <h5 class="font-bold text-dark mb-3"><i class="bi bi-basket3 me-2 text-warning"></i>Sản Phẩm Đã Mua</h5>
    <div class="table-responsive">
        <table class="table align-middle">
            <thead class="table-light text-secondary">
                <tr>
                    <th class="ps-3">Sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th class="text-end pe-3">Thành tiền</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="d" items="${order.details}">
                    <tr>
                        <td class="ps-3">
                            <div class="d-flex align-items-center">
                                <img src="${empty d.product.imageUrl ? pageContext.request.contextPath.concat('/assets/images/placeholder.svg') : d.product.imageUrl}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg';" class="rounded-3 me-3 border" style="width: 54px; height: 54px; object-fit: cover;">
                                <span class="font-bold text-dark"><c:out value="${d.product.name}"/></span>
                            </div>
                        </td>
                        <td><span class="text-secondary"><fmt:formatNumber value="${d.price}" pattern="#,##0"/> VNĐ</span></td>
                        <td><span class="badge bg-secondary font-semibold">${d.quantity}</span></td>
                        <td class="text-end pe-3 text-danger font-semibold"><fmt:formatNumber value="${d.totalLine}" pattern="#,##0"/> VNĐ</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="text-end border-top mt-4 pt-3">
        <h4 class="font-bold mb-0">Tổng cộng: <span class="text-danger"><fmt:formatNumber value="${order.totalAmount}" pattern="#,##0"/> VNĐ</span></h4>
    </div>
</div>
