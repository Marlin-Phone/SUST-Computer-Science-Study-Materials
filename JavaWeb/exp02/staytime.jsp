<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%
    // 获取登录时间
    Date loginTime = (Date) session.getAttribute("loginTime");
    
    // 如果是第一次访问，记录登录时间
    if (loginTime == null) {
        loginTime = new Date();
        session.setAttribute("loginTime", loginTime);
    }
    
    // 获取当前时间
    Date currentTime = new Date();
    
    // 计算停留时间（毫秒）
    long stayTime = currentTime.getTime() - loginTime.getTime();
    
    // 转换为秒
    long staySeconds = stayTime / 1000;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="refresh" content="10">
<title>页面停留时间统计</title>
</head>
<body>
<h2>页面停留时间统计</h2>
<p>登录时间: <%= loginTime %></p>
<p>当前时间: <%= currentTime %></p>
<p>您已在本页面停留 <%= staySeconds %> 秒。</p>
<p>页面每10秒自动刷新一次。</p>
</body>
</html>