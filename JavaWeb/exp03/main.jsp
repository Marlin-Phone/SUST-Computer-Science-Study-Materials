<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userName = request.getParameter("userName");
    request.setAttribute("userName", userName);
%>
<html>
<head>
    <title>动态包含示例</title>
</head>
<body>
<h2>主页面</h2>
<p>主页面中的userName变量值：<%= userName %></p>
<h3>包含的子页面内容：</h3>
<jsp:include page="subpage.jsp">
    <jsp:param name="userName" value="<%= userName %>"/>
</jsp:include>
</body>
</html>