<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="vi_VN"/>

<div class="container bg-white p-5 shadow-sm" style="border-radius: 20px; border: 1px solid var(--border-color);">
    <h2 class="font-bold mb-4 text-dark"><i class="bi bi-credit-card me-2" style="color: var(--primary-color);"></i>Thanh Toán Đơn Hàng</h2>

    <c:if test="${not empty error}">
        <div class="alert text-danger rounded-3 mb-4 font-semibold" style="background-color: #FEE2E2; border: 1px solid #FECACA;" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <c:out value="${error}" />
        </div>
    </c:if>

    <form action="<c:url value='/checkout' />" method="post">
        <div class="row g-4">
            <div class="col-md-7">
                <div class="p-4 rounded-3" style="background-color: var(--bg-color); border: 1px solid var(--border-color);">
                    <h5 class="font-bold mb-4 text-dark"><i class="bi bi-truck me-2"></i>Thông tin giao hàng</h5>
                    <div class="mb-3">
                        <label class="form-label font-semibold" style="color: var(--text-muted);">Người nhận</label>
                        <input type="text" class="form-control font-semibold" value="${sessionScope.user.name}" readonly style="border-radius: 12px; background-color: white; border: 1px solid var(--border-color);">
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold" style="color: var(--text-muted);">Số điện thoại</label>
                        <input type="text" class="form-control font-semibold" value="${sessionScope.user.phone}" readonly style="border-radius: 12px; background-color: white; border: 1px solid var(--border-color);">
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold" style="color: var(--text-muted);">Địa chỉ nhận hàng <span class="text-danger">*</span></label>
                        <input type="text" name="shippingAddress" class="form-control font-semibold" value="${sessionScope.user.address}" placeholder="Nhập địa chỉ nhận hàng chi tiết" required style="border-radius: 12px; border: 1px solid var(--border-color);">
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold" style="color: var(--text-muted);">Phương thức thanh toán</label>
                        <select name="paymentMethod" class="form-select font-semibold" style="border-radius: 12px; border: 1px solid var(--border-color);">
                            <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                            <option value="BANK">Chuyển khoản ngân hàng</option>
                        </select>
                    </div>
                    <div class="mb-0">
                        <label class="form-label font-semibold" style="color: var(--text-muted);">Ghi chú đơn hàng</label>
                        <textarea name="note" class="form-control font-semibold" rows="3" placeholder="Ghi chú về thời gian giao, mẫu áo..." style="border-radius: 12px; border: 1px solid var(--border-color);"></textarea>
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="p-4 h-100 rounded-3" style="background-color: var(--bg-color); border: 1px solid var(--border-color);">
                    <h5 class="font-bold mb-4 text-dark"><i class="bi bi-receipt me-2"></i>Tóm tắt đơn hàng</h5>
                    <ul class="list-group list-group-flush mb-4 bg-transparent">
                        <c:forEach var="item" items="${cartItems}">
                            <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent px-0 py-3" style="border-color: var(--border-color);">
                                <div style="max-width: 65%;">
                                    <h6 class="my-0 font-bold text-dark text-truncate"><c:out value="${item.product.name}"/></h6>
                                    <small class="font-semibold" style="color: var(--text-muted);">SL: ${item.quantity} x <fmt:formatNumber value="${item.product.price}" pattern="#,##0"/> VNĐ</small>
                                </div>
                                <span class="font-bold" style="color: var(--primary-color);"><fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,##0"/> VNĐ</span>
                            </li>
                        </c:forEach>
                    </ul>
                    <div class="d-flex justify-content-between align-items-center pt-4 mt-auto" style="border-top: 2px dashed var(--border-color);">
                        <span class="fs-5 font-bold text-dark">Tổng thanh toán:</span>
                        <span class="fs-4 font-bold" style="color: var(--primary-color);"><fmt:formatNumber value="${totalAmount}" pattern="#,##0"/> VNĐ</span>
                    </div>
                    <button type="submit" class="btn btn-warning btn-lg font-bold text-white w-100 mt-4 py-3 text-uppercase" style="border-radius: 12px; box-shadow: 0 4px 15px rgba(244, 63, 94, 0.3);">XÁC NHẬN ĐẶT HÀNG</button>
                </div>
            </div>
        </div>
    </form>
</div>
