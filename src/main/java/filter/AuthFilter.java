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

@WebFilter(urlPatterns = {"/*"})
public class AuthFilter implements Filter {
    private UserDAO userDAO = new UserDAO();

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User user = (session != null) ? (User) session.getAttribute("user") : null;
        String path = req.getServletPath();

        if (user != null && session != null) {
            if (session.getAttribute("isAdmin") == null) {
                List<Role> roles = userDAO.getUserRoles(user.getId());
                boolean isAdmin = false;
                if (roles != null) {
                    for (Role r : roles) {
                        if ("admin".equalsIgnoreCase(r.getName()) || "product_manager".equalsIgnoreCase(r.getName())) {
                            isAdmin = true;
                            break;
                        }
                    }
                }
                session.setAttribute("isAdmin", isAdmin);
            }
        }

        // Protected paths require login
        boolean isProtected = path.startsWith("/cart") || path.startsWith("/checkout") || path.startsWith("/orders") || path.startsWith("/admin");
        if (isProtected && user == null) {
            resp.sendRedirect(req.getContextPath() + "/login?error=auth_required");
            return;
        }

        // Admin paths require admin or product_manager role
        if (path.startsWith("/admin")) {
            Boolean isAdmin = (session != null) ? (Boolean) session.getAttribute("isAdmin") : false;
            if (isAdmin == null || !isAdmin) {
                resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập khu vực quản trị!");
                return;
            }
        }

        chain.doFilter(request, response);
    }
}
