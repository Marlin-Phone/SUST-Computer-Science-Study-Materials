<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品列表</title>
</head>
<body>
<h2>商品列表</h2>

<form action="controller" method="post">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="id" value="1">
    <input type="hidden" name="name" value="商品A">
    <input type="hidden" name="price" value="10.0">
    <table>
        <tr>
            <td>商品A - 价格: ￥10.0</td>
            <td>数量: <input type="number" name="quantity" value="1" min="1"></td>
            <td><input type="submit" value="添加到购物车"></td>
        </tr>
    </table>
</form>

<!-- 商品B、C 的 form 同样修改 action="controller" -->

<form action="controller" method="post">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="id" value="2">
    <input type="hidden" name="name" value="商品B">
    <input type="hidden" name="price" value="20.0">
    <table>
        <tr>
            <td>商品B - 价格: ￥20.0</td>
            <td>数量: <input type="number" name="quantity" value="1" min="1"></td>
            <td><input type="submit" value="添加到购物车"></td>
        </tr>
    </table>
</form>

<form action="controller" method="post">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="id" value="3">
    <input type="hidden" name="name" value="商品C">
    <input type="hidden" name="price" value="15.0">
    <table>
        <tr>
            <td>商品C - 价格: ￥15.0</td>
            <td>数量: <input type="number" name="quantity" value="1" min="1"></td>
            <td><input type="submit" value="添加到购物车"></td>
        </tr>
    </table>
</form>

<!-- ✅ 关键修改：href="controller" 而不是 "showCart.jsp" -->
<p><a href="controller">查看购物车</a> | <a href="index.html">返回首页</a></p>
</body>
</html>