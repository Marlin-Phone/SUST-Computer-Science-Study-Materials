<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.beans.CustomerBean" %>
<%@ page import="com.dao.CustomerDAOImpl" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>客户信息列表</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .action-links {
            margin-top: 20px;
        }
        .action-links a {
            margin-right: 10px;
            text-decoration: none;
            color: #007bff;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
        h1 {
            color: #333;
        }
    </style>
</head>
<body>
    <h1>客户信息列表</h1>
    <%
        CustomerDAOImpl customerDAO = new CustomerDAOImpl();
        List<CustomerBean> customers = customerDAO.getAllCustomers();
    %>
    <table>
        <tr>
            <th>客户姓名</th>
            <th>邮箱</th>
            <th>电话</th>
            <th>操作</th>
        </tr>
        <% for (CustomerBean customer : customers) { %>
        <tr>
            <td><%= customer.getCustName() %></td>
            <td><%= customer.getEmail() %></td>
            <td><%= customer.getPhone() %></td>
            <td>
                <a href="ActionServlet?action=edit&email=<%= customer.getEmail() %>">修改</a>
                <a href="ActionServlet?action=delete&email=<%= customer.getEmail() %>" 
                   onclick="return confirm('确定要删除该客户吗？')">删除</a>
            </td>
        </tr>
        <% } %>
    </table>
    <div class="action-links">
        <a href="insertCustomer.jsp">添加新客户</a>
    </div>
</body>
</html>