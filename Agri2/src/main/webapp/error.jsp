<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Operation Failed</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: #ffebee;
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
            color: #f44336;
            animation: fadeIn 1s ease-in;
        }
        p {
            color: #555;
        }
        a {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background: #f44336;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            transition: background 0.3s;
        }
        a:hover {
            background: #d32f2f;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Operation Failed</h1>
        <p>There was an error processing your request.</p>
        <a href="admin-success.jsp">Try Again</a>
    </div>
</body>
</html>