<%@ page language="java" errorPage="errorHandler.jsp" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<body>
<%
    String name = request.getParameter("name");
    if (name == null || name.equals("")) {
        throw new RuntimeException("没有指定name 属性");
    } else {
        out.println("Hello " + name);
    }
%>
</body>
</html>