package dao;

import model.ReportItem;
import utils.ConnectDB;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReportDAO {

    public List<ReportItem> getRevenueByDate() {
        List<ReportItem> list = new ArrayList<>();
        // Lấy doanh thu theo ngày (dd-mm-yyyy) của các đơn hàng đã hoàn thành
        String sql = "SELECT CONVERT(VARCHAR(10), order_date, 105) AS label, SUM(total_amount) AS revenue " +
                     "FROM orders " +
                     "WHERE status = 'delivered' " +
                     "GROUP BY CONVERT(VARCHAR(10), order_date, 105) " +
                     "ORDER BY label ASC";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ReportItem(rs.getString("label"), rs.getBigDecimal("revenue")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public java.math.BigDecimal getTotalRevenue() {
        String sql = "SELECT ISNULL(SUM(total_amount), 0) FROM orders WHERE status = 'delivered'";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getBigDecimal(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return java.math.BigDecimal.ZERO;
    }

    public int getDeliveredOrderCount() {
        String sql = "SELECT COUNT(*) FROM orders WHERE status = 'delivered'";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<ReportItem> getTopCustomers(int limit) {
        List<ReportItem> list = new ArrayList<>();
        String sql = "SELECT TOP (?) u.name AS label, SUM(o.total_amount) AS revenue " +
                     "FROM orders o JOIN users u ON o.user_id = u.id " +
                     "WHERE o.status = 'delivered' " +
                     "GROUP BY u.id, u.name " +
                     "ORDER BY revenue DESC";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new ReportItem(rs.getString("label"), rs.getBigDecimal("revenue")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<ReportItem> getTopProducts(int limit) {
        List<ReportItem> list = new ArrayList<>();
        String sql = "SELECT TOP (?) p.name AS label, SUM(od.total_line) AS revenue " +
                     "FROM order_details od " +
                     "JOIN products p ON od.product_id = p.id " +
                     "JOIN orders o ON od.order_id = o.id " +
                     "WHERE o.status = 'delivered' " +
                     "GROUP BY p.id, p.name " +
                     "ORDER BY revenue DESC";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, limit);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new ReportItem(rs.getString("label"), rs.getBigDecimal("revenue")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
