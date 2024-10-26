<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Cart</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <%
            HttpSession userSession = request.getSession();
            Map<Integer, Integer> cart = (Map<Integer, Integer>) userSession.getAttribute("cart");

            if (cart == null) {
                cart = new HashMap<>();
            }

            String action = request.getParameter("action");
            int productId = Integer.parseInt(request.getParameter("id"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if ("increase".equals(action)) {
                cart.put(productId, quantity + 1);
            } else if ("decrease".equals(action)) {
                if (quantity > 1) {
                    cart.put(productId, quantity - 1);
                } else {
                    cart.remove(productId);
                }
            }

            userSession.setAttribute("cart", cart);
        %>
        <script>
            // Redirect to cart.jsp
            window.location.href = "cart.jsp";
        </script>
    </div>
</body>
</html>
