package com.project;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductLogic {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/agriconnect";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";
    
    private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;

    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        try {
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String query = "SELECT * FROM products";
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getString("id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setQuantity(rs.getInt("quantity"));
                product.setPrice(rs.getDouble("price"));
                products.add(product);
            }
        } finally {
            closeResources();
        }
        return products;
    }

    private void closeResources() {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (ps != null) {
            try {
                ps.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
