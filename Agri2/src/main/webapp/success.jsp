<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Operation Successful</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
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
        <h1>Operation Successful</h1>
        <p>The operation was completed successfully.</p>
        <a href="admin-success.jsp">Go Back</a>
    </div>
</body>
</html>