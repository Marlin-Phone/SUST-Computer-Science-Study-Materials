<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 模拟用户数据库
    String[][] users = {
        {"admin", "123456"},
        {"user1", "password1"},
        {"user2", "password2"}
    };
    
    // 获取表单数据
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    // 验证用户
    boolean isValidUser = false;
    for (int i = 0; i < users.length; i++) {
        if (users[i][0].equals(username) && users[i][1].equals(password)) {
            isValidUser = true;
            break;
        }
    }
    
    if (isValidUser) {
        // 登录成功，将用户名保存到session中
        session.setAttribute("username", username);
        // 重定向到主页面
        response.sendRedirect("main.jsp");
    } else {
        // 登录失败，设置错误信息并转发回登录页面
        request.setAttribute("errorMsg", "用户名或密码错误，请重新输入！");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
%>