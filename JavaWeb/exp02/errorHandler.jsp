<%@ page language="java" isErrorPage="true" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<body>
<h2>错误处理页面</h2>
<p>发生了以下错误：</p>
<p><%= exception.getMessage() %></p>
</body>
</html>