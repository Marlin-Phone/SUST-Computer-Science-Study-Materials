<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userName = request.getParameter("userName");
    pageContext.setAttribute("userName", userName);
%>
<html>
<head>
    <title>静态包含示例 - 方法二</title>
</head>
<body>
<h2>主页面</h2>
<p>主页面中的userName变量值：<%= userName %></p>
<h3>包含的子页面内容：</h3>
<%@ include file="response2.jsp" %>
</body>
</html>