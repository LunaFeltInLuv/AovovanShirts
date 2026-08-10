<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="vi_VN"/>

<div class="container bg-white p-4 p-md-5 shadow-sm" style="border-radius: 20px; border: 1px solid var(--border-color);">
    <div class="row g-5">
        <div class="col-md-5">
            <div class="p-2 border rounded-4 d-flex align-items-center justify-content-center overflow-hidden" style="background-color: var(--bg-color); border-color: var(--border-color) !important;">
                <img src="${empty product.imageUrl ? pageContext.request.contextPath.concat('/assets/images/placeholder.svg') : product.imageUrl}" onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg';" class="img-fluid rounded-3" alt="${product.name}" style="max-height: 420px; object-fit: cover;">
            </div>
        </div>
        <div class="col-md-7 d-flex flex-column justify-content-center">
            <nav aria-label="breadcrumb" class="mb-3">
                <ol class="breadcrumb mb-0">
                    <li class="breadcrumb-item"><a href="<c:url value='/home' />" class="text-decoration-none font-semibold" style="color: var(--text-muted);">Trang chủ</a></li>
                    <li class="breadcrumb-item"><a href="<c:url value='/products' />" class="text-decoration-none font-semibold" style="color: var(--text-muted);">Sản phẩm</a></li>
                    <li class="breadcrumb-item active font-semibold" aria-current="page" style="color: var(--primary-color);"><c:out value="${product.name}"/></li>
                </ol>
            </nav>
            <h1 class="font-bold text-dark mb-2"><c:out value="${product.name}"/></h1>
            <div class="d-flex align-items-center gap-2 mb-3">
                <span class="badge px-3 py-2 font-semibold" style="background-color: var(--bg-color); color: var(--text-muted); border: 1px solid var(--border-color);"><c:out value="${product.category}"/></span>
                <span id="stockBadge" class="badge px-3 py-2 font-semibold" style="background-color: #ECFDF5; color: #047857; border: 1px solid #A7F3D0;">Tồn kho chung: ${product.stockQuantity}</span>
            </div>
            <h2 class="font-bold my-2" style="color: var(--primary-color);"><fmt:formatNumber value="${product.price}" pattern="#,##0"/> VNĐ</h2>
            <div class="mb-3">
                <h6 class="font-bold mb-1" style="color: var(--text-muted);">Mô tả sản phẩm:</h6>
                <p class="mb-0" style="color: var(--text-muted); line-height: 1.6;"><c:out value="${product.description}"/></p>
            </div>

            <form id="addToCartForm" action="<c:url value='/cart/add' />" method="post" class="mt-2 border-top pt-3" style="border-color: var(--border-color) !important;">
                <input type="hidden" name="productId" value="${product.id}">
                <input type="hidden" id="selectedColorId" name="colorId" value="">
                <input type="hidden" id="selectedSizeId" name="sizeId" value="">
                <input type="hidden" id="selectedVariantId" name="variantId" value="">

                <!-- Validation Alert Message Box -->
                <div id="validationAlert" class="alert alert-warning d-none py-2 px-3 mb-3 font-semibold text-danger rounded-3" style="border-left: 4px solid var(--bs-danger);">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i><span id="alertMsg">Vui lòng chọn thông tin</span>
                </div>

                <!-- Ô 1: Chọn Màu Sắc -->
                <div class="mb-3">
                    <label class="form-label font-bold text-dark d-block mb-2">
                        1. Chọn Màu Sắc: <span id="colorNameDisplay" class="text-primary font-bold"></span>
                    </label>
                    <div class="d-flex flex-wrap gap-2" id="colorOptionsGroup">
                        <c:forEach var="v" items="${variants}">
                            <button type="button" 
                                    class="btn color-btn p-1 rounded-circle d-flex align-items-center justify-content-center border"
                                    style="width: 42px; height: 42px; background-color: ${v.hexCode}; cursor: pointer; transition: all 0.2s;"
                                    data-color-id="${v.colorId}" 
                                    data-color-name="${v.colorName}"
                                    title="${v.colorName}"
                                    onclick="selectColor(this, ${v.colorId}, '${v.colorName}')">
                                <i class="bi bi-check-lg text-white font-bold d-none check-icon" style="filter: drop-shadow(0 0 2px rgba(0,0,0,0.8));"></i>
                            </button>
                        </c:forEach>
                        <c:if test="${empty variants}">
                            <span class="text-muted small">Sản phẩm này chưa có biến thể màu sắc.</span>
                        </c:if>
                    </div>
                </div>

                <!-- Ô 2: Chọn Size / Kích Cỡ -->
                <div class="mb-4">
                    <label class="form-label font-bold text-dark d-block mb-2">
                        2. Chọn Size Áo: <span id="sizeNameDisplay" class="text-primary font-bold"></span>
                    </label>
                    <div class="d-flex flex-wrap gap-2" id="sizeOptionsGroup">
                        <c:forEach var="v" items="${variants}">
                            <button type="button" 
                                    class="btn size-btn font-bold px-3 py-2 rounded-3 border bg-light text-dark"
                                    style="min-width: 48px; height: 44px; transition: all 0.2s;"
                                    data-size-id="${v.sizeId}" 
                                    data-size-name="${v.sizeName}"
                                    onclick="selectSize(this, ${v.sizeId}, '${v.sizeName}')">
                                ${v.sizeName}
                            </button>
                        </c:forEach>
                        <c:if test="${empty variants}">
                            <span class="text-muted small">Sản phẩm này chưa có biến thể size.</span>
                        </c:if>
                    </div>
                </div>

                <!-- Số lượng & Nút bấm mua -->
                <div class="d-flex align-items-center gap-3 mb-4">
                    <label class="form-label font-bold mb-0" style="color: var(--text-muted);">Số lượng mua:</label>
                    <input type="number" name="quantity" class="form-control text-center font-semibold" value="1" min="1" max="${product.stockQuantity}" style="width: 90px; height: 45px; border-radius: 12px; background-color: var(--bg-color); border: 1px solid var(--border-color); color: var(--text-main);">
                </div>

                <button type="submit" class="btn btn-warning btn-lg font-bold text-white px-4 py-3 w-100" style="border-radius: 12px; background-color: #f59e0b; border: none;">
                    <i class="bi bi-cart-plus-fill me-2"></i> THÊM VÀO GIỎ HÀNG
                </button>
            </form>
        </div>
    </div>
