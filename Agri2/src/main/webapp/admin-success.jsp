<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Page - Agricultural Hub</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            display: flex;
        }

        .sidebar {
            width: 200px;
            background-color: #4CAF50;
            position: fixed;
            height: 100%;
            padding-top: 20px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .sidebar h1 {
            font-size: 1.5em;
            color: white;
            text-align: center;
            margin-bottom: 10px;
            cursor: pointer;
        }

        .sidebar hr {
            margin: 10px 0;
            border: 0;
            border-top: 1px solid white;
        }

        .sidebar a {
            display: block;
            color: white;
            padding: 14px 20px;
            text-decoration: none;
        }

        .sidebar a:hover {
            background-color: #45a049;
        }

        .content {
            margin-left: 220px;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            height: 100vh;
        }

        .form-container {
            display: none;
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            width: 960px;
        }

        .form-container.active {
            display: block;
        }

        .form-container form input, .form-container form textarea {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
        }

        .form-container form input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        .form-container form input[type="submit"]:hover {
            background-color: #45a049;
        }

        /* Specific styles for View Products */
        #view-products {
            background: #ffffff;
            border: 2px solid rgb(240, 248, 255);
            width: 960px;
        }

        #view-products table {
            width: 100%;
            border-collapse: collapse;
        }

        #view-products th, #view-products td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        #view-products th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <div class="sidebar">
        <div>
            <h1 onclick="showLandingPage()">AgriConnect HUB</h1>
            <hr>
            <a href="#" onclick="showForm('add-product')">Add Product</a>
            <a href="#" onclick="showForm('delete-product')">Delete Product</a>
            <a href="#" onclick="showForm('update-product')">Update Product</a>
            <a href="#" onclick="showForm('view-products')">View Products</a>
        </div>
        <a href="index.jsp" style="margin: 20px;">Logout</a>
    </div>

    <div class="content landing-page" id="landing-page">
        <h1>Welcome to Admin-Portal</h1>
    </div>

    <div class="content" id="form-content">
        <!-- Add Product Form -->
        <div id="add-product" class="form-container">
            <h2>Add Product</h2>
            <form action="ProductServlet" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">
                <label for="id">ID:</label>
                <input type="text" id="id" name="id" required>

                <label for="name">Product Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="image">Image:</label>
                <input type="file" id="image" name="image" required>

                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="4" required></textarea>

                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" required>

                <label for="price">Price (in Rupees):</label>
                <input type="number" id="price" name="price" required>

                <input type="submit" value="Add Product">
            </form>
        </div>

        <!-- Delete Product Form -->
        <div id="delete-product" class="form-container">
            <h2>Delete Product</h2>
            <form action="ProductServlet" method="POST">
                <input type="hidden" name="action" value="delete">
                <label for="id">Product ID:</label>
                <input type="text" id="id" name="id" required>
                <input type="submit" value="Delete Product">
            </form>
        </div>

        <!-- Update Product Form -->
        <div id="update-product" class="form-container">
            <h2>Update Product</h2>
            <form action="ProductServlet" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="action" value="update">
                <label for="id">Product ID:</label>
                <input type="text" id="id" name="id" required>

                <label for="name">Product Name:</label>
                <input type="text" id="name" name="name">

                <label for="image">Image:</label>
                <input type="file" id="image" name="image">

                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="4"></textarea>

                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity">

                <label for="price">Price (in Rupees):</label>
                <input type="number" id="price" name="price">

                <input type="submit" value="Update Product">
            </form>
        </div>

        <!-- View Products Section -->
        <div id="view-products" class="form-container">
            <h2>Products List</h2>
             <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Quantity</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Products will be populated here -->
                </tbody>
            </table>
        </div>
    </div>

    <script>
        function showForm(formId) {
            const forms = document.querySelectorAll('.form-container');
            forms.forEach(form => {
                form.classList.remove('active');
            });
            document.getElementById(formId).classList.add('active');

            document.getElementById('landing-page').style.display = 'none';
            document.getElementById('form-content').style.display = 'block';

            if (formId === 'view-products') {
                fetch('ProductServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: 'action=view'
                })
                .then(response => response.text())
                .then(data => {
                    document.querySelector('#view-products tbody').innerHTML = data;
                });
            }
        }

        function showLandingPage() {
            const forms = document.querySelectorAll('.form-container');
            forms.forEach(form => {
                form.classList.remove('active');
            });

            document.getElementById('landing-page').style.display = 'flex';
            document.getElementById('form-content').style.display = 'none';
        }

        // Initially hide the form content
        document.getElementById('form-content').style.display = 'none';
    </script>
</body>
</html>
