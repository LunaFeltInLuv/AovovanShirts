<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container bg-white p-4 rounded shadow-sm">
    <h2 class="font-weight-bold mb-4"><i class="bi bi-credit-card text-warning me-2"></i>Thanh Toán Đơn Hàng</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger mb-3" role="alert">
            <c:out value="${error}" />
        </div>
    </c:if>

    <form action="<c:url value='/checkout' />" method="post">
        <div class="row">
            <div class="col-md-7">
                <h5 class="font-weight-bold mb-3">Thông tin giao hàng</h5>
                <div class="mb-3">
                    <label class="form-label font-weight-bold">Người nhận</label>
                    <input type="text" class="form-control" value="${sessionScope.user.name}" readonly>
                </div>
                <div class="mb-3">
                    <label class="form-label font-weight-bold">Số điện thoại</label>
                    <input type="text" class="form-control" value="${sessionScope.user.phone}" readonly>
                </div>
                <div class="mb-3">
                    <label class="form-label font-weight-bold">Địa chỉ nhận hàng (*)</label>
                    <input type="text" name="shippingAddress" class="form-control" value="${sessionScope.user.address}" placeholder="Nhập địa chỉ nhận hàng" required>
                </div>
                <div class="mb-3">
                    <label class="form-label font-weight-bold">Phương thức thanh toán</label>
                    <select name="paymentMethod" class="form-select">
                        <option value="COD">Thanh toán khi nhận hàng (COD)</option>
                        <option value="BANK">Chuyển khoản ngân hàng</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label font-weight-bold">Ghi chú đơn hàng</label>
                    <textarea name="note" class="form-control" rows="3" placeholder="Ghi chú về thời gian giao, mẫu áo..."></textarea>
                </div>
            </div>

            <div class="col-md-5">
                <div class="card bg-light border-0 p-3">
                    <h5 class="font-weight-bold mb-3">Tóm tắt đơn hàng</h5>
                    <ul class="list-group list-group-flush mb-3">
                        <c:forEach var="item" items="${cartItems}">
                            <li class="list-group-item d-flex justify-content-between align-items-center bg-transparent">
                                <div>
                                    <h6 class="my-0"><c:out value="${item.product.name}"/></h6>
                                    <small class="text-muted">SL: ${item.quantity} x ${item.product.price} VNĐ</small>
                                </div>
                                <span class="text-danger font-weight-bold">${item.product.price * item.quantity} VNĐ</span>
                            </li>
                        </c:forEach>
                    </ul>
                    <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                        <span class="fs-5 font-weight-bold">Tổng thanh toán:</span>
                        <span class="fs-4 text-danger font-weight-bold">${totalAmount} VNĐ</span>
                    </div>
                    <button type="submit" class="btn btn-warning btn-lg font-weight-bold text-dark w-100 mt-4">XÁC NHẬN ĐẶT HÀNG</button>
                </div>
            </div>
        </div>
    </form>
</div>
