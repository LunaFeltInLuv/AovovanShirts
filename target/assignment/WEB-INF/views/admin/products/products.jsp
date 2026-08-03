<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="card shadow-sm border-0 p-3">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="card-title mb-0">Danh Sách Sản Phẩm (Áo Vớ Vẩn)</h4>
        <a href="<c:url value='/admin/products/add' />" class="btn btn-warning font-weight-bold text-dark"><i class="bi bi-plus-circle me-1"></i> Thêm Áo Mới</a>
    </div>

    <table class="table table-striped table-hover align-middle">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Danh mục</th>
                <th>Giá bán</th>
                <th>Tồn kho</th>
                <th>Trạng thái</th>
                <th>Thao tác</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="p" items="${products}">
                <tr>
                    <td>${p.id}</td>
                    <td>
                        <img src="${empty p.imageUrl ? 'https://via.placeholder.com/50?text=Shirt' : p.imageUrl}" class="rounded" style="width: 45px; height: 45px; object-fit: cover;">
                    </td>
                    <td><strong><c:out value="${p.name}"/></strong></td>
                    <td><c:out value="${p.category}"/></td>
                    <td class="text-danger font-weight-bold">${p.price} VNĐ</td>
                    <td>${p.stockQuantity}</td>
                    <td>
                        <c:choose>
                            <c:when test="${p.isActive}"><span class="badge bg-success">Đang bán</span></c:when>
                            <c:otherwise><span class="badge bg-secondary">Ngừng bán</span></c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="<c:url value='/admin/products/update?id=${p.id}' />" class="btn btn-primary btn-sm me-1"><i class="bi bi-pencil"></i></a>
                        <form action="<c:url value='/admin/products/delete' />" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc muốn ẩn sản phẩm này?');">
                            <input type="hidden" name="id" value="${p.id}">
                            <button type="submit" class="btn btn-danger btn-sm"><i class="bi bi-trash"></i></button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
