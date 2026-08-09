# Thiết Kế: Tính Năng Biến Thể Sản Phẩm (Product Variants)

## Mục Tiêu
Thêm tính năng cho phép quản trị viên tạo các biến thể (Màu sắc, Kích cỡ) cho một sản phẩm và quản lý tồn kho độc lập cho từng biến thể đó. Ở phía người dùng (Client), khách hàng có thể chọn Màu sắc và Kích cỡ cụ thể trước khi thêm vào giỏ hàng.

## 1. Thay đổi Database (Database Schema)

Chúng ta sẽ chuyển từ cấu trúc "Tồn kho theo Sản phẩm" sang "Tồn kho theo Biến thể".
Tạo thêm 3 bảng mới:

- `colors`
  - `id` (INT, PK)
  - `name` (NVARCHAR, vd: "Đỏ", "Xanh")
  - `hex_code` (VARCHAR, vd: "#FF0000" - dùng để hiển thị cục màu tròn trên UI)

- `sizes`
  - `id` (INT, PK)
  - `name` (VARCHAR, vd: "S", "M", "L", "XL")

- `product_variants`
  - `id` (INT, PK)
  - `product_id` (INT, FK)
  - `color_id` (INT, FK)
  - `size_id` (INT, FK)
  - `stock_quantity` (INT)
  - *Lưu ý: product_id, color_id, size_id kết hợp lại là Unique để tránh trùng lặp.*

- **Bảng `cart_items` và `order_details`**: 
  - Đổi cột `product_id` thành `variant_id` (hoặc giữ `product_id` và thêm `variant_id`). Tối ưu nhất là dùng `variant_id` làm khóa ngoại liên kết tới `product_variants`.

- **Bảng `products`**:
  - Có thể giữ lại `stock_quantity` làm tổng tồn kho (trigger update khi variant thay đổi) hoặc bỏ đi (tính SUM(variants) khi query). Dễ nhất là tính tổng động từ `product_variants`.

## 2. Các Model & DAO cần tạo/sửa

- **Mới**: `Color.java`, `Size.java`, `ProductVariant.java`.
- **Mới**: `ColorDAO`, `SizeDAO`, `ProductVariantDAO`.
- **Cập nhật**: `CartItem.java` và `OrderDetail.java` (thêm biến `ProductVariant variant`).
- **Cập nhật**: `CartDAO` và `OrderDAO` để map dữ liệu với `variant_id`.

## 3. Giao diện Client (Người mua)

- **Trang Chi Tiết Sản Phẩm (`product-detail.jsp`)**:
  - Gọi API / Ajax hoặc Load trực tiếp JSP để hiển thị danh sách Màu sắc và Kích cỡ có sẵn.
  - Khi user chọn Màu "Đỏ", các Size hết hàng (hoặc không tồn tại) sẽ bị vô hiệu hóa (disabled).
  - Tồn kho hiển thị trên web sẽ nhảy số tương ứng với tổ hợp Màu-Size đang chọn.
  - Nhấn nút "Thêm vào giỏ" sẽ gửi `variant_id` lên server thay vì `product_id`.
- **Trang Giỏ hàng & Đơn hàng**:
  - Hiển thị thông tin Tên Sản Phẩm + Thuộc tính (Vd: Áo Vớ Vẩn - Màu Đỏ - Size L).

## 4. Giao diện Admin

- **Trang Quản lý Thuộc tính**: Thêm 2 menu nhỏ để Admin thêm/sửa/xoá các Màu Sắc và Kích Cỡ có trong hệ thống.
- **Trang Quản lý Sản Phẩm**:
  - Form thêm mới / Edit sản phẩm sẽ có tab "Biến thể".
  - Cho phép Admin chọn nhiều Màu và Size, sau đó nhập tồn kho (stock) cho từng kết hợp.

## 5. Quy trình Migration dữ liệu cũ (Tùy chọn)

Vì hệ thống cũ lưu `stock_quantity` ở mức `products` và giỏ hàng cũ dùng `product_id`, khi deploy lên cần:
- Tạo một Color mặc định (Vd: "Mặc định") và Size mặc định ("Mặc định").
- Generate `product_variants` giả cho tất cả sản phẩm hiện tại, gắn toàn bộ stock cũ sang variant mới.
- Update `cart_items` và `order_details` hiện có sang ID của variant mặc định này để không mất dữ liệu.
