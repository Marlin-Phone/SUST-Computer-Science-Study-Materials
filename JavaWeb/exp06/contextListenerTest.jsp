<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>ServletContext监听器测试</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>ServletContext监听器测试</h1>
    <%
        Connection connection = (Connection) application.getAttribute("dataSource");
        if (connection == null) {
            out.println("<p style='color: red;'>错误：无法获取数据库连接，请检查监听器是否正常工作。</p>");
        } else {
            try {
                Statement stmt = connection.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT bookId, title, author, price, publisher FROM books");
    %>
    <table>
        <tr>
            <th>书号</th>
            <th>书名</th>
            <th>作者</th>
            <th>价格</th>
            <th>出版社</th>
        </tr>
        <% while (rs.next()) { %>
        <tr>
            <td><%= rs.getString("bookId") %></td>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("author") %></td>
            <td><%= rs.getDouble("price") %></td>
            <td><%= rs.getString("publisher") %></td>
        </tr>
        <% } %>
    </table>
    <%
                rs.close();
                stmt.close();
            } catch (SQLException e) {
                out.println("<p style='color: red;'>查询数据库时发生错误：" + e.getMessage() + "</p>");
                e.printStackTrace();
            }
        }
    %>
</body>
</html>