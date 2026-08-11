package controller;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Product;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

@WebServlet(urlPatterns = {"/admin/products", "/admin/products/add", "/admin/products/update", "/admin/products/delete", "/admin/products/restore"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class AdminProductServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private dao.CategoryDAO categoryDAO = new dao.CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        if ("/admin/products".equals(path)) {
            String category = req.getParameter("category");
            String pageStr = req.getParameter("page");
            int page = 1;
            int pageSize = 10;
            if (pageStr != null) {
                try {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) page = 1;
                } catch (NumberFormatException ignored) {}
            }

            List<Product> products = productDAO.getProductsAdminPaginated(category, page, pageSize);
            int totalProducts = productDAO.getTotalProductsAdminCount(category);
            int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
            if (totalPages < 1) totalPages = 1;

            if (category != null && !category.trim().isEmpty()) {
                req.setAttribute("selectedCategory", category.trim());
            }

            req.setAttribute("products", products);
            req.setAttribute("page", page);
            req.setAttribute("totalPages", totalPages);
            req.setAttribute("totalProducts", totalProducts);
            req.setAttribute("pageTitle", "Quản lý sản phẩm");
            req.setAttribute("activePage", "products");
            req.setAttribute("contentPage", "/WEB-INF/views/admin/products/products.jsp");
            req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
        } else if ("/admin/products/update".equals(path)) {
            try {
                int id = Integer.parseInt(req.getParameter("id"));
                Product product = productDAO.getProductById(id);
                req.setAttribute("product", product);
                req.setAttribute("categories", categoryDAO.getAllCategories());
                req.setAttribute("pageTitle", "Cập nhật sản phẩm #" + id);
                req.setAttribute("activePage", "products");
                req.setAttribute("contentPage", "/WEB-INF/views/admin/products/product-form.jsp");
                req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/admin/products");
            }
        } else if ("/admin/products/add".equals(path)) {
            req.setAttribute("categories", categoryDAO.getAllCategories());
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
        p.setImageUrl(handleImageSource(req));
        p.setIsActive("true".equalsIgnoreCase(req.getParameter("isActive")) || "1".equals(req.getParameter("isActive")));
        return p;
    }

    private String handleImageSource(HttpServletRequest req) {
        try {
            Part filePart = req.getPart("imageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String submittedFileName = filePart.getSubmittedFileName();
                if (submittedFileName != null && !submittedFileName.trim().isEmpty()) {
                    String fileName = Paths.get(submittedFileName).getFileName().toString();
                    String ext = "";
                    int dotIdx = fileName.lastIndexOf('.');
                    if (dotIdx >= 0) {
                        ext = fileName.substring(dotIdx);
                    }
                    String savedFileName = "prod_" + System.currentTimeMillis() + ext;
                    
                    // Save to server deployed directory
                    String uploadPath = req.getServletContext().getRealPath("/assets/images/products");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    File serverFile = new File(uploadDir, savedFileName);
                    try (InputStream input = filePart.getInputStream()) {
                        Files.copy(input, serverFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }

                    // Save to local workspace source folder if running in development
                    try {
                        File srcDir = new File(req.getServletContext().getRealPath("/").split("target")[0] + "src/main/webapp/assets/images/products");
                        if (srcDir.exists() || srcDir.mkdirs()) {
                            File srcFile = new File(srcDir, savedFileName);
                            Files.copy(serverFile.toPath(), srcFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                        }
                    } catch (Exception ignored) {}

                    return req.getContextPath() + "/assets/images/products/" + savedFileName;
                }
            }
        } catch (Exception e) {
            // Not a multipart file upload or failed, fallback to url
        }

        // Fallback to text imageUrl input
        String imageUrl = req.getParameter("imageUrl");
        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
            return imageUrl.trim();
        }

        // If updating an existing product and no new image was submitted, retain existing imageUrl
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Product existing = productDAO.getProductById(id);
                if (existing != null && existing.getImageUrl() != null) {
                    return existing.getImageUrl();
                }
            } catch (Exception ignored) {}
        }
        return "";
    }
}
