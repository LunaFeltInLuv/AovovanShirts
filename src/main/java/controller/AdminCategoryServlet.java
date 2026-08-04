package controller;

import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Category;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/categories", "/admin/categories/update", "/admin/categories/delete"})
public class AdminCategoryServlet extends HttpServlet {
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/categories".equals(path)) {
            List<Category> categories = categoryDAO.getAllCategories();
            req.setAttribute("categories", categories);
            req.setAttribute("pageTitle", "Quản lý danh mục");
            req.setAttribute("activePage", "categories");
            req.setAttribute("contentPage", "/WEB-INF/views/admin/categories/categories.jsp");
            req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/admin/categories/update".equals(path)) {
            String oldName = req.getParameter("oldName");
            String newName = req.getParameter("newName");
            categoryDAO.updateCategory(oldName, newName);
        } else if ("/admin/categories/delete".equals(path)) {
            String name = req.getParameter("name");
            categoryDAO.deleteCategory(name);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/categories");
    }
}
