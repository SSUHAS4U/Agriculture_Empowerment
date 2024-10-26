<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-header img {
            border-radius: 50%;
            width: 150px;
            height: 150px;
        }

        .profile-info {
            text-align: center;
        }

        .profile-info p {
            font-size: 1.2em;
        }

        .footer {
            background-color: #333;
            color: white;
            padding: 40px 0;
            text-align: center;
        }

        .footer a {
            color: white;
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        .footer .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .footer .company-info, .footer .help-info {
            flex: 1;
            min-width: 250px;
        }

        .footer .company-info h5, .footer .help-info h5 {
            margin-bottom: 20px;
            font-size: 1.2em;
            font-weight: bold;
        }

        .footer .help-info ul {
            list-style: none;
            padding: 0;
        }

        .footer .help-info ul li {
            margin-bottom: 10px;
        }

        .footer hr {
            margin: 20px 0;
            border-color: #777;
        }

        .footer p {
            margin: 0;
        }

        .navbar-brand {
            font-weight: bold;
        }

        .navbar {
            position: relative;
        }

        .dropdown-menu {
            position: absolute;
            top: 100%;
            left: 0;
            transform: translateX(-55%);
            max-width: 100px;
            white-space: nowrap;
            overflow-x: auto;
        }

        .table-container {
            margin-top: 30px;
            margin-bottom: 40px; /* Add gap between the table and footer */
        }

        .table {
            width: 100%;
            margin: 0 auto;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 10px;
            overflow: hidden;
        }

        .table thead th {
            background-color: #28a745; /* Green background */
            color: white;
            padding: 15px;
            text-align: left;
            font-size: 1.1em;
            border-bottom: 2px solid #1e7e34; /* Darker green for border */
        }

        .table tbody td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }

        .table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .table tbody tr:hover {
            background-color: #eaf2e0; /* Light green background on hover */
        }

        .table .total-price {
            color: #28a745; /* Green text for total price */
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">AgriConnect</a>
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
                        <a class="dropdown-item" href="profile.jsp">
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

    <div class="container">
        <div class="profile-header">
            <img src="https://img.icons8.com/material-rounded/100/000000/user.png" alt="Profile">
            <h2>User Profile</h2>
        </div>

        <div class="profile-info">
            <%
            HttpSession usersession = request.getSession(false);
            if (usersession != null) {
                Integer userId = (Integer) usersession.getAttribute("userId");
                if (userId != null) {
                    String jdbcURL = "jdbc:mysql://localhost:3306/agriconnect";
                    String dbUser = "root";
                    String dbPassword = "admin";
                    Connection connection = null;
                    PreparedStatement preparedStatement = null;
                    ResultSet resultSet = null;

                    try {
                        // Load JDBC driver
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        // Establish connection
                        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                        // Fetch user details
                        String sql = "SELECT name, email FROM users WHERE id = ?";
                        preparedStatement = connection.prepareStatement(sql);
                        preparedStatement.setInt(1, userId);
                        resultSet = preparedStatement.executeQuery();
                        if (resultSet.next()) {
                            String name = resultSet.getString("name");
                            String email = resultSet.getString("email");
                    %>
                    <p><strong>Name:</strong> <%= name %></p>
                    <p><strong>Email:</strong> <%= email %></p>
                    <%
                        }

                        // Fetch orders placed by the user
                        sql = "SELECT product_id, quantity, total_price, order_date FROM orders WHERE user_id = ?";
                        preparedStatement = connection.prepareStatement(sql);
                        preparedStatement.setInt(1, userId);
                        resultSet = preparedStatement.executeQuery();
                    %>
                    <div class="table-container">
                        <h3>Orders Placed:</h3>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Product ID</th>
                                    <th>Quantity</th>
                                    <th>Total Price</th>
                                    <th>Order Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                while (resultSet.next()) {
                                    String productId = resultSet.getString("product_id");
                                    int quantity = resultSet.getInt("quantity");
                                    double totalPrice = resultSet.getDouble("total_price");
                                    java.sql.Timestamp orderDate = resultSet.getTimestamp("order_date");
                                %>
                                <tr>
                                    <td><%= productId %></td>
                                    <td><%= quantity %></td>
                                    <td class="total-price">Rs.<%= totalPrice %></td>
                                    <td><%= orderDate %></td>
                                </tr>
                                <%
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <%
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                        out.println("Error loading database driver.");
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("SQL error: " + e.getMessage());
                    } finally {
                        // Close resources
                        try {
                            if (resultSet != null) resultSet.close();
                            if (preparedStatement != null) preparedStatement.close();
                            if (connection != null) connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                } else {
                    out.println("User ID not found in session.");
                }
            } else {
                out.println("Session not found.");
            }
            %>
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
                    <li><a href="#" onclick="showContactPage()">Contact Us</a></li>
                </ul>
            </div>
        </div>
        <hr>
        <p>&copy; 2024 AgriCultural Hub. All rights reserved.</p>
    </footer>
</body>
</html>
