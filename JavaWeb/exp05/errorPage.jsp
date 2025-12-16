<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>错误页面</title>
    <style>
        .error-container {
            margin: 50px auto;
            padding: 20px;
            max-width: 800px;
            border: 1px solid #f00;
            background-color: #ffecec;
        }
        .error-title {
            color: #d00;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .error-details {
            background-color: #fff;
            padding: 15px;
            border-radius: 5px;
            font-family: monospace;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-title">系统错误</div>
        <div class="error-details">
            <% if (exception != null) { %>
                <p>错误信息: <%= exception.getMessage() %></p>
                <p>错误类型: <%= exception.getClass().getName() %></p>
            <% } else { %>
                <p>错误信息: 未知错误</p>
            <% } %>
            <p>请求URI: <%= request.getRequestURI() %></p>
            <p>时间: <%= new java.util.Date() %></p>
        </div>
        <p><a href="bookQuery.jsp">返回图书查询</a> | <a href="bookInsert.jsp">返回图书录入</a></p>
    </div>
</body>
</html>