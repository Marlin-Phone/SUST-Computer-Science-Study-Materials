<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.beans.BookBean" %>
<%@ page import="com.dao.BookDAO" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>图书信息列表</title>
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
    <h1>图书信息列表</h1>
    <%
        BookDAO bookDAO = new BookDAO();
        List<BookBean> books = bookDAO.getAllBooks();
        System.out.println("获取图书数量: " + (books != null ? books.size() : 0));
    %>
    <table>
        <tr>
            <th>书号</th>
            <th>书名</th>
            <th>作者</th>
            <th>价格</th>
            <th>出版社</th>
        </tr>
        <% if (books != null && !books.isEmpty()) { %>
            <% for (BookBean book : books) { %>
            <tr>
                <td><%= book.getBookId() %></td>
                <td><%= book.getTitle() %></td>
                <td><%= book.getAuthor() %></td>
                <td><%= book.getPrice() %></td>
                <td><%= book.getPublisher() %></td>
            </tr>
            <% } %>
        <% } else { %>
            <tr>
                <td colspan="5" style="text-align:center;">未找到图书数据</td>
            </tr>
        <% } %>
    </table>
</body>
</html>