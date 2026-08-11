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
                    <tbody id="ordersTableBody">
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
                                    <button type="button" onclick="openQuickOrderDetail('${o.id}')" class="btn btn-sm font-semibold px-3 me-1" style="background-color: var(--bg-color); color: var(--primary-color); border: 1px solid var(--border-color); border-radius: 8px;">Xem nhanh</button>
                                    <a href="<c:url value='/order-detail?id=${o.id}' />" class="btn btn-sm btn-outline-secondary font-semibold px-2" style="border-radius: 8px;"><i class="bi bi-box-arrow-up-right"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Lazy Load Button Container -->
            <div class="text-center mt-4" id="loadMoreContainer" style="display: ${hasMore ? 'block' : 'none'};">
                <button type="button" id="btnLoadMore" onclick="loadMoreOrders()" class="btn btn-warning px-4 py-2 font-bold shadow-sm" style="border-radius: 12px;">
                    <i class="bi bi-arrow-clockwise me-1" id="loadIcon"></i> Tải thêm đơn hàng
                </button>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- Modal Quick View Order Detail -->
<div class="modal fade" id="quickOrderModal" tabindex="-1" aria-labelledby="quickOrderModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0 shadow-lg rounded-4">
            <div class="modal-header border-0 pb-0">
                <h5 class="modal-title font-bold" id="quickOrderModalLabel"><i class="bi bi-bag-check me-2" style="color: var(--primary-color);"></i>Chi Tiết Đơn Hàng <span id="modalOrderId" class="text-warning"></span></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4" id="quickOrderModalBody">
                <div class="text-center py-4">
                    <div class="spinner-border text-warning" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                </div>
            </div>
            <div class="modal-footer border-0 pt-0">
                <button type="button" class="btn btn-light font-semibold" data-bs-dismiss="modal">Đóng</button>
            </div>
        </div>
    </div>
</div>

