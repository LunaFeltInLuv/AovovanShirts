<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN"/>

<div class="container bg-white p-5 rounded-4 shadow-sm">
    <h2 class="font-bold mb-4 text-dark"><i class="bi bi-credit-card text-warning me-2"></i>Thanh Toán Đơn Hàng</h2>

    <c:if test="${not empty error}">
        <div class="alert bg-light-danger text-danger rounded-3 mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            <c:out value="${error}" />
        </div>
    </c:if>

    <form action="<c:url value='/checkout' />" method="post">
        <div class="row g-4">
            <div class="col-md-7">
                <div class="p-3 bg-light rounded-3 border">
                    <h5 class="font-bold mb-3 text-dark"><i class="bi bi-truck me-2"></i>Thông tin giao hàng</h5>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-secondary">Người nhận</label>
                        <input type="text" class="form-control" value="${sessionScope.user.name}" readonly style="border-radius: 8px;">
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-secondary">Số điện thoại</label>
                        <input type="text" class="form-control" value="${sessionScope.user.phone}" readonly style="border-radius: 8px;">
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-secondary">Địa chỉ nhận hàng <span class="text-danger">*</span></label>
                        <input type="text" name="shippingAddress" class="form-control" value="${sessionScope.user.address}" placeholder="Nhập địa chỉ nhận hàng chi tiết" required style="border-radius: 8px;">
                    </div>
                    <div class="mb-3">
                        <label class="form-label font-semibold text-secondary">Phương thức thanh toán</label>
                        <select name="paymentMethod" class="form-select" style="border-radius: 8px;">
                            <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                            <option value="BANK">Chuyển khoản ngân hàng</option>
                        </select>
                    </div>
                    <div class="mb-0">
                        <label class="form-label font-semibold text-secondary">Ghi chú đơn hàng</label>
                        <textarea name="note" class="form-control" rows="3" placeholder="Ghi chú về thời gian giao, mẫu áo..." style="border-radius: 8px;"></textarea>
                    </div>
                </div>
            </div>

            <div class="col-md-5">
                <div class="card border-0 bg-light p-4 h-100 rounded-3" style="border: 1px solid rgba(0,0,0,0.05) !important;">
                    <h5 class="font-bold mb-3 text-dark"><i class="bi bi-receipt me-2"></i>Tóm tắt đơn hàng</h5>
                    <ul class="list-group list-group-flush mb-4 bg-transparent">
                        <c:forEach var="item" items="${cartItems}">
                            <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent px-0">
                                <div style="max-width: 70%;">
                                    <h6 class="my-0 font-bold text-dark text-truncate"><c:out value="${item.product.name}"/></h6>
                                    <small class="text-secondary">SL: ${item.quantity} x <fmt:formatNumber value="${item.product.price}" pattern="#,##0"/> VNĐ</small>
                                </div>
                                <span class="text-danger font-semibold"><fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,##0"/> VNĐ</span>
                            </li>
                        </c:forEach>
                    </ul>
                    <div class="d-flex justify-content-between align-items-center pt-3 border-top mt-auto">
                        <span class="fs-5 font-bold text-dark">Tổng thanh toán:</span>
                        <span class="fs-4 text-danger font-bold"><fmt:formatNumber value="${totalAmount}" pattern="#,##0"/> VNĐ</span>
                    </div>
                    <button type="submit" class="btn btn-warning btn-lg font-bold text-white w-100 mt-4 py-2 text-uppercase">XÁC NHẬN ĐẶT HÀNG</button>
                </div>
            </div>
        </div>
    </form>
</div>
