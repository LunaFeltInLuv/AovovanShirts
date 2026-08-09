<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>

        <section class="section" style="max-width: 800px;">
            <div class="card shadow-sm border-0">
                <div
                    class="card-header bg-transparent border-bottom py-3 d-flex justify-content-between align-items-center">
                    <h4 class="card-title mb-0 text-primary font-bold">
                        <i class="bi ${empty product ? 'bi-plus-circle-fill' : 'bi-pencil-square'} me-2"></i>
                        ${empty product ? 'Thêm Áo Mới' : 'Cập Nhật Sản Phẩm'}
                    </h4>
                    <a href="<c:url value='/admin/products' />" class="btn btn-light-secondary btn-sm font-semibold">
                        <i class="bi bi-arrow-left me-1"></i> Quay lại
                    </a>
                </div>
                <div class="card-body py-4">
                    <form action="<c:url value='${empty product ? " /admin/products/add" : "/admin/products/update"
                        }' />" method="post" enctype="multipart/form-data">
                    <c:if test="${not empty product}">
                        <input type="hidden" name="id" value="${product.id}">
                    </c:if>

                    <div class="form-group mb-3">
                        <label class="form-label font-semibold text-secondary">Tên sản phẩm <span
                                class="text-danger">*</span></label>
                        <input type="text" name="name" class="form-control" value="<c:out value='${product.name}'/>"
                            placeholder="Nhập tên áo (ví dụ: Áo Thun Cực Độc)" required>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <div class="form-group">
                                <label class="form-label font-semibold text-secondary">Giá bán (VNĐ) <span
                                        class="text-danger">*</span></label>
                                <input type="number" step="0.01" name="price" class="form-control"
                                    value="${product.price}" placeholder="Giá bán" required>
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <div class="form-group">
                                <label class="form-label font-semibold text-secondary">Số lượng tồn kho <span
                                        class="text-danger">*</span></label>
                                <input type="number" name="stockQuantity" class="form-control"
                                    value="${empty product ? '10' : product.stockQuantity}" placeholder="Số lượng"
                                    required>
                            </div>
                        </div>
                    </div>

                    <div class="form-group mb-3">
                        <label class="form-label font-semibold text-secondary">Danh mục</label>
                        <select name="category" class="form-select">
                            <option value="">-- Chọn danh mục --</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="<c:out value='${cat.name}'/>" ${product.category == cat.name ? 'selected' : ''}>
                                    <c:out value='${cat.name}'/>
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Product Image Selection Card -->
                    <div class="card bg-light border mb-4">
                        <div class="card-body p-3">
                            <label class="form-label font-bold text-dark mb-2"><i class="bi bi-image me-1"></i>Hình ảnh
                                sản phẩm</label>

                            <!-- Toggle Options -->
                            <div class="btn-group w-100 mb-3" role="group">
                                <input type="radio" class="btn-check" name="imageOption" id="optionUrl" value="url"
                                    checked onclick="toggleImageOption('url')">
                                <label class="btn btn-outline-primary font-semibold py-2" for="optionUrl">
                                    <i class="bi bi-link-45deg me-1"></i> 1. Dán URL ảnh
                                </label>

                                <input type="radio" class="btn-check" name="imageOption" id="optionFile" value="file"
                                    onclick="toggleImageOption('file')">
                                <label class="btn btn-outline-primary font-semibold py-2" for="optionFile">
                                    <i class="bi bi-upload me-1"></i> 2. Upload tệp từ máy
                                </label>
                            </div>

                            <!-- Option 1: URL Input -->
                            <div id="imageOptionUrlGroup" class="form-group mb-3">
                                <input type="text" id="imageUrlInput" name="imageUrl" class="form-control"
                                    value="<c:out value='${product.imageUrl}'/>"
                                    placeholder="Dán đường dẫn ảnh trực tuyến (https://example.com/image.jpg)..."
                                    oninput="previewImageUrl(this.value)">
                                <small class="text-muted">Nhập liên kết đường dẫn hình ảnh trực tuyến.</small>
                            </div>

                            <!-- Option 2: File Upload Input -->
                            <div id="imageOptionFileGroup" class="form-group mb-3 d-none">
                                <input type="file" id="imageFileInput" name="imageFile" class="form-control"
                                    accept="image/*" onchange="previewImageFile(this)">
                                <small class="text-muted">Tệp ảnh sẽ tự động được tải lên và lưu vào thư mục
                                    <code>assets/images/products</code> trên server.</small>
                            </div>

                            <!-- Live Preview -->
                            <div class="mt-3 text-center border-top pt-3">
                                <label class="form-label d-block text-muted small font-semibold mb-2">Xem trước hình
                                    ảnh:</label>
                                <img id="imgPreview"
                                    src="${empty product.imageUrl ? pageContext.request.contextPath.concat('/assets/images/placeholder.svg') : product.imageUrl}"
                                    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg';"
                                    alt="Preview" class="img-thumbnail rounded-3 shadow-sm"
                                    style="max-height: 180px; object-fit: cover;">
                            </div>
                        </div>
                    </div>

                    <div class="form-group mb-3">
                        <label class="form-label font-semibold text-secondary">Mô tả sản phẩm</label>
                        <textarea name="description" class="form-control" rows="4"
                            placeholder="Nhập mô tả chi tiết sản phẩm..."><c:out value="${product.description}"/></textarea>
                    </div>

                    <div class="form-check form-switch mb-4">
                        <input type="checkbox" name="isActive" value="true" class="form-check-input" id="activeCheck"
                            ${empty product or product.isActive ? 'checked' : '' }>
                        <label class="form-check-label font-semibold text-dark" for="activeCheck">Đang kinh doanh
                            (Active)</label>
                    </div>

                    <div class="border-top pt-3 d-flex justify-content-end">
                        <a href="<c:url value='/admin/products' />"
                            class="btn btn-light-secondary font-semibold me-2">Hủy bỏ</a>
                        <button type="submit" class="btn btn-warning font-semibold text-dark px-4">LƯU SẢN PHẨM</button>
                    </div>
                    </form>
                </div>
            </div>
        </section>

        <script>
            function toggleImageOption(type) {
                const urlGroup = document.getElementById('imageOptionUrlGroup');
                const fileGroup = document.getElementById('imageOptionFileGroup');
                if (type === 'file') {
                    urlGroup.classList.add('d-none');
                    fileGroup.classList.remove('d-none');
                } else {
                    fileGroup.classList.add('d-none');
                    urlGroup.classList.remove('d-none');
                }
            }

            function previewImageUrl(url) {
                const preview = document.getElementById('imgPreview');
                if (url && url.trim() !== '') {
                    preview.src = url;
                } else {
                    preview.src = '${pageContext.request.contextPath}/assets/images/placeholder.svg';
                }
            }

            function previewImageFile(input) {
                const preview = document.getElementById('imgPreview');
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        preview.src = e.target.result;
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>