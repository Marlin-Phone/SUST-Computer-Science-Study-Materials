package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 确保会话存在
        HttpSession session = request.getSession();
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>主页</title></head><body>");
        out.println("<h2>主页</h2>");
        out.println("<p>会话ID: " + session.getId() + "</p>");
        
        // 使用URL重写生成链接
        String page1Url = response.encodeURL("page1");
        String page2Url = response.encodeURL("page2");
        
        out.println("<p><a href='" + page1Url + "'>页面1</a></p>");
        out.println("<p><a href='" + page2Url + "'>页面2</a></p>");
        out.println("</body></html>");
    }
}

// Page1Servlet和Page2Servlet已移动到独立文件中
// 此处不再需要内部类定义