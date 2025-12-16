<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.beans.BookBean" %>
<!DOCTYPE html>
<html>
<head>
    <title>图书查询结果</title>
</head>
<body>
    <h1>图书查询结果</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>书名</th>
            <th>作者</th>
            <th>价格</th>
            <th>出版社</th>
        </tr>
        <% 
        List<BookBean> books = (List<BookBean>) request.getAttribute("books");
        if (books != null) {
            for (BookBean book : books) { 
        %>
        <tr>
            <td><%= book.getBookId() %></td>
            <td><%= book.getTitle() %></td>
            <td><%= book.getAuthor() %></td>
            <td><%= book.getPrice() %></td>
            <td><%= book.getPublisher() %></td>
        </tr>
        <% 
            }
        } else {
        %>
        <tr>
            <td colspan="5">没有找到匹配的图书</td>
        </tr>
        <% } %>
    </table>
    <p><a href="bookQuery.jsp">返回查询页面</a></p>
</body>
</html>