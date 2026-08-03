package controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/orders", "/admin/orders/detail", "/admin/orders/update-status"})
public class AdminOrderServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/orders/detail".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Order order = orderDAO.getOrderById(id);
                req.setAttribute("order", order);
                req.setAttribute("pageTitle", "Chi tiết đơn hàng #" + id);
                req.setAttribute("activePage", "orders");
                req.setAttribute("contentPage", "/WEB-INF/views/admin/orders/order-detail.jsp");
                req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
                return;
            } catch (Exception ignored) {}
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
        } else {
            List<Order> orders = orderDAO.getAllOrders();
            req.setAttribute("orders", orders);
            req.setAttribute("pageTitle", "Quản lý đơn hàng");
            req.setAttribute("activePage", "orders");
            req.setAttribute("contentPage", "/WEB-INF/views/admin/orders/orders.jsp");
            req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/orders/update-status".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                String status = req.getParameter("status");
                orderDAO.updateOrderStatus(id, status);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/orders");
        }
    }
}
