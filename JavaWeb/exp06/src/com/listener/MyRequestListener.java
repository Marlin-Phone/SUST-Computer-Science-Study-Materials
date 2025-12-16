package com.listener;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletRequestEvent;
import javax.servlet.ServletRequestListener;

@WebListener
public class MyRequestListener implements ServletRequestListener {
    
    @Override
    public void requestInitialized(ServletRequestEvent sre) {
        HttpServletRequest request = (HttpServletRequest) sre.getServletRequest();
        ServletContext context = sre.getServletContext();
        
        // 检查是否是onlineCount.jsp页面的请求
        if (request.getRequestURI().endsWith("onlineCount.jsp")) {
            // 获取计数器并递增
            Integer count = (Integer) context.getAttribute("count");
            if (count == null) {
                count = 1;
            } else {
                count++;
            }
            context.setAttribute("count", count);
            
            // 记录日志
            String remoteAddr = request.getRemoteAddr();
            context.log("页面访问统计: onlineCount.jsp被访问, IP=" + remoteAddr + 
                       ", 访问次数=" + count);
        }
    }
    
    @Override
    public void requestDestroyed(ServletRequestEvent sre) {
        // 请求销毁时的处理（本实验不需要特殊处理）
    }
}