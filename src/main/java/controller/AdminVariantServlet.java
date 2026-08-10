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

@WebServlet(urlPatterns = {
    "/admin/variants",
    "/admin/variants/add",
    "/admin/variants/delete",
    "/admin/variants/clone",
    "/admin/colors/add",
    "/admin/colors/delete",
    "/admin/sizes/add",
    "/admin/sizes/delete"
})
public class AdminVariantServlet extends HttpServlet {
    private ProductVariantDAO variantDAO = new ProductVariantDAO();
    private ProductDAO productDAO = new ProductDAO();
    private ColorDAO colorDAO = new ColorDAO();
    private SizeDAO sizeDAO = new SizeDAO();

    private String getPath(HttpServletRequest req) {
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        if (uri.startsWith(contextPath)) {
            return uri.substring(contextPath.length());
        }
        return uri;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = getPath(req);
        if ("/admin/variants".equals(path)) {
            List<Product> products = productDAO.getAllProducts();
            List<Color> colors = colorDAO.getAllColors();
            List<Size> sizes = sizeDAO.getAllSizes();

            String pIdStr = req.getParameter("productId");
            Product selectedProduct = null;
            List<ProductVariant> variants = null;

            if (pIdStr != null && !pIdStr.trim().isEmpty()) {
                try {
                    int pId = Integer.parseInt(pIdStr);
                    selectedProduct = productDAO.getProductById(pId);
                    if (selectedProduct != null) {
                        variants = variantDAO.getVariantsByProductId(pId);
                    }
                } catch (Exception ignored) {}
            } else if (products != null && !products.isEmpty()) {
                selectedProduct = products.get(0);
                variants = variantDAO.getVariantsByProductId(selectedProduct.getId());
            }

            req.setAttribute("products", products);
            req.setAttribute("selectedProduct", selectedProduct);
            req.setAttribute("variants", variants);
            req.setAttribute("colors", colors);
            req.setAttribute("sizes", sizes);
            req.setAttribute("activeTab", req.getParameter("tab") != null ? req.getParameter("tab") : "variants");
            req.setAttribute("pageTitle", "Quản lý biến thể");
            req.setAttribute("activePage", "variants");
            req.setAttribute("contentPage", "/WEB-INF/views/admin/variants/variants.jsp");
            req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String path = getPath(req);

        if ("/admin/variants/add".equals(path)) {
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
                resp.sendRedirect(req.getContextPath() + "/admin/variants?productId=" + productId + "&tab=variants");
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/admin/variants");
            }
        } else if ("/admin/variants/delete".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                int productId = Integer.parseInt(req.getParameter("productId"));
                variantDAO.deleteVariant(id);
                resp.sendRedirect(req.getContextPath() + "/admin/variants?productId=" + productId + "&tab=variants");
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/admin/variants");
            }
        } else if ("/admin/variants/clone".equals(path)) {
            try {
                int targetProductId = Integer.parseInt(req.getParameter("targetProductId"));
                int sourceProductId = Integer.parseInt(req.getParameter("sourceProductId"));
                int defaultStock = Integer.parseInt(req.getParameter("defaultStock"));

                List<ProductVariant> sourceVariants = variantDAO.getVariantsByProductId(sourceProductId);
                int count = 0;
                for (ProductVariant v : sourceVariants) {
                    ProductVariant pv = new ProductVariant();
                    pv.setProductId(targetProductId);
                    pv.setColorId(v.getColorId());
                    pv.setSizeId(v.getSizeId());
                    pv.setStockQuantity(defaultStock);
                    
                    variantDAO.addOrUpdateVariant(pv);
                    count++;
                }
                req.getSession().setAttribute("successMessage", "Đã sao chép thành công " + count + " biến thể!");
                resp.sendRedirect(req.getContextPath() + "/admin/variants?productId=" + targetProductId + "&tab=variants");
            } catch (Exception e) {
                e.printStackTrace();
                req.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi sao chép biến thể!");
                resp.sendRedirect(req.getContextPath() + "/admin/variants");
            }
        } else if ("/admin/colors/add".equals(path)) {
            try {
                String name = req.getParameter("name");
                String hexCode = req.getParameter("hexCode");
                if (name != null && !name.trim().isEmpty()) {
                    if (colorDAO.isColorExists(name.trim())) {
                        req.getSession().setAttribute("errorMessage", "Tên màu sắc '" + name.trim() + "' đã tồn tại!");
                    } else {
                        Color c = new Color();
                        c.setName(name.trim());
                        c.setHexCode(hexCode != null ? hexCode.trim() : "#000000");
                        colorDAO.addColor(c);
                        req.getSession().setAttribute("successMessage", "Thêm màu sắc thành công!");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi thêm màu sắc!");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/variants?tab=colors");
        } else if ("/admin/colors/delete".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                colorDAO.deleteColor(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/variants?tab=colors");
        } else if ("/admin/sizes/add".equals(path)) {
            try {
                String name = req.getParameter("name");
                if (name != null && !name.trim().isEmpty()) {
                    if (sizeDAO.isSizeExists(name.trim())) {
                        req.getSession().setAttribute("errorMessage", "Tên kích cỡ '" + name.trim() + "' đã tồn tại!");
                    } else {
                        Size s = new Size();
                        s.setName(name.trim());
                        sizeDAO.addSize(s);
                        req.getSession().setAttribute("successMessage", "Thêm kích cỡ thành công!");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                req.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi thêm kích cỡ!");
            }
            resp.sendRedirect(req.getContextPath() + "/admin/variants?tab=sizes");
        } else if ("/admin/sizes/delete".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                sizeDAO.deleteSize(id);
            } catch (Exception e) {
                e.printStackTrace();
            }
            resp.sendRedirect(req.getContextPath() + "/admin/variants?tab=sizes");
        }
    }
}
