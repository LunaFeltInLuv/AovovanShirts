<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="card shadow-sm border-0 p-4" style="max-width: 700px;">
    <h4 class="card-title mb-3">${empty product ? 'Thêm Áo Mới' : 'Cập Nhật Sản Phẩm'}</h4>

    <form action="<c:url value='${empty product ? "/admin/products/add" : "/admin/products/update"}' />" method="post">
        <c:if test="${not empty product}">
            <input type="hidden" name="id" value="${product.id}">
        </c:if>

        <div class="mb-3">
            <label class="form-label font-weight-bold">Tên sản phẩm (*)</label>
            <input type="text" name="name" class="form-control" value="<c:out value='${product.name}'/>" required>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label font-weight-bold">Giá bán (VNĐ) (*)</label>
                <input type="number" step="0.01" name="price" class="form-control" value="${product.price}" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label font-weight-bold">Số lượng tồn kho (*)</label>
                <input type="number" name="stockQuantity" class="form-control" value="${empty product ? '10' : product.stockQuantity}" required>
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label font-weight-bold">Danh mục</label>
            <input type="text" name="category" class="form-control" value="<c:out value='${product.category}'/>" placeholder="Ví dụ: Áo thun, Áo sơ mi...">
        </div>

        <div class="mb-3">
            <label class="form-label font-weight-bold">Đường dẫn hình ảnh (URL)</label>
            <input type="text" name="imageUrl" class="form-control" value="<c:out value='${product.imageUrl}'/>" placeholder="https://example.com/image.jpg">
        </div>

        <div class="mb-3">
            <label class="form-label font-weight-bold">Mô tả sản phẩm</label>
            <textarea name="description" class="form-control" rows="4"><c:out value="${product.description}"/></textarea>
        </div>

        <div class="mb-3 form-check">
            <input type="checkbox" name="isActive" value="true" class="form-check-input" id="activeCheck" ${empty product or product.isActive ? 'checked' : ''}>
            <label class="form-check-label font-weight-bold" for="activeCheck">Đang kinh doanh (Active)</label>
        </div>

        <div class="mt-4">
            <button type="submit" class="btn btn-warning font-weight-bold text-dark me-2">LƯU SẢN PHẨM</button>
            <a href="<c:url value='/admin/products' />" class="btn btn-secondary">Hủy bỏ</a>
        </div>
    </form>
</div>
