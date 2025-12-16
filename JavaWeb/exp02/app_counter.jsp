<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 使用同步块确保线程安全
    synchronized (application) {
        // 从application对象中获取访问计数
        Integer accessCount = (Integer) application.getAttribute("accessCount");
        
        // 如果是第一次访问，初始化计数器
        if (accessCount == null) {
            accessCount = 0;
        }
        
        // 计数器加1
        accessCount++;
        
        // 将更新后的计数器保存到application对象中
        application.setAttribute("accessCount", accessCount);
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>网站访问计数器</title>
</head>
<body>
<h2>网站访问计数器</h2>
<p>本网站已被访问 <%= application.getAttribute("accessCount") %> 次。</p>
</body>
</html>