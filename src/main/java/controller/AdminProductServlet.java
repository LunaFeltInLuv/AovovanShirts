package controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/products", "/admin/products/add", "/admin/products/update", "/admin/products/delete", "/admin/products/restore"})
public class AdminProductServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/products".equals(path)) {
            List<Product> products = productDAO.getAllProductsAdmin();
            req.setAttribute("products", products);
            req.setAttribute("pageTitle", "Quản lý sản phẩm");
            req.setAttribute("activePage", "products");
            req.setAttribute("contentPage", "/WEB-INF/views/admin/products/products.jsp");
            req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
        } else if ("/admin/products/update".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product product = productDAO.getProductById(id);
                req.setAttribute("product", product);
                req.setAttribute("pageTitle", "Cập nhật sản phẩm #" + id);
                req.setAttribute("activePage", "products");
                req.setAttribute("contentPage", "/WEB-INF/views/admin/products/product-form.jsp");
                req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
        } else if ("/admin/products/add".equals(path)) {
            req.setAttribute("pageTitle", "Thêm sản phẩm mới");
            req.setAttribute("activePage", "products");
            req.setAttribute("contentPage", "/WEB-INF/views/admin/products/product-form.jsp");
            req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/admin/products/add".equals(path)) {
            Product p = extractProductFromRequest(req);
            productDAO.addProduct(p);
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else if ("/admin/products/update".equals(path)) {
            Product p = extractProductFromRequest(req);
            try {
                p.setId(Integer.parseInt(req.getParameter("id")));
                productDAO.updateProduct(p);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else if ("/admin/products/delete".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                boolean force = "true".equalsIgnoreCase(req.getParameter("force"));
                productDAO.deleteProduct(id, force);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        } else if ("/admin/products/restore".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                productDAO.restoreProduct(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products");
        }
    }

    private Product extractProductFromRequest(HttpServletRequest req) {
        Product p = new Product();
        p.setName(req.getParameter("name"));
        p.setDescription(req.getParameter("description"));
        try {
            p.setPrice(new BigDecimal(req.getParameter("price")));
        } catch (Exception e) {
            p.setPrice(BigDecimal.ZERO);
        }
        try {
            p.setStockQuantity(Integer.parseInt(req.getParameter("stockQuantity")));
        } catch (Exception e) {
            p.setStockQuantity(0);
        }
        p.setCategory(req.getParameter("category"));
        p.setImageUrl(req.getParameter("imageUrl"));
        p.setIsActive("true".equalsIgnoreCase(req.getParameter("isActive")) || "1".equals(req.getParameter("isActive")));
        return p;
    }
}
