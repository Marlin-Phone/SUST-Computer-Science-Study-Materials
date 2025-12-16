<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加图书</title>
</head>
<body>
    <h1>添加新图书</h1>
    <form action="BookInsertServlet" method="post">
        <label>书号：<input type="text" name="bookId" required></label><br>
        <label>书名：<input type="text" name="title" required></label><br>
        <label>作者：<input type="text" name="author" required></label><br>
        <label>价格：<input type="number" name="price" step="0.01" required></label><br>
        <label>出版社：<input type="text" name="publisher" required></label><br>
        <input type="submit" value="添加">
    </form>
</body>
</html>