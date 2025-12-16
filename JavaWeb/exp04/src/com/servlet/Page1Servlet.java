package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class Page1Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        
        out.println("<html><head><title>页面1</title></head><body>");
        out.println("<h2>页面1</h2>");
        if (session != null) {
            out.println("<p>会话ID: " + session.getId() + "</p>");
        } else {
            out.println("<p>没有会话</p>");
        }
        out.println("<p><a href='" + response.encodeURL("home") + "'>返回主页</a></p>");
        out.println("</body></html>");
    }
}