</div>

<script>
    // JS JSON Data for variants
    const variantsData = [
        <c:forEach var="v" items="${variants}" varStatus="status">
            {
                id: ${v.id},
                colorId: ${v.colorId},
                colorName: "${v.colorName}",
                sizeId: ${v.sizeId},
                sizeName: "${v.sizeName}",
                stock: ${v.stockQuantity}
            }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    let chosenColorId = null;
    let chosenSizeId = null;

    // Clean duplicate color buttons & size buttons on load
    document.addEventListener("DOMContentLoaded", function() {
        // Filter unique colors
        const colorGroup = document.getElementById("colorOptionsGroup");
        const uniqueColors = new Map();
        colorGroup.querySelectorAll(".color-btn").forEach(btn => {
            const cId = btn.getAttribute("data-color-id");
            if (uniqueColors.has(cId)) {
                btn.remove();
            } else {
                uniqueColors.set(cId, true);
            }
        });

        // Filter unique sizes
        const sizeGroup = document.getElementById("sizeOptionsGroup");
        const uniqueSizes = new Map();
        sizeGroup.querySelectorAll(".size-btn").forEach(btn => {
            const sId = btn.getAttribute("data-size-id");
            if (uniqueSizes.has(sId)) {
                btn.remove();
            } else {
                uniqueSizes.set(sId, true);
            }
        });
    });

    function selectColor(btn, colorId, colorName) {
        document.querySelectorAll(".color-btn").forEach(b => {
            b.classList.remove("border-3", "border-primary", "shadow");
            b.querySelector(".check-icon").classList.add("d-none");
        });
        btn.classList.add("border-3", "border-primary", "shadow");
        btn.querySelector(".check-icon").classList.remove("d-none");

        chosenColorId = colorId;
        document.getElementById("selectedColorId").value = colorId;
        document.getElementById("colorNameDisplay").innerText = " - " + colorName;
        hideAlert();
        checkMatchingVariant();
    }

    function selectSize(btn, sizeId, sizeName) {
        document.querySelectorAll(".size-btn").forEach(b => {
            b.classList.remove("btn-primary", "text-white");
            b.classList.add("bg-light", "text-dark");
        });
        btn.classList.removeClass ? btn.classList.removeClass("bg-light") : btn.classList.remove("bg-light", "text-dark");
        btn.classList.add("btn-primary", "text-white");

        chosenSizeId = sizeId;
        document.getElementById("selectedSizeId").value = sizeId;
        document.getElementById("sizeNameDisplay").innerText = " - Size " + sizeName;
        hideAlert();
        checkMatchingVariant();
    }

    function checkMatchingVariant() {
        if (chosenColorId && chosenSizeId) {
            const match = variantsData.find(v => v.colorId === chosenColorId && v.sizeId === chosenSizeId);
            const stockBadge = document.getElementById("stockBadge");
            if (match) {
                document.getElementById("selectedVariantId").value = match.id;
                if (match.stock > 0) {
                    stockBadge.className = "badge px-3 py-2 font-semibold bg-success text-white";
                    stockBadge.innerText = "Tồn kho biến thể này: " + match.stock + " chiếc";
                } else {
                    stockBadge.className = "badge px-3 py-2 font-semibold bg-danger text-white";
                    stockBadge.innerText = "Tồn kho: Hết hàng";
                }
            } else {
                document.getElementById("selectedVariantId").value = "";
                stockBadge.className = "badge px-3 py-2 font-semibold bg-secondary text-white";
                stockBadge.innerText = "Loại này hiện chưa có sẵn";
            }
        }
    }

    function showAlert(msg) {
        const alertBox = document.getElementById("validationAlert");
        document.getElementById("alertMsg").innerText = msg;
        alertBox.classList.remove("d-none");
    }

    function hideAlert() {
        document.getElementById("validationAlert").classList.add("d-none");
    }

    // Form Submit Validation Gate
    document.getElementById("addToCartForm").addEventListener("submit", function(e) {
        // If variants exist in system
        if (variantsData.length > 0) {
            if (!chosenColorId) {
                e.preventDefault();
                showAlert("Vui lòng chọn màu sắc sản phẩm trước khi thêm vào giỏ hàng!");
                return false;
            }
            if (!chosenSizeId) {
                e.preventDefault();
                showAlert("Vui lòng chọn kích thước (size) sản phẩm trước khi thêm vào giỏ hàng!");
                return false;
            }

            const match = variantsData.find(v => v.colorId === chosenColorId && v.sizeId === chosenSizeId);
            if (!match || match.stock <= 0) {
                e.preventDefault();
                showAlert("Biến thể màu sắc & size bạn chọn hiện đã hết hàng. Vui lòng chọn kết hợp khác!");
                return false;
            }
        }
    });
</script>
