package com.project;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/image")
public class ImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productId = request.getParameter("id");

        if (productId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "No product ID specified");
            return;
        }

        String url = "jdbc:mysql://localhost:3306/agriconnect";
        String user = "root";
        String password = "admin";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);

            String sql = "SELECT image FROM products WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(productId));
            rs = stmt.executeQuery();

            if (rs.next()) {
                byte[] imageData = rs.getBytes("image");
                response.setContentType("image/jpeg"); // Adjust the content type if necessary
                response.setContentLength(imageData.length);

                OutputStream out = response.getOutputStream();
                out.write(imageData);
                out.flush();
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving image");
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
