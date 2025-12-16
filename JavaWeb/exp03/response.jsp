<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 从request参数获取userName（适用于静态包含和直接访问）
    String displayUserName = request.getParameter("userName");
%>
<p>子页面中的userName变量值：<%= displayUserName != null ? displayUserName : "未设置" %></p>
<p>这是通过静态包含引入的子页面内容</p>