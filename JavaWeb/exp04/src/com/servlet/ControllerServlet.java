package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import com.cart.*;

public class ControllerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("delete".equals(action)) {
            deleteItem(request, response);
        } else if ("updateItem".equals(action)) {
            updateItem(request, response);
        } else {
            showCart(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置请求编码（放在最前面）
        request.setCharacterEncoding("UTF-8");
        
        // ✅ 关键：根据 URL 路径判断是否为 /updateItem 请求
        String servletPath = request.getServletPath();
        String action = request.getParameter("action");

        if ("/updateItem".equals(servletPath)) {
            // 当请求路径是 /updateItem 时，直接调用更新方法
            updateItem(request, response);
        } else if ("add".equals(action)) {
            addItem(request, response);
        } else if ("修改".equals(action) || "批量修改".equals(action)) {
            // 兼容表单中通过 action 参数提交的更新请求（可选保留）
            updateItem(request, response);
        } else {
            showCart(request, response);
        }
    }
    
    // 添加商品
    private void addItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        GoodsItem item = new GoodsItem(id, name, price, quantity);
        cart.add(item);
        session.setAttribute("cart", cart);

        System.out.println("ControllerServlet: 添加商品成功，会话ID=" + session.getId() + ", 商品数量=" + cart.getItems().size());

        showCart(request, response);
    }
    
    // 显示购物车
    private void showCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/showCart.jsp").forward(request, response);
    }
    
    // 删除商品
    private void deleteItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        
        if (cart != null) {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                try {
                    int id = Integer.parseInt(idStr);
                    cart.remove(id);
                } catch (NumberFormatException e) {
                    // 忽略无效ID
                }
            }
        }
        showCart(request, response);
    }
    
    // 更新商品（支持单个和批量）
    private void updateItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
        
        if (cart != null) {
            String idStr = request.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                // 单个商品更新
                try {
                    int id = Integer.parseInt(idStr);
                    String qtyStr = request.getParameter("quantity_" + id);
                    if (qtyStr != null && !qtyStr.isEmpty()) {
                        int quantity = Integer.parseInt(qtyStr);
                        GoodsItem item = new GoodsItem();
                        item.setId(id);
                        item.setQuantity(quantity);
                        cart.update(item);
                    }
                } catch (NumberFormatException e) {
                    // 忽略解析错误
                }
            } else {
                // 批量更新所有商品
                for (GoodsItem item : cart.getItems()) {
                    String qtyStr = request.getParameter("quantity_" + item.getId());
                    if (qtyStr != null && !qtyStr.isEmpty()) {
                        try {
                            int quantity = Integer.parseInt(qtyStr);
                            item.setQuantity(quantity);
                        } catch (NumberFormatException e) {
                            // 忽略无效数量
                        }
                    }
                }
            }
        }
        showCart(request, response);
    }
}