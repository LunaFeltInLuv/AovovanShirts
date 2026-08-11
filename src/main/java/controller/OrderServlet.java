package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Order;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/orders", "/order-detail", "/api/orders", "/api/order-details"})
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            String path = req.getServletPath();
            if (path.startsWith("/api/")) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                resp.getWriter().write("{\"error\":\"Unauthorized\"}");
                return;
            }
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();
        if ("/api/orders".equals(path)) {
            handleApiOrders(req, resp, user.getId());
        } else if ("/api/order-details".equals(path)) {
            handleApiOrderDetails(req, resp, user.getId());
        } else if ("/order-detail".equals(path)) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                try {
                    int orderId = Integer.parseInt(idStr);
                    Order order = orderDAO.getOrderById(orderId);
                    if (order != null && (order.getUserId() == user.getId())) {
                        req.setAttribute("order", order);
                        req.setAttribute("pageTitle", "Chi tiết đơn hàng #" + orderId + " - Áo Vớ Vẩn");
                        req.setAttribute("activePage", "orders");
                        req.setAttribute("contentPage", "/WEB-INF/views/client/pages/order-detail.jsp");

                        req.getRequestDispatcher("/WEB-INF/views/client/layout/layout.jsp").forward(req, resp);
                        return;
                    }
                } catch (NumberFormatException ignored) {}
            }
            resp.sendRedirect(req.getContextPath() + "/orders");
        } else {
            int page = 1;
            int pageSize = 5;
            String pageStr = req.getParameter("page");
            if (pageStr != null) {
                try { page = Integer.parseInt(pageStr); } catch (Exception ignored) {}
            }

            List<Order> orders = orderDAO.getOrdersByUserIdPaginated(user.getId(), page, pageSize);
            int totalOrders = orderDAO.getTotalOrdersByUserId(user.getId());
            boolean hasMore = (page * pageSize) < totalOrders;

            req.setAttribute("orders", orders);
            req.setAttribute("page", page);
            req.setAttribute("hasMore", hasMore);
            req.setAttribute("totalOrders", totalOrders);
            req.setAttribute("pageTitle", "Lịch sử đơn hàng - Áo Vớ Vẩn");
            req.setAttribute("activePage", "orders");
            req.setAttribute("contentPage", "/WEB-INF/views/client/pages/orders.jsp");

            req.getRequestDispatcher("/WEB-INF/views/client/layout/layout.jsp").forward(req, resp);
        }
    }

    private void handleApiOrders(HttpServletRequest req, HttpServletResponse resp, int userId) throws IOException {
        resp.setContentType("application/json; charset=UTF-8");
        int page = 1;
        int pageSize = 5;
        String pageStr = req.getParameter("page");
        if (pageStr != null) {
            try { page = Integer.parseInt(pageStr); } catch (Exception ignored) {}
        }

        List<Order> orders = orderDAO.getOrdersByUserIdPaginated(userId, page, pageSize);
        int totalOrders = orderDAO.getTotalOrdersByUserId(userId);
        boolean hasMore = (page * pageSize) < totalOrders;

        StringBuilder sb = new StringBuilder();
        sb.append("{");
        sb.append("\"page\":").append(page).append(",");
        sb.append("\"hasMore\":").append(hasMore).append(",");
        sb.append("\"totalOrders\":").append(totalOrders).append(",");
        sb.append("\"orders\":[");
        for (int i = 0; i < orders.size(); i++) {
            Order o = orders.get(i);
            sb.append("{");
            sb.append("\"id\":").append(o.getId()).append(",");
            sb.append("\"orderDate\":\"").append(o.getOrderDate() != null ? o.getOrderDate().toString() : "").append("\",");
            sb.append("\"totalAmount\":").append(o.getTotalAmount() != null ? o.getTotalAmount().toPlainString() : "0").append(",");
            sb.append("\"status\":\"").append(escapeJson(o.getStatus())).append("\",");
            sb.append("\"shippingAddress\":\"").append(escapeJson(o.getShippingAddress())).append("\"");
            sb.append("}");
            if (i < orders.size() - 1) sb.append(",");
        }
        sb.append("]}");

        resp.getWriter().write(sb.toString());
    }

    private void handleApiOrderDetails(HttpServletRequest req, HttpServletResponse resp, int userId) throws IOException {
        resp.setContentType("application/json; charset=UTF-8");
        String idStr = req.getParameter("id");
        if (idStr == null) {
            resp.getWriter().write("{\"error\":\"Missing order id\"}");
            return;
        }

        try {
            int orderId = Integer.parseInt(idStr);
            Order order = orderDAO.getOrderById(orderId);
            if (order == null || order.getUserId() != userId) {
                resp.getWriter().write("{\"error\":\"Order not found\"}");
                return;
            }

            List<model.OrderDetail> details = order.getDetails();
            StringBuilder sb = new StringBuilder();
            sb.append("{");
            sb.append("\"orderId\":").append(orderId).append(",");
            sb.append("\"details\":[");
            if (details != null) {
                for (int i = 0; i < details.size(); i++) {
                    model.OrderDetail d = details.get(i);
                    sb.append("{");
                    sb.append("\"productId\":").append(d.getProductId()).append(",");
                    sb.append("\"quantity\":").append(d.getQuantity()).append(",");
                    sb.append("\"price\":").append(d.getPrice() != null ? d.getPrice().toPlainString() : "0").append(",");
                    sb.append("\"totalLine\":").append(d.getTotalLine() != null ? d.getTotalLine().toPlainString() : "0").append(",");
                    sb.append("\"productName\":\"").append(d.getProduct() != null ? escapeJson(d.getProduct().getName()) : "").append("\",");
                    sb.append("\"imageUrl\":\"").append(d.getProduct() != null ? escapeJson(d.getProduct().getImageUrl()) : "").append("\"");
                    sb.append("}");
                    if (i < details.size() - 1) sb.append(",");
                }
            }
            sb.append("]}");
            resp.getWriter().write(sb.toString());
        } catch (NumberFormatException e) {
            resp.getWriter().write("{\"error\":\"Invalid id format\"}");
        }
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\\", "\\\\")
                    .replace("\"", "\\\"")
                    .replace("\b", "\\b")
                    .replace("\f", "\\f")
                    .replace("\n", "\\n")
                    .replace("\r", "\\r")
                    .replace("\t", "\\t");
    }
}
