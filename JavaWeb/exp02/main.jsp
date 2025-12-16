<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%
    // 从session中获取用户名
    String username = (String) session.getAttribute("username");
    
    // 如果未登录，重定向到登录页面
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>主页面</title>
</head>
<body>
<h2>欢迎,<%= username %>!</h2>
<p>当前时间:<%= new Date() %></p>
<a href="exit.jsp">退出登录</a>
</body>
</html>