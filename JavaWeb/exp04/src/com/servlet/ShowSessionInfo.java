package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.Date;

public class ShowSessionInfo extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 获取会话对象，如果不存在则创建
        HttpSession session = request.getSession(true);
        
        // 获取会话ID
        String sessionId = session.getId();
        
        // 获取会话创建时间
        long creationTime = session.getCreationTime();
        Date creationDate = new Date(creationTime);
        
        // 获取最近访问时间
        long lastAccessTime = session.getLastAccessedTime();
        Date lastAccessDate = new Date(lastAccessTime);
        
        // 获取访问次数（自定义属性）
        Integer accessCount = (Integer) session.getAttribute("accessCount");
        if (accessCount == null) {
            accessCount = 1;
        } else {
            accessCount = accessCount + 1;
        }
        session.setAttribute("accessCount", accessCount);
        
        out.println("<html><head><title>会话信息</title></head><body>");
        out.println("<h2>会话信息</h2>");
        out.println("<p><strong>会话ID：</strong>" + sessionId + "</p>");
        out.println("<p><strong>会话创建时间：</strong>" + creationDate.toString() + "</p>");
        out.println("<p><strong>最近访问时间：</strong>" + lastAccessDate.toString() + "</p>");
        out.println("<p><strong>访问次数：</strong>" + accessCount + "</p>");
        out.println("<p><a href='showSessionInfo'>刷新页面</a></p>");
        out.println("</body></html>");
    }
}