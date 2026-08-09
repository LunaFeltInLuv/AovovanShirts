<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div class="row mb-4">
    <div class="col-12">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title">Doanh thu theo ngày</h4>
            </div>
            <div class="card-body">
                <div style="height: 400px;">
                    <canvas id="revenueChart"></canvas>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-12 col-md-6">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title">Top Khách Hàng</h4>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-lg">
                        <thead>
                            <tr>
                                <th>Khách hàng</th>
                                <th>Tổng chi tiêu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${topCustomers}">
                                <tr>
                                    <td class="col-8">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar avatar-md bg-warning text-dark me-3" style="width:40px;height:40px;display:flex;align-items:center;justify-content:center;border-radius:50%">
                                                <i class="bi bi-person-fill"></i>
                                            </div>
                                            <p class="font-bold mb-0">${item.label}</p>
                                        </div>
                                    </td>
                                    <td class="col-4 align-middle">
                                        <p class="mb-0 font-bold text-primary"><fmt:formatNumber value="${item.value}" pattern="#,##0"/> VNĐ</p>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty topCustomers}">
                                <tr><td colspan="2" class="text-center text-muted py-4">Chưa có dữ liệu</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-12 col-md-6">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title">Top Sản Phẩm Bán Chạy</h4>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover table-lg">
                        <thead>
                            <tr>
                                <th>Sản phẩm</th>
                                <th>Doanh thu</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${topProducts}">
                                <tr>
                                    <td class="col-8 align-middle">
                                        <p class="font-bold mb-0">${item.label}</p>
                                    </td>
                                    <td class="col-4 align-middle">
                                        <p class="mb-0 font-bold text-success"><fmt:formatNumber value="${item.value}" pattern="#,##0"/> VNĐ</p>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty topProducts}">
                                <tr><td colspan="2" class="text-center text-muted py-4">Chưa có dữ liệu</td></tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const labels = [
            <c:forEach var="item" items="${revenueByDate}">
                '${item.label}',
            </c:forEach>
        ];
        const data = [
            <c:forEach var="item" items="${revenueByDate}">
                ${item.value},
            </c:forEach>
        ];

        if (labels.length > 0) {
            const ctx = document.getElementById('revenueChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Doanh thu',
                        data: data,
                        backgroundColor: 'rgba(139, 92, 246, 0.5)',
                        borderColor: 'rgba(139, 92, 246, 1)',
                        borderWidth: 1,
                        borderRadius: 4
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(value);
                                }
                            }
                        }
                    },
                    plugins: {
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    let label = context.dataset.label || '';
                                    if (label) {
                                        label += ': ';
                                    }
                                    if (context.parsed.y !== null) {
                                        label += new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(context.parsed.y);
                                    }
                                    return label;
                                }
                            }
                        }
                    }
                }
            });
        } else {
            // Render a placeholder if no data
            const container = document.getElementById('revenueChart').parentElement;
            container.innerHTML = '<div class="d-flex align-items-center justify-content-center h-100 text-muted">Chưa có dữ liệu thống kê doanh thu</div>';
        }
    });
</script>
