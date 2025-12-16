package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.util.Random;

public class GuessNumberServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(true);
        
        // 显示会话信息
        out.println("<html><head><title>猜数游戏</title></head><body>");
        out.println("<h2>猜数游戏</h2>");
        out.println("<p><strong>会话ID：</strong>" + session.getId() + "</p>");
        
        // 生成1-100的随机数并保存到session中
        Integer randomNumber = (Integer) session.getAttribute("randomNumber");
        if (randomNumber == null) {
            randomNumber = new Random().nextInt(100) + 1;
            session.setAttribute("randomNumber", randomNumber);
            out.println("<p>我已经想好了一个1到100之间的数字，请你猜猜是多少？</p>");
        } else {
            out.println("<p>继续猜数游戏</p>");
        }
        
        // 显示猜数表单
        out.println("<form method='post' action='guessNumber'>");
        out.println("<label>请输入你猜的数字：</label>");
        out.println("<input type='number' name='guess' min='1' max='100' required>");
        out.println("<input type='submit' value='提交'>");
        out.println("</form>");
        
        out.println("</body></html>");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(true);
        
        // 获取用户输入的数字
        String guessStr = request.getParameter("guess");
        int guess = Integer.parseInt(guessStr);
        
        // 获取session中的随机数
        Integer randomNumber = (Integer) session.getAttribute("randomNumber");
        
        out.println("<html><head><title>猜数游戏结果</title></head><body>");
        out.println("<h2>猜数游戏结果</h2>");
        
        if (guess == randomNumber) {
            // 猜对了
            out.println("<p style='color:green;'>恭喜你，猜对了！数字就是 " + randomNumber + "</p>");
            out.println("<p>游戏结束，会话已终止。</p>");
            
            // 强制结束会话
            session.invalidate();
            
            // 提供重新开始游戏的链接
            out.println("<p><a href='guessNumber'>重新开始游戏</a></p>");
        } else {
            // 猜错了
            if (guess > randomNumber) {
                out.println("<p style='color:red;'>你猜的数字太大了！</p>");
            } else {
                out.println("<p style='color:red;'>你猜的数字太小了！</p>");
            }
            
            // 显示继续猜数的表单
            out.println("<form method='post' action='guessNumber'>");
            out.println("<label>请再猜一次：</label>");
            out.println("<input type='number' name='guess' min='1' max='100' required>");
            out.println("<input type='submit' value='提交'>");
            out.println("</form>");
        }
        
        out.println("</body></html>");
    }
}