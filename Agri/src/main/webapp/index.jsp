<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AgriCultural Hub</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8f5e9;
        }

        .navbar-brand {
            font-weight: bold;
        }

        .hero-section {
            background-image: url('resources/images/image.png'); 
            background-size: cover;
            color: white;
            padding: 100px 0;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
        }

        .hero-section .container {
            padding: 50px;
        }

        .hero-section h1 {
            font-size: 3em;
            font-weight: bold;
        }

        .hero-section p {
            font-size: 1.5em;
            margin: 20px 0;
        }

        .hero-section .btn {
            margin: 10px;
            font-size: 1.2em;
        }

        #register-form,
        #login-form,
        #about-us,
        #admin-login-form {
            padding: 50px 0;
            margin: 20px 0;
        }

        #register-form h2,
        #login-form h2,
        #admin-login-form h2 {
            font-weight: bold;
            margin-bottom: 30px;
        }

        #register-form img,
        #login-form img,
        #admin-login-form img {
            max-width: 100%;
            height: auto;
            display: block;
            margin: 0 auto;
        }

        .error {
            color: red;
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

        .footer .company-info,
        .footer .help-info {
            flex: 1;
            min-width: 250px;
        }

        .footer .company-info h5,
        .footer .help-info h5 {
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

        /* Added styles for forms */
        form .form-group {
            margin-left: 20px;
        }

        form .form-check {
            margin-left: 20px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#" onclick="showHomePage()">AgriCultural HUB</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link" href="#" onclick="showHomePage()">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" onclick="showAboutPage()">About Us</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" onclick="showRegisterForm()">Sign Up</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" onclick="showLoginForm()">Sign In</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#" onclick="showAdminLoginForm()">Admin</a>
            </li>
        </ul>
    </div>
</nav>


    <header class="hero-section" id="home-page">
        <div class="container text-center">
            <h1>AGRICULTURAL HUB</h1>
            <p>Empowering Rural Dreams, Nurturing Agricultural Growth – AgriCultural Hub cultivates prosperity from the roots up.</p>
            <button class="btn btn-warning" onclick="showRegisterForm()">
                <img src="https://img.icons8.com/material-rounded/24/000000/shopping-cart.png" alt="Shop Now"> Shop Now 
            </button>
        </div>
    </header>

    <div class="background">
        <section id="register-form" class="container mt-5" style="display: none;">
            <!-- Register Form -->
            <div class="row">
                <div class="col-md-6">
                    <h2 style="margin-left: 20px;">Get Started Now</h2>
                    <form id="register-form-form" action="RegisterServlet" method="post" onsubmit="return validateRegisterForm()">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="name" name="name" placeholder="Enter your name">
                            <div id="name-error" class="error"></div>
                        </div>
                        <div class="form-group">
                            <label for="email">Email address</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email">
                            <div id="email-error" class="error"></div>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                            <div id="password-error" class="error"></div>
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="terms" name="terms">
                            <label class="form-check-label" for="terms">I agree to the terms & policy</label>
                            <div id="terms-error" class="error"></div>
                        </div>
                        <div class="form-group">
                        <button type="submit" class="btn btn-success">Sign Up</button>
                        </div>
                    </form>
                    <div class="text-center mt-3">
                        <p>Have an account? <a href="#" onclick="showLoginForm()">Sign In</a></p>
                    </div>
                </div>
                <div class="col-md-6 text-center">
                    <img src="<%= request.getContextPath() %>/resources/images/image2.png" alt="Fresh Vegetables" class="img-fluid">
                </div>
            </div>
        </section>

        <section id="login-form" class="container mt-5" style="display: none;">
            <!-- Login Form -->
            <div class="row">
                <div class="col-md-6">
                    <h2 style="margin-left: 20px;">Sign In</h2>
                    <form id="login-form-form" action="SignInServlet" method="post" onsubmit="return validateLoginForm()">
                        <div class="form-group">
                            <label for="login-email">Email address</label>
                            <input type="email" class="form-control" id="login-email" name="email" placeholder="Enter your email">
                            <div id="login-email-error" class="error"></div>
                        </div>
                        <div class="form-group">
                            <label for="login-password">Password</label>
                            <input type="password" class="form-control" id="login-password" name="password" placeholder="Password">
                            <div id="login-password-error" class="error"></div>
                        </div>
                        <div class="form-group">
                        <button type="submit" class="btn btn-success">Sign In</button>
                        </div>
                    </form>
                    <div class="text-center mt-3">
                        <p>Don't have an account? <a href="#" onclick="showRegisterForm()">Sign Up</a></p>
                    </div>
                </div>
                <div class="col-md-6 text-center">
                    <img src="<%= request.getContextPath() %>/resources/images/image2.png" alt="Fresh Vegetables" class="img-fluid">
                </div>
            </div>
        </section>

        <section id="admin-login-form" class="container mt-5" style="display: none;">
            <!-- Admin Login Form -->
            <div class="row">
                <div class="col-md-6">
                    <h2 style="margin-left: 20px;">Admin Login</h2>
                    <form id="admin-login-form-form" action="AdminLogin" method="post" onsubmit="return validateAdminLoginForm()">
                        <div class="form-group">
                            <label for="admin-username">Username</label>
                            <input type="username" class="form-control" id="admin-username" name="username" placeholder="Enter your username">
                            <div id="admin-username-error" class="error"></div>
                        </div>
                        <div class="form-group">
                            <label for="admin-password">Password</label>
                            <input type="password" class="form-control" id="admin-password" name="password" placeholder="Password">
                            <div id="admin-password-error" class="error"></div>
                        </div>
                        <div class="form-group">
                        <button type="submit" class="btn btn-success">Sign In</button>
                        </div>
                    </form>
                </div>
                <div class="col-md-6 text-center">
                    <img src="<%= request.getContextPath() %>/resources/images/image2.png" alt="Fresh Vegetables" class="img-fluid" >
                </div>
            </div>
        </section>

        <section id="about-us" class="container mt-5" style="display: none;">
            <!-- About Us Section -->
            <h2 style="margin-left: 20px;">About Us</h2>
            <p style="margin-left: 20px;">Welcome to AgriCultural Hub! We are committed to connecting farmers and consumers, promoting sustainable agriculture, and ensuring the best quality of agricultural products. Our platform allows you to shop for fresh, locally-sourced produce directly from the farm, fostering a community of trust and transparency in the agricultural sector.</p>
        </section>
        
        		<section id="contact-us" class="container mt-5" style="display: none;">
			<!-- Contact Us Form -->
			<div class="row">
				<div class="col-md-6">
					<h2 style="margin-left: 20px;">Contact Us</h2>
					<form id="contact-us-form" action="ContactServlet" method="post">
						<div class="form-group">
							<label for="contact-email">Email address</label> <input
								type="email" class="form-control" id="contact-email"
								name="email" placeholder="Enter your email">
							<div id="contact-email-error" class="error"></div>
						</div>
						<div class="form-group">
							<label for="contact-message">Message</label>
							<textarea class="form-control" id="contact-message"
								name="message" placeholder="Enter your message"></textarea>
							<div id="contact-message-error" class="error"></div>
						</div>
						<div class="form-group">
							<label for="contact-number">Mobile Number</label> <input
								type="tel" class="form-control" id="contact-number"
								name="contact-number" pattern="\d{10}"
								placeholder="Enter your 10-digit mobile number" required>
							<div id="contact-number-error" class="error"></div>
						</div>

						<div class="form-group">
							<button type="submit" class="btn btn-success">Send</button>
						</div>
					</form>
				</div>
				<div class="col-md-6 text-center">
					<img
						src="<%=request.getContextPath()%>/resources/images/image2.png"
						alt="Contact Us" class="img-fluid">
				</div>
			</div>
		</section>
        
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

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        function showHomePage() {
            document.getElementById("home-page").style.display = "block";
            document.getElementById("register-form").style.display = "none";
            document.getElementById("login-form").style.display = "none";
            document.getElementById("about-us").style.display = "none";
            document.getElementById("admin-login-form").style.display = "none";
        }

        function showRegisterForm() {
            document.getElementById("home-page").style.display = "none";
            document.getElementById("register-form").style.display = "block";
            document.getElementById("login-form").style.display = "none";
            document.getElementById("about-us").style.display = "none";
            document.getElementById("admin-login-form").style.display = "none";
        }

        function showLoginForm() {
            document.getElementById("home-page").style.display = "none";
            document.getElementById("register-form").style.display = "none";
            document.getElementById("login-form").style.display = "block";
            document.getElementById("about-us").style.display = "none";
            document.getElementById("admin-login-form").style.display = "none";
        }

        function showAdminLoginForm() {
            document.getElementById("home-page").style.display = "none";
            document.getElementById("register-form").style.display = "none";
            document.getElementById("login-form").style.display = "none";
            document.getElementById("about-us").style.display = "none";
            document.getElementById("admin-login-form").style.display = "block";
        }

        function showAboutPage() {
            document.getElementById("home-page").style.display = "none";
            document.getElementById("register-form").style.display = "none";
            document.getElementById("login-form").style.display = "none";
            document.getElementById("about-us").style.display = "block";
            document.getElementById("admin-login-form").style.display = "none";
        }
        function showContactPage() {
			document.getElementById("home-page").style.display = "none";
			document.getElementById("register-form").style.display = "none";
			document.getElementById("login-form").style.display = "none";
			document.getElementById("about-us").style.display = "none";
			document.getElementById("admin-login-form").style.display = "none";
			document.getElementById("contact-us").style.display = "block";
		}
        

        // Form validation
        function validateRegisterForm() {
            let valid = true;
            let name = document.getElementById("name").value;
            let email = document.getElementById("email").value;
            let password = document.getElementById("password").value;
            let terms = document.getElementById("terms").checked;

            if (name === "") {
                document.getElementById("name-error").innerText = "Name is required.";
                valid = false;
            } else {
                document.getElementById("name-error").innerText = "";
            }

            if (email === "") {
                document.getElementById("email-error").innerText = "Email is required.";
                valid = false;
            } else {
                document.getElementById("email-error").innerText = "";
            }

            if (password === "") {
                document.getElementById("password-error").innerText = "Password is required.";
                valid = false;
            } else {
                document.getElementById("password-error").innerText = "";
            }

            if (!terms) {
                document.getElementById("terms-error").innerText = "You must agree to the terms.";
                valid = false;
            } else {
                document.getElementById("terms-error").innerText = "";
            }

            return valid;
        }

        function validateLoginForm() {
            let valid = true;
            let email = document.getElementById("login-email").value;
            let password = document.getElementById("login-password").value;

            if (email === "") {
                document.getElementById("login-email-error").innerText = "Email is required.";
                valid = false;
            } else {
                document.getElementById("login-email-error").innerText = "";
            }

            if (password === "") {
                document.getElementById("login-password-error").innerText = "Password is required.";
                valid = false;
            } else {
                document.getElementById("login-password-error").innerText = "";
            }

            return valid;
        }

        function validateAdminLoginForm() {
            let valid = true;
            let username = document.getElementById("admin-username").value;
            let password = document.getElementById("admin-password").value;

            if (username === "") {
                document.getElementById("admin-username-error").innerText = "Username is required.";
                valid = false;
            } else {
                document.getElementById("admin-username-error").innerText = "";
            }

            if (password === "") {
                document.getElementById("admin-password-error").innerText = "Password is required.";
                valid = false;
            } else {
                document.getElementById("admin-password-error").innerText = "";
            }

            return valid;
        }

        // Initialize page with the home section displayed
        showHomePage();
    </script>
</body>
</html>