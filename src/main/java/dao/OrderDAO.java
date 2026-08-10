package dao;

import model.Order;
import model.OrderDetail;
import model.Product;
import utils.ConnectDB;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int createOrder(Order order, List<OrderDetail> details) {
        String insertOrderSql = "INSERT INTO orders (user_id, total_amount, status, shipping_address, payment_method, note) " +
                "VALUES (?, ?, ?, ?, ?, ?)";
        String insertDetailSql = "INSERT INTO order_details (order_id, product_id, quantity, price, total_line) " +
                "VALUES (?, ?, ?, ?, ?)";
        String updateStockSql = "UPDATE products SET stock_quantity = stock_quantity - ? WHERE id = ?";

        Connection con = null;
        try {
            con = ConnectDB.getConnect();
            con.setAutoCommit(false);

            int orderId = -1;
            try (PreparedStatement psOrder = con.prepareStatement(insertOrderSql, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, order.getUserId());
                psOrder.setBigDecimal(2, order.getTotalAmount());
                psOrder.setString(3, order.getStatus() != null ? order.getStatus() : "pending");
                psOrder.setString(4, order.getShippingAddress());
                psOrder.setString(5, order.getPaymentMethod());
                psOrder.setString(6, order.getNote());
                psOrder.executeUpdate();

                try (ResultSet rs = psOrder.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderId = rs.getInt(1);
                    }
                }
            }

            if (orderId == -1) {
                con.rollback();
                return -1;
            }

            try (PreparedStatement psDetail = con.prepareStatement(insertDetailSql);
                 PreparedStatement psStock = con.prepareStatement(updateStockSql)) {
                for (OrderDetail detail : details) {
                    psDetail.setInt(1, orderId);
                    psDetail.setInt(2, detail.getProductId());
                    psDetail.setInt(3, detail.getQuantity());
                    psDetail.setBigDecimal(4, detail.getPrice());
                    psDetail.setBigDecimal(5, detail.getTotalLine());
                    psDetail.addBatch();

                    psStock.setInt(1, detail.getQuantity());
                    psStock.setInt(2, detail.getProductId());
                    psStock.addBatch();
                }
                psDetail.executeBatch();
                psStock.executeBatch();
            }

            con.commit();
            return orderId;
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return -1;
    }

    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapResultSetToOrder(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = mapResultSetToOrder(rs);
                    order.setDetails(getOrderDetails(orderId));
                    return order;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderDetail> getOrderDetails(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.order_id, od.product_id, od.quantity, od.price, od.total_line, " +
                "p.name, p.image_url " +
                "FROM order_details od " +
                "JOIN products p ON od.product_id = p.id " +
                "WHERE od.order_id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail od = new OrderDetail();
                    od.setOrderId(rs.getInt("order_id"));
                    od.setProductId(rs.getInt("product_id"));
                    od.setQuantity(rs.getInt("quantity"));
                    od.setPrice(rs.getBigDecimal("price"));
                    od.setTotalLine(rs.getBigDecimal("total_line"));

                    Product p = new Product();
                    p.setId(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setImageUrl(rs.getString("image_url"));
                    od.setProduct(p);

                    list.add(od);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY created_at DESC";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToOrder(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE orders SET status = ?, updated_at = GETDATE() WHERE id = ?";
        try (Connection con = ConnectDB.getConnect();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, orderId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order o = new Order();
        o.setId(rs.getInt("id"));
        o.setUserId(rs.getInt("user_id"));
        o.setOrderDate(rs.getTimestamp("order_date"));
        o.setTotalAmount(rs.getBigDecimal("total_amount"));
        o.setStatus(rs.getString("status"));
        o.setShippingAddress(rs.getString("shipping_address"));
        o.setPaymentMethod(rs.getString("payment_method"));
        o.setNote(rs.getString("note"));
        o.setCreatedAt(rs.getTimestamp("created_at"));
        o.setUpdatedAt(rs.getTimestamp("updated_at"));
        return o;
    }
}
