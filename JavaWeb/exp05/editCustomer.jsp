<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.beans.CustomerBean" %>
<html>
<head>
    <title>修改客户信息</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }
        form {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 3px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .back-link {
            display: block;
            margin-top: 15px;
            text-align: center;
            text-decoration: none;
            color: #007bff;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>修改客户信息</h1>
    <%
        CustomerBean customer = (CustomerBean) request.getAttribute("customer");
        if (customer == null) {
            customer = new CustomerBean();
            customer.setCustName(request.getParameter("custName"));
            customer.setEmail(request.getParameter("email"));
            customer.setPhone(request.getParameter("phone"));
        }
    %>
    <form action="ActionServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="email" value="<%= customer.getEmail() %>">
        客户姓名：<input type="text" name="custName" value="<%= customer.getCustName() %>" required><br>
        邮箱：<input type="email" name="email" value="<%= customer.getEmail() %>" readonly><br>
        电话：<input type="text" name="phone" value="<%= customer.getPhone() %>" required><br>
        <input type="submit" value="更新客户信息">
    </form>
    <a href="showCustomer.jsp" class="back-link">返回客户列表</a>
</body>
</html>