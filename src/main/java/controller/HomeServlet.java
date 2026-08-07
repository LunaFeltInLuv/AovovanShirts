package controller;

import java.io.IOException;
import java.util.List;
import java.util.List;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;

@WebServlet({"", "/home", "/aovovan"})
public class HomeServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        
    
        if (path == null || path.isEmpty() || "/".equals(path)) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }   
        List<Product> products = productDAO.getAllProducts();
        
        request.setAttribute("products", products);
        request.setAttribute("pageTitle", "Trang chủ - Áo Vớ Vẩn");
        request.setAttribute("activePage", "home");
        request.setAttribute("contentPage", "/WEB-INF/views/client/pages/home.jsp");
        request.getRequestDispatcher("/WEB-INF/views/client/layout/layout.jsp").forward(request, response);
    }
}
