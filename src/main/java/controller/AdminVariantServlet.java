package controller;

import dao.ColorDAO;
import dao.ProductDAO;
import dao.ProductVariantDAO;
import dao.SizeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Color;
import model.Product;
import model.ProductVariant;
import model.Size;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/products/variants", "/admin/products/variants/add", "/admin/products/variants/delete"})
public class AdminVariantServlet extends HttpServlet {
    private ProductVariantDAO variantDAO = new ProductVariantDAO();
    private ProductDAO productDAO = new ProductDAO();
    private ColorDAO colorDAO = new ColorDAO();
    private SizeDAO sizeDAO = new SizeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/products/variants".equals(path)) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                Product product = productDAO.getProductById(productId);
                if (product == null) {
                    resp.sendRedirect(req.getContextPath() + "/admin/products");
                    return;
                }
                
                List<ProductVariant> variants = variantDAO.getVariantsByProductId(productId);
                List<Color> colors = colorDAO.getAllColors();
                List<Size> sizes = sizeDAO.getAllSizes();
                
                req.setAttribute("product", product);
                req.setAttribute("variants", variants);
                req.setAttribute("colors", colors);
                req.setAttribute("sizes", sizes);
                req.setAttribute("pageTitle", "Quản lý biến thể: " + product.getName());
                req.setAttribute("activePage", "products");
                req.setAttribute("contentPage", "/WEB-INF/views/admin/variants/variants.jsp");
                req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = req.getServletPath();

        if ("/admin/products/variants/add".equals(path)) {
            try {
                int productId = Integer.parseInt(req.getParameter("productId"));
                int colorId = Integer.parseInt(req.getParameter("colorId"));
                int sizeId = Integer.parseInt(req.getParameter("sizeId"));
                int stockQuantity = Integer.parseInt(req.getParameter("stockQuantity"));

                ProductVariant pv = new ProductVariant();
                pv.setProductId(productId);
                pv.setColorId(colorId);
                pv.setSizeId(sizeId);
                pv.setStockQuantity(stockQuantity);
                
                variantDAO.addOrUpdateVariant(pv);
                resp.sendRedirect(req.getContextPath() + "/admin/products/variants?productId=" + productId);
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
        } else if ("/admin/products/variants/delete".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                int productId = Integer.parseInt(req.getParameter("productId"));
                variantDAO.deleteVariant(id);
                resp.sendRedirect(req.getContextPath() + "/admin/products/variants?productId=" + productId);
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
        }
    }
}
