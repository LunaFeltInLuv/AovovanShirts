<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:if test="${not empty sessionScope.errorMessage}">
    <div class="alert alert-danger alert-dismissible fade show shadow-sm" role="alert">
        <i class="bi bi-exclamation-triangle-fill me-2"></i> <strong>Thất bại!</strong> ${sessionScope.errorMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="errorMessage" scope="session"/>
</c:if>

<c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
        <i class="bi bi-check-circle-fill me-2"></i> <strong>Thành công!</strong> ${sessionScope.successMessage}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <c:remove var="successMessage" scope="session"/>
</c:if>

<!-- Navigation Tabs -->
<ul class="nav nav-pills mb-4 gap-2" id="variantTabs" role="tablist">
    <li class="nav-item" role="presentation">
        <a class="nav-link px-4 py-2-5 ${empty activeTab or activeTab eq 'variants' ? 'active' : ''}" 
           href="<c:url value='/admin/variants?tab=variants${selectedProduct ne null ? "&productId=".concat(selectedProduct.id) : ""}' />">
            <i class="bi bi-layers-fill me-2"></i> Tồn Kho Theo Sản Phẩm
        </a>
    </li>
    <li class="nav-item" role="presentation">
        <a class="nav-link px-4 py-2-5 ${activeTab eq 'colors' ? 'active' : ''}" 
           href="<c:url value='/admin/variants?tab=colors' />">
            <i class="bi bi-palette-fill me-2"></i> Danh Mục Màu Sắc
        </a>
    </li>
    <li class="nav-item" role="presentation">
        <a class="nav-link px-4 py-2-5 ${activeTab eq 'sizes' ? 'active' : ''}" 
           href="<c:url value='/admin/variants?tab=sizes' />">
            <i class="bi bi-aspect-ratio-fill me-2"></i> Danh Mục Size Áo
        </a>
    </li>
</ul>

<div class="tab-content" id="variantTabsContent">
    <!-- TAB 1: BIẾN THỂ THEO SẢN PHẨM -->
    <c:if test="${empty activeTab or activeTab eq 'variants'}">
        <div class="tab-pane fade show active" id="tab-variants">
            <div class="card shadow-sm border-0 mb-4">
                <div class="card-body p-4">
                    <form action="<c:url value='/admin/variants' />" method="get" class="row g-3 align-items-center">
                        <input type="hidden" name="tab" value="variants"/>
                        <div class="col-12 col-md-8">
                            <label for="productSelect" class="form-label font-semibold">Chọn Sản Phẩm Cần Quản Lý:</label>
                            <select class="form-select form-select-lg" id="productSelect" name="productId" onchange="this.form.submit()">
                                <c:forEach var="p" items="${products}">
                                    <option value="${p.id}" ${selectedProduct ne null and selectedProduct.id eq p.id ? 'selected' : ''}>
                                        ${p.name} - (<fmt:formatNumber value="${p.price}" pattern="#,##0"/> VNĐ)
                                    </option>
                                </c:forEach>
                                <c:if test="${empty products}">
                                    <option value="">Chưa có sản phẩm nào</option>
                                </c:if>
                            </select>
                        </div>
                        <div class="col-12 col-md-4 d-flex align-items-end">
                            <c:if test="${selectedProduct ne null}">
                                <button type="button" class="btn btn-primary btn-lg w-100 font-semibold mt-md-4" data-bs-toggle="modal" data-bs-target="#addVariantModal">
                                    <i class="bi bi-plus-circle-fill me-2"></i> Thêm Biến Thể Cho Sản Phẩm
                                </button>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>

            <c:if test="${selectedProduct ne null}">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-white py-3">
                        <h5 class="card-title text-primary mb-0">
                            <i class="bi bi-box-seam me-2"></i>Danh sách biến thể: <strong><c:out value="${selectedProduct.name}"/></strong>
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="ps-4">Màu sắc</th>
                                        <th>Kích cỡ (Size)</th>
                                        <th>Số lượng tồn kho</th>
                                        <th class="text-end pe-4">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="v" items="${variants}">
                                        <tr>
                                            <td class="ps-4">
                                                <div class="d-flex align-items-center">
                                                    <span class="rounded-circle me-2 border shadow-sm" 
                                                          style="width: 24px; height: 24px; background-color: ${v.hexCode}; display: inline-block;"></span>
                                                    <span class="font-semibold"><c:out value="${v.colorName}"/></span>
                                                </div>
                                            </td>
                                            <td>
                                                <span class="badge bg-secondary fs-6 px-3 py-2"><c:out value="${v.sizeName}"/></span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${v.stockQuantity > 10}">
                                                        <span class="badge bg-light-success text-success font-bold fs-6 px-3 py-2">${v.stockQuantity} sản phẩm</span>
                                                    </c:when>
                                                    <c:when test="${v.stockQuantity > 0}">
                                                        <span class="badge bg-light-warning text-warning font-bold fs-6 px-3 py-2">Sắp hết (${v.stockQuantity})</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-light-danger text-danger font-bold fs-6 px-3 py-2">Hết hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-end pe-4">
                                                <form action="<c:url value='/admin/variants/delete' />" method="post" class="d-inline" onsubmit="return confirm('Bạn có chắc chắn muốn xóa biến thể này?');">
                                                    <input type="hidden" name="id" value="${v.id}"/>
                                                    <input type="hidden" name="productId" value="${selectedProduct.id}"/>
                                                    <button type="submit" class="btn btn-outline-danger btn-sm">
                                                        <i class="bi bi-trash-fill"></i> Xóa
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty variants}">
                                        <tr>
                                            <td colspan="4" class="text-center py-4 text-muted">
                                                <i class="bi bi-inbox fs-2 d-block mb-2"></i>
                                                Chưa có biến thể màu sắc/size nào được thiết lập cho sản phẩm này.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </c:if>

    <!-- TAB 2: QUẢN LÝ MÀU SẮC -->
    <c:if test="${activeTab eq 'colors'}">
        <div class="tab-pane fade show active" id="tab-colors">
            <div class="row">
                <div class="col-12 col-md-5 mb-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white py-3">
                            <h5 class="card-title text-primary mb-0"><i class="bi bi-plus-circle me-2"></i>Thêm Màu Sắc Mới</h5>
                        </div>
                        <div class="card-body p-4">
                            <form action="<c:url value='/admin/colors/add' />" method="post">
                                <div class="mb-3">
                                    <label for="colorName" class="form-label font-semibold">Tên Màu Sắc:</label>
                                    <input type="text" class="form-control" id="colorName" name="name" placeholder="VD: Đỏ Đô, Xanh Navy..." required/>
                                </div>
                                <div class="mb-3">
                                    <label for="hexCode" class="form-label font-semibold">Mã Màu (HEX):</label>
                                    <div class="input-group">
                                        <input type="color" class="form-control form-control-color" id="hexPicker" value="#000000" onchange="document.getElementById('hexCode').value = this.value"/>
                                        <input type="text" class="form-control" id="hexCode" name="hexCode" value="#000000" placeholder="#FF0000" required/>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-success w-100 font-semibold">
                                    <i class="bi bi-save me-1"></i> Lưu Màu Sắc
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-7 mb-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white py-3">
                            <h5 class="card-title text-primary mb-0"><i class="bi bi-palette me-2"></i>Danh Sách Màu Sắc Hiện Có</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-4">Tên Màu</th>
                                            <th>Mã Hex</th>
                                            <th>Hiển thị</th>
                                            <th class="text-end pe-4">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="c" items="${colors}">
                                            <tr>
                                                <td class="ps-4 font-semibold"><c:out value="${c.name}"/></td>
                                                <td><code><c:out value="${c.hexCode}"/></code></td>
                                                <td>
                                                    <span class="rounded-circle d-inline-block border shadow-sm" 
                                                          style="width: 28px; height: 28px; background-color: ${c.hexCode};"></span>
                                                </td>
                                                <td class="text-end pe-4">
                                                    <form action="<c:url value='/admin/colors/delete' />" method="post" class="d-inline" onsubmit="return confirm('Xóa màu sắc này?');">
                                                        <input type="hidden" name="id" value="${c.id}"/>
                                                        <button type="submit" class="btn btn-outline-danger btn-sm">
                                                            <i class="bi bi-trash-fill"></i> Xóa
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty colors}">
                                            <tr><td colspan="4" class="text-center text-muted py-4">Chưa có dữ liệu màu sắc</td></tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- TAB 3: QUẢN LÝ SIZE ÁO -->
    <c:if test="${activeTab eq 'sizes'}">
        <div class="tab-pane fade show active" id="tab-sizes">
            <div class="row">
                <div class="col-12 col-md-5 mb-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white py-3">
                            <h5 class="card-title text-primary mb-0"><i class="bi bi-plus-circle me-2"></i>Thêm Kích Thước (Size) Mới</h5>
                        </div>
                        <div class="card-body p-4">
                            <form action="<c:url value='/admin/sizes/add' />" method="post">
                                <div class="mb-3">
                                    <label for="sizeName" class="form-label font-semibold">Tên Size:</label>
                                    <input type="text" class="form-control" id="sizeName" name="name" placeholder="VD: S, M, L, XL, XXL..." required/>
                                </div>
                                <button type="submit" class="btn btn-success w-100 font-semibold">
                                    <i class="bi bi-save me-1"></i> Lưu Size
                                </button>
                            </form>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-md-7 mb-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white py-3">
                            <h5 class="card-title text-primary mb-0"><i class="bi bi-aspect-ratio me-2"></i>Danh Sách Size Áo Hiện Có</h5>
                        </div>
                        <div class="card-body p-0">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-4">Tên Size</th>
                                            <th class="text-end pe-4">Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="s" items="${sizes}">
                                            <tr>
                                                <td class="ps-4">
                                                    <span class="badge bg-secondary fs-6 px-3 py-2"><c:out value="${s.name}"/></span>
                                                </td>
                                                <td class="text-end pe-4">
                                                    <form action="<c:url value='/admin/sizes/delete' />" method="post" class="d-inline" onsubmit="return confirm('Xóa kích thước này?');">
                                                        <input type="hidden" name="id" value="${s.id}"/>
                                                        <button type="submit" class="btn btn-outline-danger btn-sm">
                                                            <i class="bi bi-trash-fill"></i> Xóa
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty sizes}">
                                            <tr><td colspan="2" class="text-center text-muted py-4">Chưa có dữ liệu size áo</td></tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>
