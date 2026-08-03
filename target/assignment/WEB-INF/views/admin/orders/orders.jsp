<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="card shadow-sm border-0 p-3">
    <h4 class="card-title mb-3">Quản Lý Tất Cả Đơn Hàng Khách Hàng</h4>

    <table class="table table-striped table-hover align-middle">
        <thead class="table-dark">
            <tr>
                <th>Mã đơn</th>
                <th>User ID</th>
                <th>Ngày đặt</th>
                <th>Tổng tiền</th>
                <th>Địa chỉ</th>
                <th>Trạng thái</th>
                <th>Cập nhật trạng thái</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="o" items="${orders}">
                <tr>
                    <td><strong>#${o.id}</strong></td>
                    <td>${o.userId}</td>
                    <td>${o.orderDate}</td>
                    <td class="text-danger font-weight-bold">${o.totalAmount} VNĐ</td>
                    <td><c:out value="${o.shippingAddress}"/></td>
                    <td><span class="badge bg-warning text-dark">${o.status}</span></td>
                    <td>
                        <form action="<c:url value='/admin/orders/update-status' />" method="post" class="d-flex">
                            <input type="hidden" name="id" value="${o.id}">
                            <select name="status" class="form-select form-select-sm me-1" style="width: 130px;">
                                <option value="pending" ${o.status eq 'pending' ? 'selected' : ''}>Pending</option>
                                <option value="confirmed" ${o.status eq 'confirmed' ? 'selected' : ''}>Confirmed</option>
                                <option value="shipping" ${o.status eq 'shipping' ? 'selected' : ''}>Shipping</option>
                                <option value="delivered" ${o.status eq 'delivered' ? 'selected' : ''}>Delivered</option>
                                <option value="cancelled" ${o.status eq 'cancelled' ? 'selected' : ''}>Cancelled</option>
                            </select>
                            <button type="submit" class="btn btn-primary btn-sm">Lưu</button>
                        </form>
                    </td>
                    <td>
                        <a href="<c:url value='/admin/orders/detail?id=${o.id}' />" class="btn btn-outline-dark btn-sm"><i class="bi bi-eye"></i></a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
