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

@WebServlet(urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setAttribute("pageTitle", "Hồ sơ cá nhân - Áo Vớ Vẩn");
        req.setAttribute("contentPage", "../pages/profile.jsp");
        req.setAttribute("activePage", "profile");
        req.getRequestDispatcher("/WEB-INF/views/client/layout/layout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");
        
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        String password = req.getParameter("password");
        
        User userToUpdate = userDAO.getUserById(sessionUser.getId());
        if (userToUpdate != null) {
            userToUpdate.setName(name);
            userToUpdate.setPhone(phone);
            userToUpdate.setEmail(email);
            userToUpdate.setAddress(address);
            
            if (password != null && !password.trim().isEmpty()) {
                userToUpdate.setPassword_hash(password);
            }
            
            boolean updated = userDAO.updateUser(userToUpdate);
            if (updated) {
                session.setAttribute("user", userToUpdate);
                req.setAttribute("successMessage", "Cập nhật thông tin thành công!");
            } else {
                req.setAttribute("errorMessage", "Cập nhật thông tin thất bại. Vui lòng thử lại.");
            }
        } else {
            req.setAttribute("errorMessage", "Không tìm thấy người dùng.");
        }
        
        doGet(req, resp);
    }
}
