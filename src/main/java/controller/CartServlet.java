package controller;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/cart", "/cart/add", "/cart/update", "/cart/remove"})
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

        int cartId = cartDAO.getCartIdByUserId(user.getId());
        List<CartItem> items = cartDAO.getCartItems(cartId);
        req.setAttribute("cartItems", items);
        req.setAttribute("pageTitle", "Giỏ hàng của bạn - Áo Vớ Vẩn");
        req.setAttribute("activePage", "cart");
        req.setAttribute("contentPage", "/WEB-INF/views/client/pages/cart.jsp");

        req.getRequestDispatcher("/WEB-INF/views/client/layout/layout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String path = req.getServletPath();
        int cartId = cartDAO.getCartIdByUserId(user.getId());

        if ("/cart/add".equals(path)) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                int quantity = 1;
                String qtyStr = req.getParameter("quantity");
                if (qtyStr != null) {
                    quantity = Integer.parseInt(qtyStr);
                }
                cartDAO.addToCart(user.getId(), productId, quantity);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } else if ("/cart/update".equals(path)) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));
                cartDAO.updateCartItemQuantity(cartId, productId, quantity);
            } catch (Exception e) {
                e.printStackTrace();
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
