package com.demo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 成员变量，用于保存该Servlet被访问的次数
    private int memberCount = 0;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置响应内容类型和编码
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 增加成员变量计数
        memberCount++;

        // 通过ServletContext属性保存被多用户同时访问的次数
        // 从ServletContext中获取计数器，如果不存在则初始化为0
        Integer contextCount = (Integer) getServletContext().getAttribute("contextCount");
        if (contextCount == null) {
            contextCount = 0;
        }
        // 增加上下文计数
        contextCount++;
        // 将更新后的计数保存到ServletContext中
        getServletContext().setAttribute("contextCount", contextCount);

        // 输出HTML页面
        out.println("<html>");
        out.println("<head>");
        out.println("<title>访问计数器</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>访问计数器</h2>");
        out.println("<p><strong>成员变量计数（单个Servlet实例）:</strong> " + memberCount + "</p>");
        out.println("<p><strong>ServletContext计数（所有用户共享）:</strong> " + contextCount + "</p>");
        out.println("<p><a href='count'>刷新计数</a> | <a href='input.html'>返回首页</a></p>");
        out.println("</body>");
        out.println("</html>");
    }
}