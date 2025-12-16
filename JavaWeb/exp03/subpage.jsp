<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<p>子页面中通过param获取的userName值：<%= request.getParameter("userName") %></p>
<p>子页面中通过request.getAttribute获取的userName值：<%= request.getAttribute("userName") %></p>
<p>这是通过动态包含引入的子页面内容</p>