<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Quản lý Kích cỡ (Size)</h1>
    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addSizeModal">
        <i class="bi bi-plus-circle"></i> Thêm kích cỡ
    </button>
</div>

<div class="table-responsive">
    <table class="table table-striped table-hover align-middle">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên Kích cỡ</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="size" items="${sizes}">
            <tr>
                <td>${size.id}</td>
                <td>${size.name}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/admin/sizes/delete" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${size.id}">
                        <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa kích cỡ này không?');">
                            <i class="bi bi-trash"></i> Xóa
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Modal Thêm Kích cỡ -->
<div class="modal fade" id="addSizeModal" tabindex="-1" aria-labelledby="addSizeModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin/sizes/add" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addSizeModalLabel">Thêm kích cỡ mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="sizeName" class="form-label">Tên kích cỡ (VD: S, M, L, XL)</label>
                        <input type="text" class="form-control" id="sizeName" name="name" required>
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
