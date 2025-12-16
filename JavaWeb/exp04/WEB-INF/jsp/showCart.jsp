<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cart.ShoppingCart, com.cart.GoodsItem, java.util.List" %>
<%
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if (cart == null) {
        cart = new ShoppingCart();
        session.setAttribute("cart", cart);
    }
%>
<html>
<head>
    <title>购物车</title>
</head>
<body>
<h2>购物车</h2>
<%
    List<GoodsItem> items = cart.getItems();
    if (items.isEmpty()) {
%>
<p>购物车为空</p>
<%
    } else {
%>
<form method="post" action="/exp04/controller">
<table border="1">
    <tr>
        <th>商品名称</th>
        <th>单价</th>
        <th>数量</th>
        <th>小计</th>
        <th>操作</th>
    </tr>
<%
        for (GoodsItem item : items) {
%>
    <tr>
        <td><%= item.getName() %></td>
        <td>￥<%= item.getPrice() %></td>
        <td>
            <input type="number" name="quantity_<%= item.getId() %>" 
                   value="<%= item.getQuantity() %>" min="1" style="width: 50px;">
        </td>
        <td>￥<%= item.getPrice() * item.getQuantity() %></td>
        <td>
            <input type="submit" name="action" value="修改">
            <input type="hidden" name="id" value="<%= item.getId() %>">
            <a href="controller?action=delete&id=<%= item.getId() %>">删除</a>
        </td>
    </tr>
<%
        }
%>
</table>
<input type="submit" name="action" value="批量修改">
</form>
<p><strong>总计：￥<%= cart.getTotal() %></strong></p>
<%
    }
%>
<p><a href="products">继续购物</a></p>
</body>
</html>