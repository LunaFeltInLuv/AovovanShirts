package controller;

import dao.CartDAO;
import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Order;
import model.OrderDetail;
import model.User;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int cartId = cartDAO.getCartIdByUserId(user.getId());
        List<CartItem> items = cartDAO.getCartItems(cartId);
        if (items.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            if (item.getProduct() != null) {
                total = total.add(item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity())));
            }
        }

        req.setAttribute("cartItems", items);
        req.setAttribute("totalAmount", total);
        req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        int cartId = cartDAO.getCartIdByUserId(user.getId());
        List<CartItem> items = cartDAO.getCartItems(cartId);
        if (items.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        String shippingAddress = req.getParameter("shippingAddress");
        String paymentMethod = req.getParameter("paymentMethod");
        String note = req.getParameter("note");

        BigDecimal totalAmount = BigDecimal.ZERO;
        List<OrderDetail> details = new ArrayList<>();

        for (CartItem item : items) {
            if (item.getProduct() != null) {
                BigDecimal price = item.getProduct().getPrice();
                BigDecimal lineTotal = price.multiply(new BigDecimal(item.getQuantity()));
                totalAmount = totalAmount.add(lineTotal);

                OrderDetail od = new OrderDetail();
                od.setProductId(item.getProductId());
                od.setQuantity(item.getQuantity());
                od.setPrice(price);
                od.setTotalLine(lineTotal);
                details.add(od);
            }
        }

        Order order = new Order();
        order.setUserId(user.getId());
        order.setTotalAmount(totalAmount);
        order.setStatus("pending");
        order.setShippingAddress(shippingAddress);
        order.setPaymentMethod(paymentMethod);
        order.setNote(note);

        int orderId = orderDAO.createOrder(order, details);
        if (orderId > 0) {
            cartDAO.clearCart(cartId);
            resp.sendRedirect(req.getContextPath() + "/orders?success=true");
        } else {
            req.setAttribute("error", "Đặt hàng thất bại. Vui lòng thử lại!");
            doGet(req, resp);
        }
    }
}
