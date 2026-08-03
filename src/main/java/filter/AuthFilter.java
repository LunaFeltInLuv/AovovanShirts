package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Role;
import model.User;
import dao.UserDAO;

import java.io.IOException;
import java.util.List;

@WebFilter(urlPatterns = {"/cart/*", "/checkout/*", "/orders/*", "/admin/*"})
public class AuthFilter implements Filter {
    private UserDAO userDAO = new UserDAO();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User user = (session != null) ? (User) session.getAttribute("user") : null;
        String path = req.getServletPath();

        // 1. Yêu cầu đăng nhập
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=auth_required");
            return;
        }

        // 2. Yêu cầu quyền Admin / Product Manager khi truy cập /admin/*
        if (path.startsWith("/admin")) {
            List<Role> roles = userDAO.getUserRoles(user.getId());
            boolean isAdminOrManager = false;
            for (Role r : roles) {
                if ("admin".equalsIgnoreCase(r.getName()) || "product_manager".equalsIgnoreCase(r.getName())) {
                    isAdminOrManager = true;
                    break;
                }
            }

            if (!isAdminOrManager) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập khu vực quản trị!");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
