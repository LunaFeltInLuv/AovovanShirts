<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="vi_VN"/>

<section class="section">
    <div class="card shadow-sm border-0">
        <div class="card-header d-flex justify-content-between align-items-center bg-transparent border-bottom py-3">
            <h4 class="card-title mb-0 text-primary font-bold"><i class="bi bi-tag-fill me-2"></i>Danh Sách Sản Phẩm (Áo Vớ Vẩn)</h4>
            <a href="<c:url value='/admin/products/add' />" class="btn btn-warning font-semibold text-dark">
                <i class="bi bi-plus-circle me-1"></i> Thêm Áo Mới
            </a>
        </div>
        <c:if test="${not empty selectedCategory}">
            <div class="alert alert-info d-flex align-items-center justify-content-between m-3 mb-0 rounded-3">
                <div>
                    <i class="bi bi-funnel-fill me-2"></i>
                    Đang hiển thị các sản phẩm thuộc danh mục: <span class="badge bg-primary fs-6 ms-1"><c:out value="${selectedCategory}"/></span>
                </div>
                <a href="<c:url value='/admin/products' />" class="btn btn-outline-dark btn-sm font-semibold">
                    <i class="bi bi-x-circle me-1"></i> Xem tất cả sản phẩm
                </a>
            </div>
        </c:if>
        <div class="card-body py-3">
            <div class="table-responsive">
                <table class="table table-hover align-middle">
                    <thead class="table-light text-secondary">
                        <tr>
                            <th class="ps-3">ID</th>
                            <th>Ảnh</th>
                            <th>Tên sản phẩm</th>
                            <th>Danh mục</th>
                            <th>Giá bán</th>
                            <th>Tồn kho</th>
                            <th>Trạng thái</th>
                            <th class="text-end pe-3">Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td class="ps-3 font-semibold">${p.id}</td>
                                <td>
                                    <img src="${empty p.imageUrl ? pageContext.request.contextPath.concat('/assets/images/placeholder.svg') : p.imageUrl}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg';" class="rounded" style="width: 48px; height: 48px; object-fit: cover; border: 1px solid #eee;">
                                </td>
                                <td><span class="font-bold text-dark"><c:out value="${p.name}"/></span></td>
                                <td><span class="badge bg-light-secondary text-secondary"><c:out value="${p.category}"/></span></td>
                                <td><span class="text-danger font-semibold"><fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ</span></td>
                                <td>
                                    <span class="font-semibold ${p.stockQuantity <= 5 ? 'text-warning' : 'text-dark'}">${p.stockQuantity}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${p.isActive}">
                                            <span class="badge bg-light-success text-success">Đang bán</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-light-danger text-danger">Ngừng bán</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end pe-3">
                                    <a href="<c:url value='/admin/variants?productId=${p.id}' />" class="btn btn-light-info btn-sm me-1" title="Quản lý biến thể màu sắc & size">
                                        <i class="bi bi-tags-fill"></i>
                                    </a>
                                    <a href="<c:url value='/admin/products/update?id=${p.id}' />" class="btn btn-light-primary btn-sm me-1" title="Chỉnh sửa">
                                        <i class="bi bi-pencil-fill"></i>
                                    </a>
                                    <c:choose>
                                        <c:when test="${p.isActive}">
                                            <form action="<c:url value='/admin/products/delete'/>" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc muốn ngừng bán sản phẩm này?');">
                                                <input type="hidden" name="id" value="${p.id}">
                                                <input type="hidden" name="force" value="false">
                                                <button type="submit" class="btn btn-light-warning btn-sm" title="Ngừng bán">
                                                    <i class="bi bi-eye-slash-fill"></i>
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="<c:url value='/admin/products/restore'/>" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc muốn khôi phục (mở bán lại) sản phẩm này?');">
                                                <input type="hidden" name="id" value="${p.id}">
                                                <button type="submit" class="btn btn-light-success btn-sm me-1" title="Mở bán lại">
                                                    <i class="bi bi-eye-fill"></i>
                                                </button>
                                            </form>
                                            <form action="<c:url value='/admin/products/delete'/>" method="post" class="d-inline" onsubmit="return confirm('CẢNH BÁO: Bạn có chắc chắn muốn XÓA VĨNH VIỄN sản phẩm này? Thao tác này không thể hoàn tác!');">
                                                <input type="hidden" name="id" value="${p.id}">
                                                <input type="hidden" name="force" value="true">
                                                <button type="submit" class="btn btn-light-danger btn-sm" title="Xóa vĩnh viễn">
                                                    <i class="bi bi-trash-fill"></i>
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>