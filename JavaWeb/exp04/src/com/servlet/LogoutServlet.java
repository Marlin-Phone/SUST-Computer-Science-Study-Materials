package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 获取会话并销毁
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        // 删除Cookie
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName()) || "password".equals(cookie.getName())) {
                    cookie.setMaxAge(0); // 删除Cookie
                    response.addCookie(cookie);
                }
            }
        }
        
        out.println("<html><head><title>退出登录</title></head><body>");
        out.println("<h2>您已成功退出登录</h2>");
        out.println("<p><a href='checkUser'>重新登录</a></p>");
        out.println("</body></html>");
    }
}