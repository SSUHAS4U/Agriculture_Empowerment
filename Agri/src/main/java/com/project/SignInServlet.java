package com.project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Database connection
        String jdbcURL = "jdbc:mysql://localhost:3306/agriconnect";
        String dbUser = "root";
        String dbPassword = "admin";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            String sql = "SELECT id, email FROM users WHERE email = ? AND password = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, email);
            statement.setString(2, password);

            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // User is authenticated
                int userId = resultSet.getInt("id");

                // Create session and set user ID
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);

                response.sendRedirect("signin-success.jsp");
            } else {
                response.sendRedirect("signin-fail.jsp");
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("signin-fail.jsp");
        }
    }
}
