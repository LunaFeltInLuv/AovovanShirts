package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

@WebServlet(urlPatterns = {"/login", "/register", "/logout"})
public class AuthServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/logout".equals(path)) {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        if ("/login".equals(path)) {
            req.setAttribute("pageTitle", "Đăng nhập - Áo Vớ Vẩn");
            req.getRequestDispatcher("/WEB-INF/views/client/pages/login.jsp").forward(req, resp);
        } else if ("/register".equals(path)) {
            req.setAttribute("pageTitle", "Đăng ký tài khoản - Áo Vớ Vẩn");
            req.getRequestDispatcher("/WEB-INF/views/client/pages/register.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        if ("/login".equals(path)) {
            handleLogin(req, resp);
        } else if ("/register".equals(path)) {
            handleRegister(req, resp);
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = userDAO.getUserByUsername(username);
        if (user != null && password != null && password.equals(user.getPassword_hash())) {
            if (Boolean.FALSE.equals(user.getActive())) {
                req.setAttribute("error", "Tài khoản của bạn đã bị khóa!");
                doGet(req, resp);
                return;
            }
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            java.util.List<model.Role> roles = userDAO.getUserRoles(user.getId());
            boolean isAdmin = false;
            if (roles != null) {
                for (model.Role r : roles) {
                    if ("admin".equalsIgnoreCase(r.getName()) || "product_manager".equalsIgnoreCase(r.getName())) {
                        isAdmin = true;
                        break;
                    }
                }
            }
            session.setAttribute("isAdmin", isAdmin);
            resp.sendRedirect(req.getContextPath() + "/home");
        } else {
            req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không chính xác!");
            doGet(req, resp);
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");

        User user = new User();
        user.setUsername(username);
        user.setPassword_hash(password);
        user.setName(name);
        user.setPhone(phone);
        user.setEmail(email);
        user.setAddress(address);
        user.setActive(true);

        int userId = userDAO.addUser(user, null);
        if (userId > 0) {
            resp.sendRedirect(req.getContextPath() + "/login?registered=true");
        } else {
            req.setAttribute("error", "Đăng ký thất bại! Kiểm tra thông tin (username/email có thể đã tồn tại).");
            doGet(req, resp);
        }
    }
}
