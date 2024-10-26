<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page
	import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException"%>
	
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Home Page</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<style>
.product-card {
	margin: 15px;
	flex: 1 0 21%; /* four items per row */
	border-radius: 15px; /* rounded edges */
	transition: transform 0.3s, box-shadow 0.3s; /* smooth enlargement */
}

.product-card:hover {
	transform: scale(1.05);
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
}

.navbar-brand {
	font-weight: bold;
}

.navbar {
	position: relative; /* Ensure dropdown menu is correctly positioned */
}

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
	font-weight: bold.
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

.carousel-item img {
	max-height: 300px; /* Adjust this height as needed */
	width: 100%; /* Ensure images fit within carousel without stretching */
	object-fit: contain; /* Maintain image quality */
}

.carousel-control-prev-icon, .carousel-control-next-icon {
	background-color: black;
	height: 30px;
	width: 30px;
}

.card-body {
	display: flex;
	justify-content: space-between;
	align-items: flex-start;
	flex-direction: column;
}

.card-description {
	flex: 1;
}

.add-to-cart {
	align-self: flex-end; /* Position button at bottom right */
	margin-top: auto;
}
/* Notification styles */
#message {
	display: none;
	position: fixed;
	bottom: 90px; /* Move the message up */
	left: 10%;
	transform: translateX(-50%);
	background-color: #28a745;
	color: white;
	padding: 10px;
	border-radius: 5px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	z-index: 1050; /* Ensure it's on top of other elements */
}
</style>
</head>
<body>
	<!-- Navbar -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="#">AgriConnect</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNav" aria-controls="navbarNav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNav">
			<ul class="navbar-nav ml-auto">
				<!-- Dropdown Menu -->
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
					role="button" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false"> <span class="navbar-toggler-icon"></span>
				</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="cart.jsp"> <img
							src="https://img.icons8.com/material-rounded/24/000000/shopping-cart.png"
							alt="Cart"> Cart
						</a> <a class="dropdown-item" href="profile.jsp"> <img
							src="https://img.icons8.com/material-rounded/24/000000/user.png"
							alt="Account"> Account
						</a> <a class="dropdown-item" href="index.jsp"> <img
							src="https://img.icons8.com/material-rounded/24/000000/exit.png"
							alt="Logout"> Logout
						</a>
					</div></li>
			</ul>
		</div>
	</nav>

	<!-- Carousel -->
	<div id="productCarousel" class="carousel slide my-4"
		data-ride="carousel" data-interval="1000">
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="resources\images\c1.jpg" class="d-block w-100"
					alt="Product 1">
			</div>
			<div class="carousel-item">
				<img src="resources\images\c2.jpg" class="d-block w-100"
					alt="Product 2">
			</div>
			<div class="carousel-item">
				<img src="resources\images\c3.jpg" class="d-block w-100"
					alt="Product 3">
			</div>
		</div>
		<a class="carousel-control-prev" href="#productCarousel" role="button"
			data-slide="prev"> <span class="carousel-control-prev-icon"
			aria-hidden="true"></span> <span class="sr-only">Previous</span>
		</a> <a class="carousel-control-next" href="#productCarousel"
			role="button" data-slide="next"> <span
			class="carousel-control-next-icon" aria-hidden="true"></span> <span
			class="sr-only">Next</span>
		</a>
	</div>

	<!-- Success Message -->
	<div id="message">Added to cart successfully</div>

	<script>
    document.addEventListener("DOMContentLoaded", function() {
        const addToCartButtons = document.querySelectorAll('.add-to-cart');
        const messageDiv = document.getElementById('message');

        addToCartButtons.forEach(button => {
            button.addEventListener('click', function(event) {
                event.preventDefault(); // Prevent default action
                messageDiv.style.display = 'block'; // Show the message
                setTimeout(() => {
                    messageDiv.style.display = 'none'; // Hide the message after 2 seconds
                    // Proceed with the original action
                    window.location.href = button.getAttribute('href');
                }, 500); // Adjust the time as needed
            });
        });
    });
   </script>

	<!-- Products -->
	<div class="container">
		<div class="row">
			<%
			// Database connection parameters
			String jdbcURL = "jdbc:mysql://localhost:3306/agriconnect";
			String dbUser = "root";
			String dbPassword = "admin";
			Connection connection = null;
			Statement statement = null;
			ResultSet resultSet = null;
			try {
				// Load JDBC driver
				Class.forName("com.mysql.cj.jdbc.Driver");
				// Establish connection
				connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
				// Create a statement
				statement = connection.createStatement();
				// Execute query
				String sql = "SELECT * FROM products";
				resultSet = statement.executeQuery(sql);
				// Iterate through the result set
				while (resultSet.next()) {
					String id = resultSet.getString("id");
					String name = resultSet.getString("name");
					String description = resultSet.getString("description");
					double price = resultSet.getDouble("price");
					String imageUrl = "ImageServlet?id=" + id; // Construct the image URL
			%>
			<div class="col-md-3 d-flex align-items-stretch">
				<div class="card product-card">
					<img src="<%=imageUrl%>" class="card-img-top" alt="Product Image">
					<div class="card-body">
						<div class="card-description">
							<h5 class="card-title"><%=name%></h5>
							<p class="card-text">
								Rs.<%=price%></p>
							<p class="card-text"><%=description%></p>
						</div>
						<a href="addToCart.jsp?id=<%=id%>"
							class="btn btn-success add-to-cart">Add to Cart</a>
					</div>
				</div>
			</div>
			<%
			}
			} catch (ClassNotFoundException e) {
			e.printStackTrace();
			out.println("Error loading database driver.");
			} catch (SQLException e) {
			e.printStackTrace();
			out.println("SQL error: " + e.getMessage());
			} finally {
			// Close resources
			try {
			if (resultSet != null)
				resultSet.close();
			if (statement != null)
				statement.close();
			if (connection != null)
				connection.close();
			} catch (SQLException e) {
			e.printStackTrace();
			}
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