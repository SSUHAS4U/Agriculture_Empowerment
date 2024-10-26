<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add to Cart</title>
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

            String productIdParam = request.getParameter("id");
            if (productIdParam != null) {
                try {
                    int productId = Integer.parseInt(productIdParam);

                    // Check if product ID exists in the cart
                    if (cart.containsKey(productId)) {
                        // If already in cart, increment quantity
                        int quantity = cart.get(productId);
                        cart.put(productId, quantity + 1);
                    } else {
                        // Otherwise, add to cart with quantity 1
                        cart.put(productId, 1);
                    }
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            userSession.setAttribute("cart", cart);

            // Redirect back to the previous page or to a different page
            response.sendRedirect("signin-success.jsp");
        %>
    </div>
</body>
</html>
