package com.listener;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;
import java.util.ArrayList;
import java.util.List;

@WebListener
public class MySessionListener implements HttpSessionListener {
    
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        ServletContext context = session.getServletContext();
        
        // 将新会话添加到会话列表
        @SuppressWarnings("unchecked")
        List<HttpSession> sessionList = (List<HttpSession>) context.getAttribute("sessionList");
        if (sessionList == null) {
            sessionList = new ArrayList<>();
            context.setAttribute("sessionList", sessionList);
        }
        sessionList.add(session);
        
        // 记录日志
        context.log("创建一个新会话: ID=" + session.getId() + 
                   ", 创建时间=" + new java.util.Date(session.getCreationTime()));
    }
    
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        HttpSession session = se.getSession();
        ServletContext context = session.getServletContext();
        
        // 从会话列表中移除会话
        @SuppressWarnings("unchecked")
        List<HttpSession> sessionList = (List<HttpSession>) context.getAttribute("sessionList");
        if (sessionList != null) {
            sessionList.remove(session);
            context.setAttribute("sessionList", sessionList);
        }
        
        // 记录日志
        context.log("删除一个会话: ID=" + session.getId() + 
                   ", 最后访问时间=" + new java.util.Date(session.getLastAccessedTime()));
    }
}