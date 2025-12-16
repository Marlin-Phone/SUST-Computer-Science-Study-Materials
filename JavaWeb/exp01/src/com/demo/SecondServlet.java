package com.demo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SecondServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置响应内容类型和编码
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        // 从request作用域中获取Student对象
        Student student = (Student) request.getAttribute("student");
        
        // 显示学生信息
        out.println("<html>");
        out.println("<head>");
        out.println("<title>学生信息显示</title>");
        out.println("<meta http-equiv='refresh' content='5;url=input.html'>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>学生信息</h2>");
        if (student != null) {
            out.println("<p>学号：" + student.getSno() + "</p>");
            out.println("<p>姓名：" + student.getName() + "</p>");
        } else {
            out.println("<p>未找到学生信息</p>");
        }
        out.println("<p>5秒后自动返回输入页面...</p>");
        out.println("</body>");
        out.println("</html>");
    }
}