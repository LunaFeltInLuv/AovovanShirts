<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<section class="section" style="max-width: 800px;">
    <div class="card shadow-sm border-0">
        <div class="card-header bg-transparent border-bottom py-3 d-flex justify-content-between align-items-center">
            <h4 class="card-title mb-0 text-primary font-bold">
                <i class="bi ${empty product ? 'bi-plus-circle-fill' : 'bi-pencil-square'} me-2"></i>
                ${empty product ? 'Thêm Áo Mới' : 'Cập Nhật Sản Phẩm'}
            </h4>
            <a href="<c:url value='/admin/products' />" class="btn btn-light-secondary btn-sm font-semibold">
                <i class="bi bi-arrow-left me-1"></i> Quay lại
            </a>
        </div>
        <div class="card-body py-4">
            <form action="<c:url value='${empty product ? "/admin/products/add" : "/admin/products/update"}' />" method="post">
                <c:if test="${not empty product}">
                    <input type="hidden" name="id" value="${product.id}">
                </c:if>

                <div class="form-group mb-3">
                    <label class="form-label font-semibold text-secondary">Tên sản phẩm <span class="text-danger">*</span></label>
                    <input type="text" name="name" class="form-control" value="<c:out value='${product.name}'/>" placeholder="Nhập tên áo (ví dụ: Áo Thun Cực Độc)" required>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <div class="form-group">
                            <label class="form-label font-semibold text-secondary">Giá bán (VNĐ) <span class="text-danger">*</span></label>
                            <input type="number" step="0.01" name="price" class="form-control" value="${product.price}" placeholder="Giá bán" required>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <div class="form-group">
                            <label class="form-label font-semibold text-secondary">Số lượng tồn kho <span class="text-danger">*</span></label>
                            <input type="number" name="stockQuantity" class="form-control" value="${empty product ? '10' : product.stockQuantity}" placeholder="Số lượng" required>
                        </div>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <label class="form-label font-semibold text-secondary">Danh mục</label>
                    <input type="text" name="category" class="form-control" value="<c:out value='${product.category}'/>" placeholder="Ví dụ: Áo thun, Áo sơ mi...">
                </div>

                <div class="form-group mb-3">
                    <label class="form-label font-semibold text-secondary">Đường dẫn hình ảnh (URL)</label>
                    <input type="url" name="imageUrl" class="form-control" value="<c:out value='${product.imageUrl}'/>" placeholder="https://example.com/image.jpg">
                </div>

                <div class="form-group mb-3">
                    <label class="form-label font-semibold text-secondary">Mô tả sản phẩm</label>
                    <textarea name="description" class="form-control" rows="4" placeholder="Nhập mô tả chi tiết sản phẩm..."><c:out value="${product.description}"/></textarea>
                </div>

                <div class="form-check form-switch mb-4">
                    <input type="checkbox" name="isActive" value="true" class="form-check-input" id="activeCheck" ${empty product or product.isActive ? 'checked' : ''}>
                    <label class="form-check-label font-semibold text-dark" for="activeCheck">Đang kinh doanh (Active)</label>
                </div>

                <div class="border-top pt-3 d-flex justify-content-end">
                    <a href="<c:url value='/admin/products' />" class="btn btn-light-secondary font-semibold me-2">Hủy bỏ</a>
                    <button type="submit" class="btn btn-warning font-semibold text-dark px-4">LƯU SẢN PHẨM</button>
                </div>
            </form>
        </div>
    </div>
</section>