</div>

<!-- Modal Thêm Biến Thể -->
<c:if test="${selectedProduct ne null and (empty activeTab or activeTab eq 'variants')}">
    <div class="modal fade" id="addVariantModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <form action="<c:url value='/admin/variants/add' />" method="post">
                    <input type="hidden" name="productId" value="${selectedProduct.id}"/>
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title text-white">
                            <i class="bi bi-plus-circle me-2"></i>Thêm Biến Thể: <c:out value="${selectedProduct.name}"/>
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body p-4">
                        <div class="mb-3">
                            <label for="varColorId" class="form-label font-semibold">Chọn Màu Sắc:</label>
                            <select class="form-select" id="varColorId" name="colorId" required>
                                <option value="">-- Chọn Màu Sắc --</option>
                                <c:forEach var="c" items="${colors}">
                                    <option value="${c.id}">${c.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="varSizeId" class="form-label font-semibold">Chọn Kích Thước (Size):</label>
                            <select class="form-select" id="varSizeId" name="sizeId" required>
                                <option value="">-- Chọn Size --</option>
                                <c:forEach var="s" items="${sizes}">
                                    <option value="${s.id}">${s.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="varStock" class="form-label font-semibold">Số Lượng Tồn Kho:</label>
                            <input type="number" class="form-control" id="varStock" name="stockQuantity" min="0" value="10" required/>
                        </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-primary font-semibold">Lưu Biến Thể</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</c:if>
