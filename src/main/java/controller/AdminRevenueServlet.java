package controller;

import dao.ReportDAO;
import model.ReportItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/revenue")
public class AdminRevenueServlet extends HttpServlet {
    private ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<ReportItem> revenueByDate = reportDAO.getRevenueByDate();
        List<ReportItem> topCustomers = reportDAO.getTopCustomers(5);
        List<ReportItem> topProducts = reportDAO.getTopProducts(5);

        req.setAttribute("revenueByDate", revenueByDate);
        req.setAttribute("topCustomers", topCustomers);
        req.setAttribute("topProducts", topProducts);

        req.setAttribute("pageTitle", "Báo cáo doanh thu");
        req.setAttribute("activePage", "revenue");
        req.setAttribute("contentPage", "/WEB-INF/views/admin/revenue/index.jsp");

        req.getRequestDispatcher("/WEB-INF/views/admin/layout/layout.jsp").forward(req, resp);
    }
}
