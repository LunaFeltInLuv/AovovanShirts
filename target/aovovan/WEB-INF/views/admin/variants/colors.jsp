<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
    <h1 class="h2">Quản lý Màu sắc</h1>
    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addColorModal">
        <i class="bi bi-plus-circle"></i> Thêm màu sắc
    </button>
</div>

<div class="table-responsive">
    <table class="table table-striped table-hover align-middle">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Tên màu</th>
            <th>Mã Hex</th>
            <th>Hiển thị</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="color" items="${colors}">
            <tr>
                <td>${color.id}</td>
                <td>${color.name}</td>
                <td>${color.hexCode}</td>
                <td>
                    <div style="width: 30px; height: 30px; border-radius: 50%; background-color: ${color.hexCode}; border: 1px solid #ccc;"></div>
                </td>
                <td>
                    <form action="${pageContext.request.contextPath}/admin/colors/delete" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${color.id}">
                        <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Bạn có chắc muốn xóa màu này không?');">
                            <i class="bi bi-trash"></i> Xóa
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Modal Thêm Màu Sắc -->
<div class="modal fade" id="addColorModal" tabindex="-1" aria-labelledby="addColorModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="${pageContext.request.contextPath}/admin/colors/add" method="post">
                <div class="modal-header">
                    <h5 class="modal-title" id="addColorModalLabel">Thêm màu sắc mới</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="colorName" class="form-label">Tên màu</label>
                        <input type="text" class="form-control" id="colorName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="colorHex" class="form-label">Mã Hex</label>
                        <input type="color" class="form-control form-control-color" id="colorHex" name="hexCode" value="#000000" title="Chọn màu" required>
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
