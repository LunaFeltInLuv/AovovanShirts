<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <fmt:setLocale value="vi_VN"/>

        <section class="section">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-transparent border-bottom py-3">
                    <h4 class="card-title mb-0 text-primary font-bold"><i
                            class="bi bi-file-earmark-spreadsheet-fill me-2"></i>Quản Lý Tất Cả Đơn Hàng Khách Hàng</h4>
                </div>
                <div class="card-body py-3">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light text-secondary">
                                <tr>
                                    <th class="ps-3">Mã đơn</th>
                                    <th>User ID</th>
                                    <th>Ngày đặt</th>
                                    <th>Tổng tiền</th>
                                    <th>Địa chỉ</th>
                                    <th>Trạng thái</th>
                                    <th>Cập nhật trạng thái</th>
                                    <th class="text-end pe-3">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="o" items="${orders}">
                                    <tr>
                                        <td class="ps-3 font-bold text-dark">#${o.id}</td>
                                        <td><span class="font-semibold text-secondary">${o.userId}</span></td>
                                        <td>${o.orderDate}</td>
                                        <td><span class="text-danger font-semibold"><fmt:formatNumber value="${o.totalAmount}" pattern="#,##0"/> VNĐ</span></td>
                                        <td><span class="text-truncate d-inline-block" style="max-width: 200px;">
                                                <c:out value="${o.shippingAddress}" />
                                            </span></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${o.status eq 'pending'}"><span
                                                        class="badge bg-light-warning text-warning">Chờ xử lý</span>
                                                </c:when>
                                                <c:when test="${o.status eq 'confirmed'}"><span
                                                        class="badge bg-light-info text-info">Đã xác nhận</span>
                                                </c:when>
                                                <c:when test="${o.status eq 'shipping'}"><span
                                                        class="badge bg-light-primary text-primary">Đang giao</span>
                                                </c:when>
                                                <c:when test="${o.status eq 'delivered'}"><span
                                                        class="badge bg-light-success text-success">Đã giao</span>
                                                </c:when>
                                                <c:otherwise><span class="badge bg-light-danger text-danger">Đã
                                                        hủy</span></c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${o.status eq 'delivered' or o.status eq 'cancelled'}">
                                                    <span class="badge bg-light-secondary text-secondary">
                                                        <i class="bi bi-lock-fill me-1"></i>Không thể thay đổi
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="<c:url value='/admin/orders/update-status' />"
                                                        method="post" class="input-group input-group-sm"
                                                        style="max-width: 215px;"
                                                        onsubmit="return confirm('Bạn có chắc chắn muốn cập nhật trạng thái đơn hàng #${o.id} không?');">
                                                        <input type="hidden" name="id" value="${o.id}">
                                                        <select name="status" class="form-select">
                                                            <option value="pending" ${o.status eq 'pending' ? 'selected'
                                                                : '' } ${o.status eq 'confirmed' or o.status
                                                                eq 'shipping' ? 'disabled' : '' }>
                                                                Chờ xử lý
                                                            </option>
                                                            <option value="confirmed" ${o.status eq 'confirmed'
                                                                ? 'selected' : '' } ${o.status eq 'shipping'
                                                                ? 'disabled' : '' }>
                                                                Xác nhận
                                                            </option>
                                                            <option value="shipping" ${o.status eq 'shipping'
                                                                ? 'selected' : '' }>
                                                                Đang giao
                                                            </option>
                                                            <option value="delivered" ${o.status eq 'delivered'
                                                                ? 'selected' : '' }>
                                                                Đã giao
                                                            </option>
                                                            <option value="cancelled" ${o.status eq 'cancelled'
                                                                ? 'selected' : '' }>
                                                                Hủy đơn
                                                            </option>
                                                        </select>
                                                        <button type="submit"
                                                            class="btn btn-primary d-inline-flex align-items-center gap-1"
                                                            title="Lưu thay đổi">
                                                            <i class="bi bi-check-lg"></i>
                                                            <span>Cập nhật</span>
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-end pe-3">
                                            <a href="<c:url value='/admin/orders/detail?id=${o.id}'/>"
                                                class="btn btn-light-secondary btn-sm" title="Xem chi tiết">
                                                <i class="bi bi-eye-fill"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>