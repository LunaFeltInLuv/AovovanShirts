package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/users", "/admin/users/update", "/admin/users/delete"})
public class AdminUserServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/users".equals(path)) {
            String keyword = req.getParameter("keyword");
            String roleIdStr = req.getParameter("roleId");
            Integer roleId = null;
            if (roleIdStr != null && !roleIdStr.trim().isEmpty()) {
                try {
                    roleId = Integer.parseInt(roleIdStr);
                } catch (NumberFormatException ignored) {}
            }
            List<User> users = userDAO.getUsers(keyword, roleId, null, 1, 50);
            req.setAttribute("users", users);
            req.setAttribute("pageTitle", "Quản lý tài khoản");
            req.setAttribute("activePage", "users");
            req.setAttribute("contentPage", "/WEB-INF/views/admin/users/users.jsp");
            req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/admin/users/update".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                User user = userDAO.getUserById(id);
                if (user != null) {
                    user.setName(req.getParameter("name"));
                    user.setPhone(req.getParameter("phone"));
                    user.setEmail(req.getParameter("email"));
                    user.setAddress(req.getParameter("address"));
                    if (req.getParameter("isActive") != null) {
                        user.setActive("true".equalsIgnoreCase(req.getParameter("isActive")) || "1".equals(req.getParameter("isActive")));
                    }
                    userDAO.updateUser(user);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        } else if ("/admin/users/delete".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                boolean force = "true".equalsIgnoreCase(req.getParameter("force"));
                userDAO.deleteUser(id, force);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/users");
        }
    }
}
