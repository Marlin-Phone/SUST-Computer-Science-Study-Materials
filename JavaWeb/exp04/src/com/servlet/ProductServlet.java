package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

/**
 * 商品展示 Servlet
 * 访问路径: /products
 */
public class ProductServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 转发到受保护的商品页面
        request.getRequestDispatcher("/WEB-INF/jsp/products.jsp").forward(request, response);
    }
}