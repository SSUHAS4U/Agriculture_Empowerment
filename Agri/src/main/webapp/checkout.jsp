<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .checkout-container { margin-top: 50px; }
        .order-summary { margin-bottom: 20px; }
        .total { font-weight: bold; }
        .card-details { display: none; }
        .navbar-brand { font-weight: bold; }
        .navbar { position: relative; }
        .dropdown-menu { position: absolute; top: 100%; left: 0; transform: translateX(-55%); max-width: 100px; white-space: nowrap; overflow-x: auto; }
        .footer { background-color: #333; color: white; padding: 40px 0; text-align: center; }
        .footer a { color: white; text-decoration: none; }
        .footer a:hover { text-decoration: underline; }
        .footer .container { display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; }
        .footer .company-info, .footer .help-info { flex: 1; min-width: 250px; }
        .footer .company-info h5, .footer .help-info h5 { margin-bottom: 20px; font-size: 1.2em; font-weight: bold; }
        .footer .help-info ul { list-style: none; padding: 0; }
        .footer .help-info ul li { margin-bottom: 10px; }
        .footer hr { margin: 20px 0; border-color: #777; }
        .footer p { margin: 0; }
        .btn-proceed { margin-top: 20px; margin-bottom: 40px; font-size: 1.2em; background-color: green; color: white; border: none; padding: 10px 20px; border-radius: 5px; }
        .btn-proceed:hover { background-color: darkgreen; }
    </style>
    <script>
        function showPaymentDetails() {
            var paymentMethod = document.getElementById("paymentMethod").value;
            var cardDetails = document.getElementById("cardDetails");
            var cvvField = document.getElementById("cvvField");
            if (paymentMethod === "CreditCard" || paymentMethod === "DebitCard") {
                cardDetails.style.display = "block";
                if (paymentMethod === "CreditCard") {
                    cvvField.style.display = "block";
                } else {
                    cvvField.style.display = "none";
                }
            } else {
                cardDetails.style.display = "none";
            }
        }

        function validateForm() {
            var paymentMethod = document.getElementById("paymentMethod").value;
            if (paymentMethod === "CreditCard" || paymentMethod === "DebitCard") {
                var cardNumber = document.getElementById("cardNumber").value;
                var cardName = document.getElementById("cardName").value;
                var expiryDate = document.getElementById("expiryDate").value;
                var cvv = document.getElementById("cvv").value;

                if (!/^\d{16}$/.test(cardNumber)) {
                    alert("Card number must be 16 digits.");
                    return false;
                }
                if (paymentMethod === "CreditCard" && !/^\d{3}$/.test(cvv)) {
                    alert("CVV must be 3 digits.");
                    return false;
                }
                if (cardName.trim() === "") {
                    alert("Please enter the name on the card.");
                    return false;
                }
                if (!/^(0[1-9]|1[0-2])\/\d{2}$/.test(expiryDate)) {
                    alert("Expiry date must be in mm/yy format.");
                    return false;
                }
            }
            return true;
        }
    </script>
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
                <!-- Dropdown Menu -->
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

    <div class="container checkout-container">
        <h1>Checkout</h1>
        <div class="order-summary">
            <h2>Review Your Order Details:</h2>
            <%
                HttpSession usersession = request.getSession();
                Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

                if (cart != null && !cart.isEmpty()) {
                    double grandTotal = 0.0;

                    String url = "jdbc:mysql://localhost:3306/agriconnect";
                    String dbUser = "root";
                    String dbPassword = "admin";

                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, dbUser, dbPassword);

                        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                            int productId = entry.getKey();
                            int quantity = entry.getValue();
                            
                            String sql = "SELECT name, price FROM products WHERE id = ?";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setInt(1, productId);
                            rs = pstmt.executeQuery();

                            if (rs.next()) {
                                String productName = rs.getString("name");
                                double price = rs.getDouble("price");
                                double totalPrice = price * quantity;
                                grandTotal += totalPrice;

                                out.println("<div class='product-details'>");
                                out.println("<p><strong>" + productName + "</strong></p>");
                                out.println("<p>Price: Rs." + price + "</p>");
                                out.println("<p>Quantity: " + quantity + "</p>");
                                out.println("<p>Total: Rs." + totalPrice + "</p>");
                                out.println("</div>");
                            }
                        }

                        out.println("<p class='total'>Grand Total: Rs." + grandTotal + "</p>");
                    } catch (Exception e) {
                        e.printStackTrace();
                        out.println("<p>Error retrieving product details.</p>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException se) {
                            se.printStackTrace();
                        }
                    }
                } else {
                    out.println("<p>Your cart is empty.</p>");
                }
            %>
        </div>

        <h2>Select Payment Method:</h2>
        <form action="processPayment.jsp" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="paymentMethod">Payment Method:</label>
                <select class="form-control" id="paymentMethod" name="paymentMethod" onchange="showPaymentDetails()" required>
                    <option value="COD">Cash on Delivery</option>
                    <option value="CreditCard">Credit Card</option>
                    <option value="DebitCard">Debit Card</option>
                </select>
            </div>
            <div id="cardDetails" class="card-details">
                <div class="form-group">
                    <label for="cardNumber">Card Number:</label>
                    <input type="text" class="form-control" id="cardNumber" name="cardNumber">
                </div>
                <div class="form-group">
                    <label for="cardName">Name on Card:</label>
                    <input type="text" class="form-control" id="cardName" name="cardName">
                </div>
                <div class="form-group">
                    <label for="expiryDate">Expiry Date (mm/yy):</label>
                    <input type="text" class="form-control" id="expiryDate" name="expiryDate" placeholder="mm/yy">
                </div>
                <div id="cvvField" class="form-group">
                    <label for="cvv">CVV:</label>
                    <input type="text" class="form-control" id="cvv" name="cvv">
                </div>
            </div>
            <button type="submit" class="btn btn-proceed">Proceed to Payment</button>
        </form>
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
