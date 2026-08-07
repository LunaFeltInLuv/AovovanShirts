<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <fmt:setLocale value="vi_VN"/>

        <div class="container bg-white p-5 rounded-4 shadow-sm">
            <h2 class="font-bold mb-4 text-dark"><i class="bi bi-cart4 text-warning me-2"></i>Giỏ Hàng Của Bạn</h2>

            <c:if test="${not empty sessionScope.cartError}">
                <div class="alert bg-light-danger text-danger rounded-3 p-3 mb-4" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    <c:out value="${sessionScope.cartError}" />
                </div>
                <c:remove var="cartError" scope="session" />
            </c:if>

            <c:choose>
                <c:when test="${empty cartItems}">
                    <div class="alert bg-light-info text-info rounded-3 p-4" role="alert">
                        <i class="bi bi-info-circle-fill me-2 fs-5"></i>
                        Giỏ hàng của bạn đang trống! <a href="<c:url value='/products' />"
                            class="alert-link font-bold text-decoration-none">Vào cửa hàng mua áo ngay.</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table align-middle">
                            <thead class="table-light text-secondary">
                                <tr>
                                    <th class="ps-3">Sản phẩm</th>
                                    <th>Đơn giá</th>
                                    <th style="width: 160px;">Số lượng</th>
                                    <th>Thành tiền</th>
                                    <th class="text-end pe-3">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${cartItems}">
                                    <tr>
                                        <td class="ps-3">
                                            <div class="d-flex align-items-center">
                                                <img src="${empty item.product.imageUrl ? pageContext.request.contextPath.concat('/assets/images/placeholder.svg') : item.product.imageUrl}"
                                                    onerror="this.onerror=null; this.src='${pageContext.request.contextPath}/assets/images/placeholder.svg';"
                                                    class="rounded-3 me-3 border"
                                                    style="width: 64px; height: 64px; object-fit: cover;">
                                                <div>
                                                    <h6 class="mb-0 font-bold text-dark">
                                                        <c:out value="${item.product.name}" />
                                                    </h6>
                                                </div>
                                            </div>
                                        </td>
                                        <td><span class="font-semibold text-secondary"><fmt:formatNumber value="${item.product.price}" pattern="#,##0"/> VNĐ</span>
                                        </td>
                                        <td>
                                            <form action="<c:url value='/cart/update' />" method="post" class="d-flex align-items-center cart-update-form" onsubmit="return false;">
                                                <input type="hidden" name="productId" value="${item.productId}">
                                                <div class="input-group input-group-sm flex-nowrap" style="width: 115px;">
                                                    <button type="button" class="btn btn-outline-dark font-bold px-2" onclick="changeQty(this, -1)" style="width: 34px;">-</button>
                                                    <input type="number" name="quantity"
                                                        class="form-control text-center font-bold px-1 cart-qty-input border-dark"
                                                        value="${item.quantity}" min="1" max="${item.product.stockQuantity}"
                                                        data-product-id="${item.productId}"
                                                        data-price="${item.product.price}"
                                                        style="-moz-appearance: textfield; border-left: 0; border-right: 0;">
                                                    <button type="button" class="btn btn-outline-dark font-bold px-2" onclick="changeQty(this, 1)" style="width: 34px;">+</button>
                                                </div>
                                            </form>
                                        </td>
                                        <td><span class="text-danger font-semibold"
                                                id="line-total-${item.productId}"><fmt:formatNumber value="${item.lineTotal}" pattern="#,##0"/> VNĐ</span></td>
                                        <td class="text-end pe-3">
                                            <form action="<c:url value='/cart/remove' />" method="post"
                                                class="d-inline">
                                                <input type="hidden" name="productId" value="${item.productId}">
                                                <button type="submit"
                                                    class="btn btn-light-danger btn-sm font-semibold px-3">
                                                    <i class="bi bi-trash-fill me-1"></i> Xóa
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div
                        class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mt-5 pt-4 border-top gap-3">
                        <a href="<c:url value='/products' />" class="btn btn-outline-dark font-semibold"><i
                                class="bi bi-arrow-left me-1"></i> Tiếp tục mua hàng</a>
                        <div class="text-end">
                            <h4 class="font-bold text-dark">Tổng tiền: <span class="text-danger"
                                    id="grand-total-val"><fmt:formatNumber value="${totalSum}" pattern="#,##0"/> VNĐ</span></h4>
                            <a href="<c:url value='/checkout' />" id="checkout-btn"
                                class="btn btn-warning btn-lg font-bold text-white mt-2 px-4 py-2 text-uppercase">
                                TIẾN HÀNH THANH TOÁN <i class="bi bi-credit-card-2-back ms-2"></i>
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <style>
            .cart-qty-input::-webkit-outer-spin-button,
            .cart-qty-input::-webkit-inner-spin-button {
                -webkit-appearance: none;
                margin: 0;
            }
            .cart-qty-input {
                -moz-appearance: textfield;
            }
        </style>

        <script>
            function changeQty(btn, delta) {
                const container = btn.closest('.input-group');
                if (!container) return;
                const input = container.querySelector('.cart-qty-input');
                if (!input) return;

                let val = parseInt(input.value) || 1;
                let min = parseInt(input.min) || 1;
                let max = parseInt(input.max) || 999;

                let newVal = val + delta;
                if (newVal >= min && newVal <= max) {
                    input.value = newVal;
                    input.dispatchEvent(new Event('input', { bubbles: true }));
                    input.dispatchEvent(new Event('change', { bubbles: true }));
                }
            }

            document.addEventListener('DOMContentLoaded', function () {
                const qtyInputs = document.querySelectorAll('.cart-qty-input');
                const checkoutBtn = document.getElementById('checkout-btn');
                const grandTotalVal = document.getElementById('grand-total-val');
                let activeRequests = 0;
                const debounceTimers = {};

                function formatCurrency(amount) {
                    return Math.round(amount).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + ' VNĐ';
                }

                function calculateTotals() {
                    let grandTotal = 0;
                    qtyInputs.forEach(input => {
                        const price = parseFloat(input.dataset.price) || 0;
                        let qty = parseInt(input.value) || 0;
                        if (qty < 1) qty = 1;
                        const lineTotal = price * qty;

                        const productId = input.dataset.productId;
                        const lineTotalSpan = document.getElementById('line-total-' + productId);
                        if (lineTotalSpan) {
                            lineTotalSpan.textContent = formatCurrency(lineTotal);
                        }
                        grandTotal += lineTotal;
                    });
                    if (grandTotalVal) {
                        grandTotalVal.textContent = formatCurrency(grandTotal);
                    }
                }

                function setCheckoutLoading(loading) {
                    if (!checkoutBtn) return;
                    if (loading) {
                        checkoutBtn.classList.add('disabled');
                        checkoutBtn.style.pointerEvents = 'none';
                        checkoutBtn.setAttribute('tabindex', '-1');
                        checkoutBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Đang tính lại tiền...';
                    } else {
                        checkoutBtn.classList.remove('disabled');
                        checkoutBtn.style.pointerEvents = 'auto';
                        checkoutBtn.removeAttribute('tabindex');
                        checkoutBtn.innerHTML = 'TIẾN HÀNH THANH TOÁN <i class="bi bi-credit-card-2-back ms-2"></i>';
                    }
                }

                function syncCartItem(input) {
                    const productId = input.dataset.productId;
                    let quantity = parseInt(input.value) || 1;
                    if (quantity < 1) {
                        quantity = 1;
                        input.value = 1;
                    }

                    activeRequests++;
                    setCheckoutLoading(true);

                    const formData = new URLSearchParams();
                    formData.append('productId', productId);
                    formData.append('quantity', quantity);

                    fetch('<c:url value="/cart/update" />', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded',
                            'X-Requested-With': 'XMLHttpRequest'
                        },
                        body: formData.toString()
                    })
                        .then(response => response.json())
                        .catch(err => console.error('Cart update error:', err))
                        .finally(() => {
                            activeRequests = Math.max(0, activeRequests - 1);
                            if (activeRequests === 0) {
                                setCheckoutLoading(false);
                            }
                        });
                }

                qtyInputs.forEach(input => {
                    input.addEventListener('input', function () {
                        calculateTotals();
                        const productId = input.dataset.productId;
                        clearTimeout(debounceTimers[productId]);
                        setCheckoutLoading(true);
                        debounceTimers[productId] = setTimeout(() => {
                            syncCartItem(input);
                        }, 350);
                    });

                    input.addEventListener('change', function () {
                        calculateTotals();
                        const productId = input.dataset.productId;
                        clearTimeout(debounceTimers[productId]);
                        syncCartItem(input);
                    });
                });
            });
        </script>