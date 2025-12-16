<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>会话统计</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>当前在线会话统计</h1>
    <p>当前在线用户数：<%= application.getAttribute("sessionList") != null ? 
        ((List) application.getAttribute("sessionList")).size() : 0 %></p>
    
    <table>
        <tr>
            <th>会话ID</th>
            <th>创建时间</th>
        </tr>
        <c:forEach var="sess" items="${applicationScope.sessionList}">
            <tr>
                <td>${sess.id}</td>
                <td>${sess.creationTime}</td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>