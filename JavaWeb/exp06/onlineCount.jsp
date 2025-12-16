<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>页面访问统计</title>
</head>
<body>
    <h1>页面访问统计测试</h1>
    欢迎您，您的IP地址是<%= request.getRemoteAddr() %>
    <p>自应用程序启动以来，该页面被访问了
    <font color="blue"><%= application.getAttribute("count") != null ? application.getAttribute("count") : 0 %>
    </font>次<br>
    </p>
</body>
</html>