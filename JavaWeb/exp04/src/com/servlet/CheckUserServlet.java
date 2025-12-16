package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;

public class CheckUserServlet extends HttpServlet {
    // 模拟用户数据库
    private static final String VALID_USERNAME = "admin";
    private static final String VALID_PASSWORD = "123456";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 检查Cookie中是否包含登录信息
        String savedUsername = null;
        String savedPassword = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    savedUsername = cookie.getValue();
                } else if ("password".equals(cookie.getName())) {
                    savedPassword = cookie.getValue();
                }
            }
        }
        
        // 验证Cookie中的登录信息
        if (savedUsername != null && savedPassword != null && 
            VALID_USERNAME.equals(savedUsername) && VALID_PASSWORD.equals(savedPassword)) {
            // 自动登录成功
            out.println("<html><head><title>自动登录成功</title></head><body>");
            out.println("<h2>欢迎回来，" + savedUsername + "！</h2>");
            out.println("<p>您已通过Cookie自动登录。</p>");
            out.println("<p><a href='checkUser'>刷新页面</a> | <a href='logout'>退出登录</a></p>");
            out.println("</body></html>");
        } else {
            // 显示登录表单
            showLoginForm(out, false);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 获取用户输入的用户名和密码
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String autoLogin = request.getParameter("autoLogin");
        
        // 验证用户名和密码
        if (VALID_USERNAME.equals(username) && VALID_PASSWORD.equals(password)) {
            // 登录成功
            out.println("<html><head><title>登录成功</title></head><body>");
            out.println("<h2>登录成功！</h2>");
            out.println("<p>欢迎，" + username + "！</p>");
            
            // 如果用户选择了自动登录，发送Cookie
            if ("on".equals(autoLogin)) {
                Cookie usernameCookie = new Cookie("username", username);
                Cookie passwordCookie = new Cookie("password", password);
                
                // 设置Cookie的有效期为7天
                usernameCookie.setMaxAge(7 * 24 * 60 * 60);
                passwordCookie.setMaxAge(7 * 24 * 60 * 60);
                
                // 添加Cookie到响应中
                response.addCookie(usernameCookie);
                response.addCookie(passwordCookie);
                
                out.println("<p>已设置自动登录Cookie，有效期7天。</p>");
            }
            
            out.println("<p><a href='checkUser'>访问主页</a> | <a href='logout'>退出登录</a></p>");
            out.println("</body></html>");
        } else {
            // 登录失败
            out.println("<html><head><title>登录失败</title></head><body>");
            out.println("<h2 style='color:red;'>登录失败！</h2>");
            out.println("<p>用户名或密码错误。</p>");
            showLoginForm(out, true);
            out.println("</body></html>");
        }
    }
    
    // 显示登录表单
    private void showLoginForm(PrintWriter out, boolean showError) {
        if (showError) {
            out.println("<p style='color:red;'>登录失败，请重新输入用户名和密码。</p>");
        }
        
        out.println("<h2>用户登录</h2>");
        out.println("<form method='post' action='checkUser'>");
        out.println("<table>");
        out.println("<tr><td>用户名：</td><td><input type='text' name='username' required></td></tr>");
        out.println("<tr><td>密码：</td><td><input type='password' name='password' required></td></tr>");
        out.println("<tr><td colspan='2'><input type='checkbox' name='autoLogin'> 记住我（自动登录）</td></tr>");
        out.println("<tr><td colspan='2'><input type='submit' value='登录'> <input type='reset' value='重置'></td></tr>");
        out.println("</table>");
        out.println("</form>");
    }
}