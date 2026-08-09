package controller;

import dao.ColorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Color;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/colors", "/admin/colors/add", "/admin/colors/delete"})
public class AdminColorServlet extends HttpServlet {
    private ColorDAO colorDAO = new ColorDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/colors".equals(path)) {
            List<Color> colors = colorDAO.getAllColors();
            req.setAttribute("colors", colors);
            req.setAttribute("pageTitle", "Quản lý Màu sắc");
            req.setAttribute("activePage", "colors");
            req.setAttribute("contentPage", "/WEB-INF/views/admin/variants/colors.jsp");
            req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/admin/colors/add".equals(path)) {
            Color color = new Color();
            color.setName(req.getParameter("name"));
            color.setHexCode(req.getParameter("hexCode"));
            colorDAO.addColor(color);
            resp.sendRedirect(req.getContextPath() + "/admin/colors");
        } else if ("/admin/colors/delete".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                colorDAO.deleteColor(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/colors");
        }
    }
}
