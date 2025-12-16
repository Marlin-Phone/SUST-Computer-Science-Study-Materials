package com.demo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ConfigDemoServlet extends HttpServlet {
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

        // 获取Servlet名称
        String servletName = getServletConfig().getServletName();

        // 获取初始化参数
        String email = getServletConfig().getInitParameter("email");
        String telephone = getServletConfig().getInitParameter("telephone");

        // 获取ServletContext初始化参数
        String adminEmail = getServletContext().getInitParameter("admin-email");
        String adminTel = getServletContext().getInitParameter("admin-tel");

        // 将参数写入日志
        getServletContext().log("Admin Email: " + adminEmail);
        getServletContext().log("Admin Tel: " + adminTel);

        // 输出HTML页面
        out.println("<html>");
        out.println("<head>");
        out.println("<title>Servlet配置参数演示</title>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>Servlet配置参数演示</h2>");
        out.println("<p><strong>Servlet名称:</strong> " + servletName + "</p>");
        out.println("<p><strong>Email:</strong> " + (email != null ? email : "未设置") + "</p>");
        out.println("<p><strong>Telephone:</strong> " + (telephone != null ? telephone : "未设置") + "</p>");
        out.println("<h3>ServletContext参数:</h3>");
        out.println("<p><strong>Admin Email:</strong> " + (adminEmail != null ? adminEmail : "未设置") + "</p>");
        out.println("<p><strong>Admin Tel:</strong> " + (adminTel != null ? adminTel : "未设置") + "</p>");
        out.println("<p><a href='input.html'>返回首页</a></p>");
        out.println("</body>");
        out.println("</html>");
    }
}