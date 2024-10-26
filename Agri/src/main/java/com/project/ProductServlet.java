package com.project;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/ProductServlet")
@MultipartConfig(maxFileSize = 16177215) // 16MB
public class ProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addProduct(request, response);
        } else if ("delete".equals(action)) {
            deleteProduct(request, response);
        } else if ("update".equals(action)) {
            updateProduct(request, response);
        } else if ("view".equals(action)) {
            viewProducts(request, response);
        }
    }

    public void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String productName = request.getParameter("name");
        Part filePart = request.getPart("image");
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));

        InputStream inputStream = null;
        if (filePart != null) {
            inputStream = filePart.getInputStream();
        }

        String jdbcURL = "jdbc:mysql://localhost:3306/agriconnect";
        String dbUser = "root";
        String dbPassword = "admin";

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            String sql = "INSERT INTO products (id, name, image, description, quantity, price) VALUES (?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, id);
            statement.setString(2, productName);
            if (inputStream != null) {
                statement.setBlob(3, inputStream);
            }
            statement.setString(4, description);
            statement.setInt(5, quantity);
            statement.setDouble(6, price);

            int rows = statement.executeUpdate();
            if (rows > 0) {
                System.out.println("Product added successfully.");
                response.sendRedirect("success.jsp");
            } else {
                System.out.println("Product addition failed: No rows affected.");
                response.sendRedirect("error.jsp");
            }

        } catch (ClassNotFoundException e) {
            System.err.println("Database driver not found.");
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (SQLException e) {
            System.err.println("SQL error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
    }

    public void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");

        String jdbcURL = "jdbc:mysql://localhost:3306/agriconnect";
        String dbUser = "root";
        String dbPassword = "admin";

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            String sql = "DELETE FROM products WHERE id = ?";
            statement = connection.prepareStatement(sql);
            statement.setString(1, id);

            int rows = statement.executeUpdate();
            if (rows > 0) {
                System.out.println("Product deleted successfully.");
                response.sendRedirect("success.jsp");
            } else {
                System.out.println("Product deletion failed: No rows affected.");
                response.sendRedirect("error.jsp");
            }

        } catch (ClassNotFoundException e) {
            System.err.println("Database driver not found.");
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (SQLException e) {
            System.err.println("SQL error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
    }

    public void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String productName = request.getParameter("name");
        Part filePart = request.getPart("image");
        String description = request.getParameter("description");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double price = Double.parseDouble(request.getParameter("price"));

        InputStream inputStream = null;
        if (filePart != null) {
            inputStream = filePart.getInputStream();
        }

        String jdbcURL = "jdbc:mysql://localhost:3306/agriconnect";
        String dbUser = "root";
        String dbPassword = "admin";

        Connection connection = null;
        PreparedStatement statement = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
            
            String sql = "UPDATE products SET name = ?, image = ?, description = ?, quantity = ?, price = ? WHERE id = ?";
            statement = connection.prepareStatement(sql);
            
            statement.setString(1, productName);
            
            if (inputStream != null) {
                statement.setBlob(2, inputStream);
            } else {
                statement.setNull(2, java.sql.Types.BLOB);
            }
            
            statement.setString(3, description);
            statement.setInt(4, quantity);
            statement.setDouble(5, price);
            statement.setString(6, id);

            int rows = statement.executeUpdate();
            if (rows > 0) {
                System.out.println("Product updated successfully.");
                response.sendRedirect("success.jsp");
            } else {
                System.out.println("Product update failed: No rows affected.");
                response.sendRedirect("error.jsp");
            }

        } catch (ClassNotFoundException e) {
            System.err.println("Database driver not found.");
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (SQLException e) {
            System.err.println("SQL error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
    }

    public void viewProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String jdbcURL = "jdbc:mysql://localhost:3306/agriconnect";
        String dbUser = "root";
        String dbPassword = "admin";

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            String sql = "SELECT * FROM products";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            request.setAttribute("productList", resultSet);

            // Forward to the JSP page to display products
            request.getRequestDispatcher("view-products.jsp").forward(request, response);

        } catch (ClassNotFoundException e) {
            System.err.println("Database driver not found.");
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (SQLException e) {
            System.err.println("SQL error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
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
    }
}
