<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="section">
    <div class="row">
        <!-- Card 1: Products -->
        <div class="col-12 col-md-4 mb-4">
            <div class="card shadow-sm h-100">
                <div class="card-body px-4 py-4-5">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon purple me-3 d-flex align-items-center justify-content-center" style="width: 48px; height: 48px; border-radius: 8px;">
                            <i class="bi bi-grid-fill fs-4 text-white"></i>
                        </div>
                        <div>
                            <h6 class="text-muted font-semibold mb-1">Sản Phẩm</h6>
                            <h4 class="font-extrabold mb-0 text-primary">Kinh Doanh</h4>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="<c:url value='/admin/products' />" class="btn btn-light-primary btn-sm font-semibold w-100">Xem danh sách <i class="bi bi-arrow-right-short"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 2: Users -->
        <div class="col-12 col-md-4 mb-4">
            <div class="card shadow-sm h-100">
                <div class="card-body px-4 py-4-5">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon blue me-3 d-flex align-items-center justify-content-center" style="width: 48px; height: 48px; border-radius: 8px;">
                            <i class="bi bi-people-fill fs-4 text-white"></i>
                        </div>
                        <div>
                            <h6 class="text-muted font-semibold mb-1">Người Dùng</h6>
                            <h4 class="font-extrabold mb-0 text-info">Hội Viên</h4>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="<c:url value='/admin/users' />" class="btn btn-light-info btn-sm font-semibold w-100">Xem quản lý <i class="bi bi-arrow-right-short"></i></a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Card 3: Orders -->
        <div class="col-12 col-md-4 mb-4">
            <div class="card shadow-sm h-100">
                <div class="card-body px-4 py-4-5">
                    <div class="d-flex align-items-center">
                        <div class="stats-icon green me-3 d-flex align-items-center justify-content-center" style="width: 48px; height: 48px; border-radius: 8px;">
                            <i class="bi bi-file-earmark-spreadsheet-fill fs-4 text-white"></i>
                        </div>
                        <div>
                            <h6 class="text-muted font-semibold mb-1">Đơn Hàng</h6>
                            <h4 class="font-extrabold mb-0 text-success">Giao Dịch</h4>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="<c:url value='/admin/orders' />" class="btn btn-light-success btn-sm font-semibold w-100">Xem chi tiết <i class="bi bi-arrow-right-short"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Welcome card -->
    <div class="row">
        <div class="col-12">
            <div class="card shadow-sm border-0 bg-light-primary p-4">
                <div class="card-body">
                    <h4 class="card-title text-primary"><i class="bi bi-balloon-fill me-2 text-warning"></i>Chào mừng quay trở lại, Admin!</h4>
                    <p class="card-text text-secondary mb-0">
                        Hệ thống quản trị Áo Vớ Vẩn cung cấp đầy đủ các tính năng để bạn quản lý danh mục sản phẩm thời trang, danh sách người mua hàng và tình trạng các đơn hàng của hệ thống một cách tối ưu và nhanh chóng nhất.
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

