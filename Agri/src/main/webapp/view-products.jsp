<%@ page import="java.sql.ResultSet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Products</title>
</head>
<body>
    
            <%
                ResultSet rs = (ResultSet) request.getAttribute("productList");
                while (rs.next()) {
            %>
                <tr>
                    <td><%= rs.getString("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("description") %></td>
                    <td><%= rs.getInt("quantity") %></td>
                    <td><%= rs.getDouble("price") %></td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
