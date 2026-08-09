package controller;

import dao.SizeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Size;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/sizes", "/admin/sizes/add", "/admin/sizes/delete"})
public class AdminSizeServlet extends HttpServlet {
    private SizeDAO sizeDAO = new SizeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/sizes".equals(path)) {
            List<Size> sizes = sizeDAO.getAllSizes();
            req.setAttribute("sizes", sizes);
            req.setAttribute("pageTitle", "Quản lý Kích cỡ");
            req.setAttribute("activePage", "sizes");
            req.setAttribute("contentPage", "/WEB-INF/views/admin/variants/sizes.jsp");
            req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/admin/sizes/add".equals(path)) {
            Size size = new Size();
            size.setName(req.getParameter("name"));
            sizeDAO.addSize(size);
            resp.sendRedirect(req.getContextPath() + "/admin/sizes");
        } else if ("/admin/sizes/delete".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                sizeDAO.deleteSize(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/sizes");
        }
    }
}
