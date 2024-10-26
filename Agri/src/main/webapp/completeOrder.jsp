<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Complete</title>
</head>
<body>
<%
    String paymentMethod = request.getParameter("paymentMethod");
    String cardNumber = request.getParameter("cardNumber");
    String expiryDate = request.getParameter("expiryDate");
    String cvv = request.getParameter("cvv");
    String debitCardNumber = request.getParameter("debitCardNumber");
    String debitExpiryDate = request.getParameter("debitExpiryDate");

    // Process the order based on the payment method and details
    // Example processing (pseudo-code)
    boolean orderProcessed = false;

    if ("cash".equals(paymentMethod)) {
        orderProcessed = true; // Process Cash on Delivery
    } else if ("credit".equals(paymentMethod)) {
        if (cardNumber != null && expiryDate != null && cvv != null) {
            if (cardNumber.matches("\\d{16}") && expiryDate.matches("\\d{2}/\\d{2}") && cvv.matches("\\d{3}")) {
                orderProcessed = true; // Process Credit Card payment
            }
        }
    } else if ("debit".equals(paymentMethod)) {
        if (debitCardNumber != null && debitExpiryDate != null) {
            if (debitCardNumber.matches("\\d{16}") && debitExpiryDate.matches("\\d{2}/\\d{2}")) {
                orderProcessed = true; // Process Debit Card payment
            }
        }
    }

    if (orderProcessed) {
        out.println("<h1>Order Completed Successfully!</h1>");
        // Additional code to display order details or confirmation
    } else {
        out.println("<h1>There was a problem with your order.</h1>");
        // Additional code to display an error message
    }
%>
</body>
</html>
