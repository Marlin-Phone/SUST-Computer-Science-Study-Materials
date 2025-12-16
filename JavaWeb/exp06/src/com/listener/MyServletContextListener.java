package com.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.*;
import java.util.Properties;
import java.io.*;

@WebListener
public class MyServletContextListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        Properties props = new Properties();
        String configPath = context.getRealPath("/WEB-INF/classes/db_config.properties");
        String url = null;
        String user = null;
        
        try (InputStream input = new FileInputStream(configPath)) {
            props.load(input);
            
            url = props.getProperty("db.url");
            user = props.getProperty("db.user");
            String password = props.getProperty("db.password");
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(url, user, password);
            
            context.setAttribute("dataSource", connection);
            context.log("Web应用启动：已创建数据库连接并保存到ServletContext中");
            
        } catch (IOException e) {
            context.log("配置文件加载失败: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            context.log("JDBC驱动加载失败: " + e.getMessage());
        } catch (SQLException e) {
            context.log("数据库连接失败: " + e.getMessage());
            context.log("连接URL: " + url);
            context.log("用户名: " + user);
        }
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        Connection connection = (Connection) context.getAttribute("dataSource");
        if (connection != null) {
            try {
                connection.close();
                context.removeAttribute("dataSource");
                context.log("Web应用销毁：已关闭数据库连接并从ServletContext中移除");
            } catch (SQLException e) {
                context.log("关闭数据库连接时发生错误：" + e.getMessage());
            }
        }
    }
}