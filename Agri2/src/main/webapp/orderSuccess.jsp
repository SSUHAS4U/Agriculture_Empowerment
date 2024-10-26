<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order Success</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: #e0f7fa;
            font-family: Arial, sans-serif;
        }
        .container {
            text-align: center;
            padding: 50px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #4caf50;
            animation: fadeIn 1s ease-in;
        }
        p {
            color: #555;
            font-size: 18px;
        }
        a {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background: #4caf50;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s;
        }
        a:hover {
            background: #45a049;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            HttpSession userSession = request.getSession();
            Map<Integer, Integer> cart = (Map<Integer, Integer>) userSession.getAttribute("cart");

            if (cart != null && !cart.isEmpty()) {
                String url = "jdbc:mysql://localhost:3306/agriconnect";
                String user = "root";
                String password = "admin";
                Connection conn = null;
                PreparedStatement orderStmt = null;
                PreparedStatement updateStmt = null;
                PreparedStatement priceStmt = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);

                    // Begin transaction
                    conn.setAutoCommit(false);

                    // Insert order details into the orders table
                    String insertOrderSQL = "INSERT INTO orders (user_id, product_id, quantity, total_price) VALUES (?, ?, ?, ?)";
                    orderStmt = conn.prepareStatement(insertOrderSQL);

                    for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                        int productId = entry.getKey();
                        int quantityOrdered = entry.getValue();
                        double price = 0.0;
                        double totalPrice = 0.0;

                        // Fetch product price
                        String priceSQL = "SELECT price FROM products WHERE id = ?";
                        priceStmt = conn.prepareStatement(priceSQL);
                        priceStmt.setInt(1, productId);
                        ResultSet rs = priceStmt.executeQuery();
                        if (rs.next()) {
                            price = rs.getDouble("price");
                            totalPrice = price * quantityOrdered;
                        }

                        // Insert order into orders table
                        orderStmt.setInt(1, (Integer) userSession.getAttribute("userId"));
                        orderStmt.setInt(2, productId);
                        orderStmt.setInt(3, quantityOrdered);
                        orderStmt.setDouble(4, totalPrice);
                        orderStmt.executeUpdate();

                        // Update product quantity
                        String updateProductSQL = "UPDATE products SET quantity = quantity - ? WHERE id = ?";
                        updateStmt = conn.prepareStatement(updateProductSQL);
                        updateStmt.setInt(1, quantityOrdered);
                        updateStmt.setInt(2, productId);
                        updateStmt.executeUpdate();
                    }

                    // Commit transaction
                    conn.commit();

                    // Clear the cart
                    userSession.removeAttribute("cart");

                } catch (Exception e) {
                    e.printStackTrace();
                    try {
                        if (conn != null) {
                            conn.rollback(); // Rollback in case of error
                        }
                    } catch (SQLException rollbackEx) {
                        rollbackEx.printStackTrace();
                    }
                    out.println("<p>Error placing order: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        if (orderStmt != null) orderStmt.close();
                        if (updateStmt != null) updateStmt.close();
                        if (priceStmt != null) priceStmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            } else {
                out.println("<p>Thanks for ordering</p>");
            }
        %>
        <h1>Order Success</h1>
        <p>Your order has been placed successfully!</p>
        <a href="signin-success.jsp">Continue Shopping</a>
    </div>
</body>
</html>
