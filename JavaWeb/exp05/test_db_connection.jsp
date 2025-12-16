<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String url = "jdbc:mysql://localhost:3306/test?serverTimezone=Asia/Shanghai";
    String user = "root";
    String password = "yourPassword";
    String result = "数据库连接失败！";
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection conn = DriverManager.getConnection(url, user, password)) {
            result = "数据库连接成功！";
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SHOW TABLES LIKE 'customer'")) {
                if (rs.next()) {
                    result += "<br>customer表存在";
                } else {
                    result += "<br>customer表不存在";
                }
            }
        }
    } catch (Exception e) {
        result += "<br>错误信息: " + e.getMessage();
    }
%>
<html>
<head>
    <title>数据库连接测试</title>
</head>
<body>
    <h1><%= result %></h1>
    <h2>测试详情：</h2>
    <ul>
        <li>URL: <%= url %></li>
        <li>用户: <%= user %></li>
        <li>驱动: com.mysql.cj.jdbc.Driver</li>
    </ul>
</body>
</html>