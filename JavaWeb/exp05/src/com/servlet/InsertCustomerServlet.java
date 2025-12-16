package com.servlet;

import com.beans.CustomerBean;
import com.dao.CustomerDAOImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/InsertCustomerServlet")
public class InsertCustomerServlet extends HttpServlet {
    private CustomerDAOImpl customerDAO = new CustomerDAOImpl();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 设置请求编码
        request.setCharacterEncoding("UTF-8");
        
        // 获取表单数据
        String custName = request.getParameter("custName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        
        // 创建CustomerBean对象
        CustomerBean customer = new CustomerBean();
        customer.setCustName(custName);
        customer.setEmail(email);
        customer.setPhone(phone);
        
        // 调用DAO插入数据
        try {
            boolean success = customerDAO.insertCustomer(customer);
            
            // 设置响应
            response.setContentType("text/html;charset=UTF-8");
            if (success) {
                response.getWriter().println("<h2>客户信息添加成功！</h2>");
                response.getWriter().println("<a href='showCustomer.jsp'>查看所有客户</a>");
                response.getWriter().println("<br><a href='insertCustomer.jsp'>继续添加客户</a>");
            } else {
                response.getWriter().println("<h2>客户信息添加失败！</h2>");
                response.getWriter().println("<a href='insertCustomer.jsp'>返回添加页面</a>");
            }
        } catch (Exception e) {
            response.getWriter().println("<h2>添加过程中发生错误：</h2>");
            response.getWriter().println("<pre>");
            e.printStackTrace(response.getWriter());
            response.getWriter().println("</pre>");
            response.getWriter().println("<a href='insertCustomer.jsp'>返回添加页面</a>");
        }
    }
}