<script>
    let currentPage = ${page != null ? page : 1};
    const contextPath = '${pageContext.request.contextPath}';

    function loadMoreOrders() {
        const btn = document.getElementById('btnLoadMore');
        const icon = document.getElementById('loadIcon');
        btn.disabled = true;
        icon.classList.add('spin');

        const nextPage = currentPage + 1;
        fetch(contextPath + '/api/orders?page=' + nextPage)
            .then(res => res.json())
            .then(data => {
                if (data && data.orders && data.orders.length > 0) {
                    const tbody = document.getElementById('ordersTableBody');
                    data.orders.forEach(o => {
                        const tr = document.createElement('tr');
                        tr.style.borderBottom = '1px solid var(--border-color)';
                        
                        let statusBadge = '';
                        if (o.status === 'pending') statusBadge = '<span class="badge px-3 py-2 font-semibold" style="background-color: #FEF3C7; color: #B45309; border: 1px solid #FDE68A;">Chờ xác nhận</span>';
                        else if (o.status === 'confirmed') statusBadge = '<span class="badge px-3 py-2 font-semibold" style="background-color: #E0F2FE; color: #0369A1; border: 1px solid #BAE6FD;">Đã xác nhận</span>';
                        else if (o.status === 'shipping') statusBadge = '<span class="badge px-3 py-2 font-semibold" style="background-color: #EDE9FE; color: #6D28D9; border: 1px solid #DDD6FE;">Đang giao</span>';
                        else if (o.status === 'delivered') statusBadge = '<span class="badge px-3 py-2 font-semibold" style="background-color: #D1FAE5; color: #047857; border: 1px solid #A7F3D0;">Đã giao</span>';
                        else statusBadge = `<span class="badge px-3 py-2 font-semibold" style="background-color: #FEE2E2; color: #B91C1C; border: 1px solid #FECACA;">\${o.status}</span>`;

                        const formattedPrice = new Intl.NumberFormat('vi-VN').format(o.totalAmount);

                        tr.innerHTML = `
                            <td class="ps-3 font-bold text-dark border-0">#\${o.id}</td>
                            <td class="font-semibold border-0" style="color: var(--text-muted);">\${o.orderDate}</td>
                            <td class="border-0"><span class="font-bold" style="color: var(--primary-color);">\${formattedPrice} VNĐ</span></td>
                            <td class="border-0">\${statusBadge}</td>
                            <td class="border-0"><span class="text-truncate d-inline-block font-semibold" style="max-width: 250px; color: var(--text-muted);">\${o.shippingAddress || ''}</span></td>
                            <td class="text-end pe-3 border-0">
                                <button type="button" onclick="openQuickOrderDetail('\${o.id}')" class="btn btn-sm font-semibold px-3 me-1" style="background-color: var(--bg-color); color: var(--primary-color); border: 1px solid var(--border-color); border-radius: 8px;">Xem nhanh</button>
                                <a href="\${contextPath}/order-detail?id=\${o.id}" class="btn btn-sm btn-outline-secondary font-semibold px-2" style="border-radius: 8px;"><i class="bi bi-box-arrow-up-right"></i></a>
                            </td>
                        `;
                        tbody.appendChild(tr);
                    });

                    currentPage = nextPage;
                    if (!data.hasMore) {
                        document.getElementById('loadMoreContainer').style.display = 'none';
                    }
                } else {
                    document.getElementById('loadMoreContainer').style.display = 'none';
                }
            })
            .catch(err => console.error(err))
            .finally(() => {
                btn.disabled = false;
                icon.classList.remove('spin');
            });
    }

    function openQuickOrderDetail(orderId) {
        document.getElementById('modalOrderId').innerText = '#' + orderId;
        const modalBody = document.getElementById('quickOrderModalBody');
        modalBody.innerHTML = `
            <div class="text-center py-4">
                <div class="spinner-border text-warning" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
            </div>
        `;
        
        const modalElement = document.getElementById('quickOrderModal');
        const modal = new bootstrap.Modal(modalElement);
        modal.show();

        fetch(contextPath + '/api/order-details?id=' + orderId)
            .then(res => res.json())
            .then(data => {
                if (data && data.details && data.details.length > 0) {
                    let html = '<div class="table-responsive"><table class="table align-middle"><thead class="table-light"><tr><th>Sản phẩm</th><th>Đơn giá</th><th>Số lượng</th><th class="text-end">Thành tiền</th></tr></thead><tbody>';
                    data.details.forEach(item => {
                        const price = new Intl.NumberFormat('vi-VN').format(item.price);
                        const totalLine = new Intl.NumberFormat('vi-VN').format(item.totalLine);
                        const img = item.imageUrl ? item.imageUrl : contextPath + '/assets/images/placeholder.svg';
                        html += `
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="\${img}" onerror="this.src='\${contextPath}/assets/images/placeholder.svg';" class="rounded-3 me-3" style="width: 48px; height: 48px; object-fit: cover;">
                                        <span class="font-bold text-dark">\${item.productName}</span>
                                    </div>
                                </td>
                                <td>\${price} VNĐ</td>
                                <td><span class="badge bg-light text-dark font-bold px-3 py-2">\${item.quantity}</span></td>
                                <td class="text-end font-bold text-warning">\${totalLine} VNĐ</td>
                            </tr>
                        `;
                    });
                    html += '</tbody></table></div>';
                    modalBody.innerHTML = html;
                } else {
                    modalBody.innerHTML = '<div class="alert alert-info mb-0">Không tìm thấy chi tiết sản phẩm.</div>';
                }
            })
            .catch(err => {
                modalBody.innerHTML = '<div class="alert alert-danger mb-0">Không thể tải thông tin đơn hàng.</div>';
            });
    }
</script>

<style>
    @keyframes spin {
        0% { transform: rotate(0deg); }
        100% { transform: rotate(360deg); }
    }
    .spin {
        display: inline-block;
        animation: spin 1s infinite linear;
    }
</style>
