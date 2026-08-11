package controller;

import java.io.IOException;
import java.util.List;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.User;

@WebServlet({ "/cart", "/cart/add", "/cart/update", "/cart/remove" })
public class CartServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        List<CartItem> items = cartDAO.getCartItemsByUserId(user.getId());

        java.math.BigDecimal totalSum = java.math.BigDecimal.ZERO;
        for (CartItem item : items) {
            if (item.getLineTotal() != null) {
                totalSum = totalSum.add(item.getLineTotal());
            }
        }

        req.setAttribute("cartItems", items);
        req.setAttribute("totalSum", totalSum);
        req.setAttribute("pageTitle", "Giỏ hàng của bạn - Áo Vớ Vẩn");
        req.setAttribute("activePage", "cart");
        req.setAttribute("contentPage", "/WEB-INF/views/client/pages/cart.jsp");

        req.getRequestDispatcher("/WEB-INF/views/client/layout/layout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        boolean isXmlHttpRequest = "XMLHttpRequest".equals(req.getHeader("X-Requested-With"));

        if (user == null) {
            if (isXmlHttpRequest) {
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"success\":false,\"redirect\":\"" + req.getContextPath() + "/login\",\"message\":\"Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng!\"}");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();
        int cartId = cartDAO.getCartIdByUserId(user.getId());

        if ("/cart/add".equals(path)) {
            boolean success = false;
            String errorMsg = null;
            try {
                String productIdStr = req.getParameter("productId");
                if (productIdStr == null || productIdStr.trim().isEmpty()) {
                    productIdStr = req.getParameter("id");
                }

                if (productIdStr == null || productIdStr.trim().isEmpty()) {
                    errorMsg = "Không tìm thấy mã sản phẩm!";
                } else {
                    int productId = Integer.parseInt(productIdStr.trim());
                    int quantity = 1;
                    String qtyStr = req.getParameter("quantity");
                    if (qtyStr != null && !qtyStr.trim().isEmpty()) {
                        quantity = Integer.parseInt(qtyStr.trim());
                    }
                    if (quantity <= 0) {
                        errorMsg = "Số lượng mua phải lớn hơn 0!";
                    } else {
                        errorMsg = cartDAO.addToCartWithMessage(user.getId(), productId, quantity);
                        success = (errorMsg == null);
                    }
                }
            } catch (NumberFormatException e) {
                errorMsg = "Mã sản phẩm hoặc số lượng không hợp lệ!";
            } catch (Exception e) {
                e.printStackTrace();
                errorMsg = e.getMessage();
            }

            if (isXmlHttpRequest) {
                resp.setContentType("application/json;charset=UTF-8");
                if (success) {
                    resp.getWriter()
                            .write("{\"success\":true,\"message\":\"Đã thêm sản phẩm vào giỏ hàng thành công!\"}");
                } else {
                    String cleanMsg = (errorMsg != null)
                            ? errorMsg.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n", " ").replace("\r", "")
                            : "Không thể thêm sản phẩm vào giỏ hàng!";
                    resp.getWriter().write(
                            "{\"success\":false,\"message\":\"" + cleanMsg + "\"}");
                }
                return;
            }

            if (!success) {
                req.getSession().setAttribute("cartError",
                        errorMsg != null ? errorMsg : "Không thể thêm sản phẩm vào giỏ hàng!");
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else if ("/cart/update".equals(path)) {
            boolean updated = false;
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));
                if (quantity < 1) {
                    quantity = 1;
                }
                updated = cartDAO.updateCartItemQuantity(cartId, productId, quantity);
            } catch (Exception e) {
                e.printStackTrace();
            }
            if (isXmlHttpRequest) {
                resp.setContentType("application/json;charset=UTF-8");
                resp.getWriter().write("{\"success\":" + updated + "}");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else if ("/cart/remove".equals(path)) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                cartDAO.removeCartItem(cartId, productId);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        }
    }
}
