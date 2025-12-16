<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="calculator" class="com.beans.SimpleCalculator" scope="page"/>
<jsp:setProperty name="calculator" property="*"/>

<%
    // 如果是表单提交，则进行计算
    String first = request.getParameter("first");
    if (first != null && !first.isEmpty()) {
        calculator.calculate();
    }
%>

<html>
<head>
    <title>简单计算器</title>
</head>
<body>
<h2>简单计算器</h2>

<form method="post">
    <table>
        <tr>
            <td>第一个数:</td>
            <td><input type="text" name="first" value="<%= request.getParameter("first") != null ? request.getParameter("first") : "" %>"></td>
        </tr>
        <tr>
            <td>运算符:</td>
            <td>
                <select name="operator">
                    <option value="+" <%= "+".equals(request.getParameter("operator")) ? "selected" : "" %> >+</option>
                    <option value="-" <%= "-".equals(request.getParameter("operator")) ? "selected" : "" %> >-</option>
                    <option value="*" <%= "*".equals(request.getParameter("operator")) ? "selected" : "" %> >*</option>
                    <option value="/" <%= "/".equals(request.getParameter("operator")) ? "selected" : "" %> >/</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>第二个数:</td>
            <td><input type="text" name="second" value="<%= request.getParameter("second") != null ? request.getParameter("second") : "" %>"></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" value="计算">
                <input type="reset" value="重置">
            </td>
        </tr>
    </table>
</form>

<%
    // 显示计算结果
    if (first != null && !first.isEmpty()) {
        if (Double.isNaN(calculator.getResult())) {
%>
<p style="color:red;">错误：除数不能为零！</p>
<%
        } else {
%>
<h3>计算结果：<%= calculator.getFirst() %> <%= calculator.getOperator() %> <%= calculator.getSecond() %> = <%= calculator.getResult() %></h3>
<%
        }
    }
%>
</body>
</html>