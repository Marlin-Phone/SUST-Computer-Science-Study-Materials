package com.demo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShowHeadersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set response content type and encoding
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Output HTML page
        out.println("<html>");
        out.println("<head>");
        out.println("<title>HTTP Headers Information</title>");
        out.println("<style>");
        out.println("table { border-collapse: collapse; width: 100%; }");
        out.println("th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }");
        out.println("th { background-color: #f2f2f2; }");
        out.println("</style>");
        out.println("</head>");
        out.println("<body>");
        out.println("<h2>All HTTP Headers</h2>");
        out.println("<table>");
        out.println("<tr><th>Header Name</th><th>Header Value</th></tr>");

        // Get all header names
        Enumeration<String> headerNames = request.getHeaderNames();

        // Iterate through all headers
        while (headerNames.hasMoreElements()) {
            String headerName = headerNames.nextElement();
            String headerValue = request.getHeader(headerName);

            out.println("<tr>");
            out.println("<td>" + headerName + "</td>");
            out.println("<td>" + headerValue + "</td>");
            out.println("</tr>");
        }

        out.println("</table>");
        out.println("<p><a href='input.html'>Back to Home</a></p>");
        out.println("</body>");
        out.println("</html>");
    }
}