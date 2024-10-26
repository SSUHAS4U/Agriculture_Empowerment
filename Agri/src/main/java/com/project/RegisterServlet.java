package com.project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        boolean terms = request.getParameter("terms") != null;

        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Password: " + password);
        System.out.println("Terms accepted: " + terms);

        if (terms) {
            // Database connection details
            String jdbcURL = "jdbc:mysql://localhost:3306/agriconnect";
            String dbUser = "root";
            String dbPassword = "admin";

            Connection connection = null;
            PreparedStatement statement = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
                statement = connection.prepareStatement(sql);
                statement.setString(1, name);
                statement.setString(2, email);
                statement.setString(3, password);

                int rows = statement.executeUpdate();
                if (rows > 0) {
                    System.out.println("User registered successfully.");
                    response.sendRedirect("register-success.jsp");
                } else {
                    System.out.println("User registration failed: No rows affected.");
                    response.sendRedirect("register-fail.jsp");
                }

            } catch (ClassNotFoundException e) {
                System.err.println("Database driver not found.");
                e.printStackTrace();
                response.sendRedirect("register-fail.jsp");
            } catch (SQLException e) {
                System.err.println("SQL error: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect("register-fail.jsp");
            } catch (Exception e) {
                System.err.println("Unexpected error: " + e.getMessage());
                e.printStackTrace();
                response.sendRedirect("register-fail.jsp");
            } finally {
                try {
                    if (statement != null) {
                        statement.close();
                    }
                    if (connection != null) {
                        connection.close();
                    }
                } catch (SQLException e) {
                    System.err.println("Error closing resources: " + e.getMessage());
                }
            }
        } else {
            System.out.println("Terms and conditions not accepted.");
            response.sendRedirect("register-fail.jsp");
        }
	}
}
