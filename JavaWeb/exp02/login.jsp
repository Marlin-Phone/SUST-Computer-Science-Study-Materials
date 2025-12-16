<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>用户登录</title>
</head>
<body>
<h2>用户登录</h2>
<%
    // 获取错误信息
    String errorMsg = (String) request.getAttribute("errorMsg");
    if (errorMsg != null) {
%>
    <p style="color:red;"><%= errorMsg %></p>
<%
    }
%>
<form action="deal.jsp" method="post">
    <table>
        <tr>
            <td>用户名：</td>
            <td><input type="text" name="username" value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>"></td>
        </tr>
        <tr>
            <td>密码：</td>
            <td><input type="password" name="password"></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="登录">
                <input type="reset" value="重置">
            </td>
        </tr>
    </table>
</form>
</body>
</html>