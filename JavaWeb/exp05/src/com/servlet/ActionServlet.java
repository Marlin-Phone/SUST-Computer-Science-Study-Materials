package com.servlet;

import com.beans.CustomerBean;
import com.dao.CustomerDAOImpl;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ActionServlet")
public class ActionServlet extends HttpServlet {
    private CustomerDAOImpl customerDAO = new CustomerDAOImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String email = request.getParameter("email");
        
        if ("delete".equals(action)) {
            boolean success = customerDAO.deleteCustomer(email);
            if (success) {
                response.getWriter().println("<h2>客户删除成功！</h2>");
            } else {
                response.getWriter().println("<h2>客户删除失败！</h2>");
            }
            response.getWriter().println("<a href='showCustomer.jsp'>返回客户列表</a>");
        } else if ("edit".equals(action)) {
            CustomerBean customer = customerDAO.getCustomerByEmail(email);
            if (customer != null) {
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
            } else {
                response.getWriter().println("<h2>未找到该客户！</h2>");
                response.getWriter().println("<a href='showCustomer.jsp'>返回客户列表</a>");
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("update".equals(action)) {
            request.setCharacterEncoding("UTF-8");
            
            String custName = request.getParameter("custName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            
            CustomerBean customer = new CustomerBean();
            customer.setCustName(custName);
            customer.setEmail(email);
            customer.setPhone(phone);
            
            boolean success = customerDAO.updateCustomer(customer);
            if (success) {
                response.getWriter().println("<h2>客户信息更新成功！</h2>");
            } else {
                response.getWriter().println("<h2>客户信息更新失败！</h2>");
            }
            response.getWriter().println("<a href='showCustomer.jsp'>返回客户列表</a>");
        }
    }
}