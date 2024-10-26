<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Processing Payment</title>
</head>
<body>
    <%
        HttpSession userSession = request.getSession();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) userSession.getAttribute("cart");
        Integer userId = (Integer) userSession.getAttribute("userId");
        String paymentMethod = request.getParameter("paymentMethod");

        // Debug output
        out.println("<p>Cart: " + (cart == null ? "null" : cart.toString()) + "</p>");
        out.println("<p>User ID: " + userId + "</p>");
        out.println("<p>Payment Method: " + paymentMethod + "</p>");

        if (cart == null || userId == null || cart.isEmpty()) {
            response.sendRedirect("orderSuccess.jsp?error=Cart is empty or user not logged in.");
        } else {
            String url = "jdbc:mysql://localhost:3306/agriconnect";
            String dbUser = "root";
            String dbPassword = "admin";
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, dbUser, dbPassword);
                conn.setAutoCommit(false); // Ensure transaction is handled manually

                String sql = "INSERT INTO orders (user_id, product_id, quantity, total_price) VALUES (?, ?, ?, ?)";
                pstmt = conn.prepareStatement(sql);

                for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    int productId = entry.getKey();
                    int quantity = entry.getValue();

                    String productSql = "SELECT price FROM products WHERE id = ?";
                    try (PreparedStatement productStmt = conn.prepareStatement(productSql)) {
                        productStmt.setString(1, String.valueOf(productId));
                        try (ResultSet rs = productStmt.executeQuery()) {
                            if (rs.next()) {
                                double price = rs.getDouble("price");
                                double totalPrice = price * quantity;

                                pstmt.setInt(1, userId);
                                pstmt.setString(2, String.valueOf(productId));
                                pstmt.setInt(3, quantity);
                                pstmt.setDouble(4, totalPrice);
                                pstmt.addBatch();
                            }
                        }
                    }
                }

                pstmt.executeBatch();
                conn.commit();

                // Clear the cart
                userSession.setAttribute("cart", new HashMap<Integer, Integer>());

                // Redirect to orderSuccess.jsp
                response.sendRedirect("orderSuccess.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("orderSuccess.jsp?error=" + e.getMessage());
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException se) {
                    se.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
