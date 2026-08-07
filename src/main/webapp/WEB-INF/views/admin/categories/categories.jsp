<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <div class="page-heading">
            <div class="page-title">
                <div class="row">
                    <div class="col-12 col-md-6 order-md-1 order-last">
                        <h3>Danh Mục Sản Phẩm</h3>
                        <p class="text-subtitle text-muted">Quản lý và thống kê danh mục áo hiện có trên hệ thống.</p>
                    </div>
                    <div class="col-12 col-md-6 order-md-2 order-first">
                        <nav aria-label="breadcrumb" class="breadcrumb-header float-start float-lg-end">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="<c:url value='/admin/products' />">Dashboard</a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">Danh mục</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>

            <section class="section">
                <div class="card shadow-sm border-0">
                    <div
                        class="card-header bg-transparent border-bottom py-3 d-flex justify-content-between align-items-center">
                        <h5 class="card-title mb-0 text-primary font-bold">Danh sách danh mục</h5>
                        <button type="button" class="btn btn-primary btn-sm font-semibold shadow-sm"
                            data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                            <i class="bi bi-folder-plus me-1"></i> Thêm danh mục mới
                        </button>
                    </div>
                    <div class="card-body py-3">
                        <c:choose>
                            <c:when test="${empty categories}">
                                <div class="alert bg-light-info text-info rounded-3 p-4" role="alert">
                                    <i class="bi bi-info-circle-fill me-2 fs-5"></i>
                                    Chưa có danh mục sản phẩm nào được tạo. Hãy thêm danh mục khi tạo sản phẩm mới!
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="table-light text-secondary">
                                            <tr>
                                                <th class="ps-3">Tên danh mục</th>
                                                <th>Số lượng sản phẩm liên kết</th>
                                                <th class="text-end pe-3">Thao tác</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="cat" items="${categories}">
                                                <tr>
                                                    <td class="ps-3">
                                                        <span
                                                            class="badge bg-light-secondary text-secondary px-3 py-2 font-bold fs-6">
                                                            <c:out value="${cat.name}" />
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <span class="font-bold text-dark fs-6">${cat.productCount} sản
                                                            phẩm</span>
                                                    </td>
                                                    <td class="text-end pe-3">
                                                        <a href="<c:url value='/admin/products'/>?category=${cat.name}"
                                                            class="btn btn-light-info btn-sm me-1 font-semibold"
                                                            title="Xem tất cả sản phẩm thuộc danh mục này">
                                                            <i class="bi bi-eye-fill me-1"></i> Xem sản phẩm
                                                        </a>
                                                        <button type="button" class="btn btn-light-primary btn-sm me-1"
                                                            data-bs-toggle="modal" data-bs-target="#editCategoryModal"
                                                            onclick="openEditModal('${cat.name}')"
                                                            title="Chỉnh sửa tên danh mục">
                                                            <i class="bi bi-pencil-fill"></i> Sửa
                                                        </button>
                                                        <form action="<c:url value='/admin/categories/delete'/>"
                                                            method="post" class="d-inline"
                                                            onsubmit="return confirm('Bạn có chắc chắn muốn xóa danh mục này? Các sản phẩm thuộc danh mục này sẽ chuyển về trạng thái không có danh mục.');">
                                                            <input type="hidden" name="name" value="${cat.name}">
                                                            <button type="submit" class="btn btn-light-danger btn-sm"
                                                                title="Xóa danh mục">
                                                                <i class="bi bi-trash-fill"></i> Xóa
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </section>
        </div>

        <!-- Bootstrap 5 Add Category Modal -->
        <div class="modal fade text-left" id="addCategoryModal" tabindex="-1" role="dialog"
            aria-labelledby="addModalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                <div class="modal-content rounded-4 border-0 shadow-lg">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title text-white font-bold" id="addModalTitle">
                            <i class="bi bi-folder-plus me-2"></i>Thêm Danh Mục Mới
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                            aria-label="Close"></button>
                    </div>
                    <form action="<c:url value='/admin/categories/add' />" method="post">
                        <div class="modal-body p-4">
                            <div class="form-group mb-3">
                                <label class="form-label font-bold text-secondary">Tên danh mục mới <span
                                        class="text-danger">*</span></label>
                                <input type="text" name="name" class="form-control"
                                    placeholder="Ví dụ: Áo khoác, Áo polo..." required>
                            </div>

                            <div class="form-group mb-0">
                                <label class="form-label font-bold text-secondary mb-1">Gán danh mục cho các sản phẩm
                                    hiện có (Tùy chọn):</label>
                                <p class="text-muted small mb-2">Bạn có thể chọn một hoặc nhiều sản phẩm dưới đây để
                                    chuyển vào danh mục mới vừa tạo.</p>
                                <div class="border rounded-3 p-3 bg-light" style="max-height: 220px; overflow-y: auto;">
                                    <c:choose>
                                        <c:when test="${empty allProducts}">
                                            <span class="text-muted small">Chưa có sản phẩm nào trong hệ thống.</span>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="row g-2">
                                                <c:forEach var="p" items="${allProducts}">
                                                    <div class="col-md-6">
                                                        <div
                                                            class="form-check p-2 bg-white rounded border border-light">
                                                            <input class="form-check-input" type="checkbox"
                                                                name="productIds" value="${p.id}" id="prod_${p.id}">
                                                            <label
                                                                class="form-check-label w-100 text-truncate font-semibold text-dark small cursor-pointer"
                                                                for="prod_${p.id}">
                                                                <c:out value="${p.name}" />
                                                                <c:choose>
                                                                    <c:when test="${empty p.category}">
                                                                        <span
                                                                            class="badge bg-light-warning text-warning ms-1">Chưa
                                                                            có danh mục</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span
                                                                            class="badge bg-light-secondary text-secondary ms-1">
                                                                            <c:out value="${p.category}" />
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer border-top-0 pt-0">
                            <button type="button" class="btn btn-light-secondary font-semibold" data-bs-dismiss="modal">
                                Hủy
                            </button>
                            <button type="submit" class="btn btn-primary font-semibold">
                                <i class="bi bi-check-lg me-1"></i> Tạo danh mục
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 Edit Category Modal -->
        <div class="modal fade text-left" id="editCategoryModal" tabindex="-1" role="dialog"
            aria-labelledby="modalTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content rounded-4 border-0 shadow-lg">
                    <div class="modal-header bg-warning">
                        <h5 class="modal-title text-white font-bold" id="modalTitle">
                            <i class="bi bi-pencil-square me-2"></i>Chỉnh Sửa Danh Mục
                        </h5>
                        <button type="button" class="close text-white" data-bs-dismiss="modal" aria-label="Close">
                            <i class="bi bi-x fs-4"></i>
                        </button>
                    </div>
                    <form action="<c:url value='/admin/categories/update' />" method="post">
                        <div class="modal-body p-4">
                            <input type="hidden" id="oldName" name="oldName">
                            <div class="form-group mb-3">
                                <label class="form-label font-bold text-secondary">Tên danh mục hiện tại:</label>
                                <input type="text" id="displayOldName" class="form-control bg-light" readonly>
                            </div>
                            <div class="form-group mb-0">
                                <label class="form-label font-bold text-secondary">Tên danh mục mới <span
                                        class="text-danger">*</span></label>
                                <input type="text" id="newName" name="newName" class="form-control"
                                    placeholder="Nhập tên danh mục mới..." required>
                            </div>
                        </div>
                        <div class="modal-footer border-top-0 pt-0">
                            <button type="button" class="btn btn-light-secondary font-semibold" data-bs-dismiss="modal">
                                Hủy
                            </button>
                            <button type="submit" class="btn btn-warning font-semibold text-white">
                                Lưu thay đổi
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function openEditModal(categoryName) {
                document.getElementById('oldName').value = categoryName;
                document.getElementById('displayOldName').value = categoryName;
                document.getElementById('newName').value = categoryName;
                setTimeout(() => {
                    document.getElementById('newName').focus();
                }, 300);
            }
        </script>