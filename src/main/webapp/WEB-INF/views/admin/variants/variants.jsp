<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Quản lý Biến thể: ${product.name}</h1>
    <div>
        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary me-2">
            <i class="bi bi-arrow-left"></i> Quay lại
        </a>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addVariantModal">
            <i class="bi bi-plus-circle"></i> Thêm biến thể
        </button>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-striped table-hover align-middle">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Màu sắc</th>
            <th>Kích cỡ</th>
            <th>Tồn kho</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="variant" items="${variants}">
            <tr>
                <td>${variant.id}</td>
                <td>
                    <div class="d-flex align-items-center">
                        <div style="width: 20px; height: 20px; border-radius: 50%; background-color: ${variant.hexCode}; border: 1px solid #ccc; margin-right: 8px;"></div>
                        ${variant.colorName}
                    </div>
                </td>
                <td>${variant.sizeName}</td>
                <td>${variant.stockQuantity}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/admin/products/variants/delete" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${variant.id}">
                        <input type="hidden" name="productId" value="${product.id}">
                        <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa biến thể này không?');">
                            <i class="bi bi-trash"></i> Xóa
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        <c:if test="${empty variants}">
            <tr>
                <td colspan="5" class="text-center text-muted">Chưa có biến thể nào cho sản phẩm này.</td>
            </tr>
        </c:if>
        </tbody>
    </table>
</div>

<!-- Modal Thêm Biến thể -->
<div class="modal fade" id="addVariantModal" tabindex="-1" aria-labelledby="addVariantModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin/products/variants/add" method="post">
                <input type="hidden" name="productId" value="${product.id}">
                <div class="modal-header">
                    <h5 class="modal-title" id="addVariantModalLabel">Thêm biến thể mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="colorId" class="form-label">Màu sắc</label>
                        <select class="form-select" id="colorId" name="colorId" required>
                            <option value="">Chọn màu...</option>
                            <c:forEach var="color" items="${colors}">
                                <option value="${color.id}">${color.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="sizeId" class="form-label">Kích cỡ</label>
                        <select class="form-select" id="sizeId" name="sizeId" required>
                            <option value="">Chọn kích cỡ...</option>
                            <c:forEach var="size" items="${sizes}">
                                <option value="${size.id}">${size.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="stockQuantity" class="form-label">Số lượng tồn kho</label>
                        <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" min="0" value="0" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                </div>
            </form>
        </div>
    </div>
</div>
