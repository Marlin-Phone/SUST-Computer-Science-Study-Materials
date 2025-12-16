<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加客户信息</title>
    <meta charset="UTF-8">
</head>
<body>
    <h1>添加客户信息</h1>
    <form action="InsertCustomerServlet" method="post">
        客户姓名：<input type="text" name="custName" required><br>
        邮箱：<input type="email" name="email" required><br>
        电话：<input type="text" name="phone" required><br>
        <input type="submit" value="添加客户">
    </form>
</body>
</html>