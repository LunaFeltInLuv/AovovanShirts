package controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/products", "/product-detail"})
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/product-detail".equals(path)) {
            String idStr = req.getParameter("id");
            if (idStr != null) {
                try {
                    int id = Integer.parseInt(idStr);
                    Product product = productDAO.getProductById(id);
                    if (product != null) {
                        List<model.ProductVariant> variants = new dao.ProductVariantDAO().getVariantsByProductId(id);
                        req.setAttribute("product", product);
                        req.setAttribute("variants", variants);
                        req.setAttribute("pageTitle", product.getName() + " - Áo Vớ Vẩn");
                        req.setAttribute("activePage", "products");
                        req.setAttribute("contentPage", "/WEB-INF/views/client/pages/product-detail.jsp");
                        req.getRequestDispatcher("/WEB-INF/views/client/layout/layout.jsp").forward(req, resp);
                        return;
                    }
                } catch (NumberFormatException ignored) {}
            }
            resp.sendRedirect(req.getContextPath() + "/products");
        } else {
            String keyword = req.getParameter("keyword");
            String category = req.getParameter("category");
            String pageStr = req.getParameter("page");
            int page = 1;
            int pageSize = 12;

            if (pageStr != null) {
                try {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) page = 1;
                } catch (NumberFormatException ignored) {}
            }

            List<Product> products = productDAO.searchProducts(keyword, category, page, pageSize);
            int totalProducts = productDAO.getTotalProductsCount(keyword, category);
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            if (totalPages < 1) totalPages = 1;

            req.setAttribute("products", products);
            req.setAttribute("keyword", keyword);
            req.setAttribute("category", category);
            req.setAttribute("page", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalProducts", totalProducts);
            req.setAttribute("pageTitle", "Cửa hàng sản phẩm - Áo Vớ Vẩn");
            req.setAttribute("activePage", "products");
            req.setAttribute("contentPage", "/WEB-INF/views/client/pages/products.jsp");

            req.getRequestDispatcher("/WEB-INF/views/client/layout/layout.jsp").forward(req, resp);
        }
    }
}
