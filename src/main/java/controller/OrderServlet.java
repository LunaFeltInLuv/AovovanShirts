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

@WebServlet(urlPatterns = {"/orders", "/order-detail"})
public class OrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();
        if ("/order-detail".equals(path)) {
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
            List<Order> orders = orderDAO.getOrdersByUserId(user.getId());
            req.setAttribute("orders", orders);
            req.setAttribute("pageTitle", "Lịch sử đơn hàng - Áo Vớ Vẩn");
            req.setAttribute("activePage", "orders");
            req.setAttribute("contentPage", "/WEB-INF/views/client/pages/orders.jsp");

            req.getRequestDispatcher("/WEB-INF/views/client/layout/layout.jsp").forward(req, resp);
        }
    }
}
