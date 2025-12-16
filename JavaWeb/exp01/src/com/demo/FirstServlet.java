package com.demo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FirstServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 获取表单提交的学号和姓名
        String sno = request.getParameter("sno");
        String name = request.getParameter("name");

        // 创建Student对象
        Student student = new Student(sno, name);

        // 将Student对象存储在request作用域中
        request.setAttribute("student", student);

        // 转发请求到SecondServlet
        request.getRequestDispatcher("/second").forward(request, response);
    }
}