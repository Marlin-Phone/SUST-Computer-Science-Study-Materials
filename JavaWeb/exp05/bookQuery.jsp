<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>图书查询</title>
</head>
<body>
    <h1>图书查询</h1>
    <form action="BookQueryServlet" method="post">
        <label>书名：<input type="text" name="title"></label><br>
        <label>作者：<input type="text" name="author"></label><br>
        <input type="submit" value="查询">
    </form>
</body>
</html>