<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        body { padding-top: 70px; }
        .cart-item { margin: 15px 0; padding: 15px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9; display: flex; justify-content: space-between; align-items: center; }
        .cart-item img { max-height: 100px; object-fit: cover; margin-right: 15px; }
        .cart-item-details { flex: 1; }
        .cart-total { margin-top: 20px; font-weight: bold; margin-bottom: 40px; }
        .btn-checkout { margin-top: 20px; font-size: 1.2em; background-color: green; color: white; border: none; padding: 10px 20px; border-radius: 5px; }
        .btn-checkout:hover { background-color: darkgreen; }
        .btn-remove, .btn-update { margin-left: 10px; cursor: pointer; }
        .quantity-controls { display: flex; align-items: center; }
        .quantity-controls button { background-color: #ddd; border: none; padding: 5px 10px; cursor: pointer; }
        .quantity-controls input { width: 40px; text-align: center; border: 1px solid #ddd; margin: 0 5px; }
        .dropdown-menu {
            position: absolute; /* Position relative to the navbar */
            top: 100%; /* Align dropdown menu below the navbar item */
            left: 0; /* Align to the left of the navbar item */
            transform: translateX(-55%);
            /* Center align dropdown menu under the navbar item */
            max-width: 100px; /* Adjust as needed */
            white-space: nowrap; /* Prevent text wrapping */
            overflow-x: auto; /* Allow horizontal scrolling if needed */
        }
        .footer {
            background-color: #333;
            color: white;
            padding: 40px 0;
            text-align: center;
        }
        .footer a { color: white; text-decoration: none; }
        .footer a:hover { text-decoration: underline; }
        .footer .container { display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; }
        .footer .company-info, .footer .help-info { flex: 1; min-width: 250px; }
        .footer .company-info h5, .footer .help-info h5 { margin-bottom: 20px; font-size: 1.2em; font-weight: bold; }
        .footer .help-info ul { list-style: none; padding: 0; }
        .footer .help-info ul li { margin-bottom: 10px; }
        .footer hr { margin: 20px 0; border-color: #777; }
        .footer p { margin: 0; }
        /* Added styles for forms */
        form .form-group { margin-left: 20px; }
        form .form-check { margin-left: 20px; }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <a class="navbar-brand" href="#">Agricultural Hub</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="navbar-toggler-icon"></span>
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="cart.jsp">
                            <img src="https://img.icons8.com/material-rounded/24/000000/shopping-cart.png" alt="Cart"> Cart
                        </a>
                        <a class="dropdown-item" href="profile.html">
                            <img src="https://img.icons8.com/material-rounded/24/000000/user.png" alt="Account"> Account
                        </a>
                        <a class="dropdown-item" href="index.jsp">
                            <img src="https://img.icons8.com/material-rounded/24/000000/exit.png" alt="Logout"> Logout
                        </a>
                    </div>
                </li>
            </ul>
        </div>
    </nav>

    <!-- Cart Items -->
    <div class="container mt-5">
        <h1>Your Shopping Cart</h1>
        <p>Review the items in your cart before proceeding to checkout:</p>

        <%
            HttpSession userSession = request.getSession();
            Map<Integer, Integer> cart = (Map<Integer, Integer>) userSession.getAttribute("cart");

            if (cart == null) {
                cart = new HashMap<>();
            }

            double total = 0.0;

            if (cart.isEmpty()) {
        %>
            <p>Your cart is empty.</p>
        <% 
            } else {
                String url = "jdbc:mysql://localhost:3306/agriconnect";
                String user = "root";
                String password = "admin";
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, user, password);
                    stmt = conn.createStatement();

                    for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                        int productId = entry.getKey();
                        int quantity = entry.getValue();
                        String sql = "SELECT * FROM products WHERE id = " + productId;

                        rs = stmt.executeQuery(sql);

                        if (rs.next()) {
                            String name = rs.getString("name");
                            double price = rs.getDouble("price");
                            double itemTotal = price * quantity;
                            total += itemTotal;
        %>
            <div class="cart-item">
                <img src="image?id=<%= productId %>" alt="<%= name %>" />
                <div class="cart-item-details">
                    <h5><%= name %></h5>
                    <p>Price: Rs.<%= price %></p>
                    <form action="updateCart.jsp" method="get" class="quantity-controls">
                        <button type="submit" name="action" value="decrease">-</button>
                        <input type="text" name="quantity" value="<%= quantity %>" readonly />
                        <button type="submit" name="action" value="increase">+</button>
                        <input type="hidden" name="id" value="<%= productId %>" />
                    </form>
                    <p>Total: Rs.<%= itemTotal %></p>
                </div>
                <a href="removeFromCart.jsp?id=<%= productId %>" class="btn-remove">Remove</a>
            </div>
        <% 
                        } else {
                            out.println("<p>Product with ID " + productId + " not found.</p>");
                        }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
        %>
            <p>Error retrieving cart items: <%= e.getMessage() %></p>
        <% 
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException se) {
                        se.printStackTrace();
                    }
                }
            }
        %>
        <div class="cart-total">
            <h4>Total: Rs.<%= total %></h4>
            <a href="checkout.jsp" class="btn btn-checkout">Proceed to Checkout</a>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="company-info">
                <h5>AgriCultural Hub</h5>
                <p>Empowering Rural Dreams, Nurturing Agricultural Growth</p>
            </div>
            <div class="help-info">
                <h5>Help & Support</h5>
                <ul>
                    <li><a href="#" onclick="showAboutPage()">About Us</a></li>
                    <li><a href="#" onclick="showRegisterForm()">Sign Up</a></li>
                    <li><a href="#" onclick="showLoginForm()">Sign In</a></li>
                </ul>
            </div>
        </div>
        <hr>
        <p>&copy; 2024 AgriCultural Hub. All rights reserved.</p>
    </footer>
</body>
</html>
