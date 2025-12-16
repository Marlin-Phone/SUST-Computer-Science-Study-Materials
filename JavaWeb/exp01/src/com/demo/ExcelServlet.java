package com.demo;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ExcelServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置响应内容类型为Excel文件
        response.setContentType("application/vnd.ms-excel");
        // 设置响应头，指定文件名
        response.setHeader("Content-Disposition", "attachment; filename=\"data.xls\"");

        // 获取输出流
        OutputStream out = response.getOutputStream();

        // 生成简单的Excel数据（CSV格式，Excel可以识别）
        StringBuilder excelData = new StringBuilder();
        excelData.append("姓名\t年龄\t城市\t注册日期\n");
        excelData.append("张三\t25\t北京\t2025-09-23\n");
        excelData.append("李四\t30\t上海\t2025-09-22\n");
        excelData.append("王五\t28\t广州\t2025-09-21\n");
        excelData.append("赵六\t35\t深圳\t2025-09-20\n");
        excelData.append("钱七\t22\t杭州\t2025-09-19\n");

        // 将数据写入输出流
        out.write(excelData.toString().getBytes("UTF-8"));
        out.flush();
        out.close();
    }
}