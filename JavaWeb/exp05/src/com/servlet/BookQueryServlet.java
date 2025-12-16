package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import com.beans.BookBean;
import com.dao.BookDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class BookQueryServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        
        BookDAO bookDAO = new BookDAO();
        List<BookBean> books = bookDAO.searchBooks(title, author);
        
        request.setAttribute("books", books);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/display.jsp");
        dispatcher.forward(request, response);
    }
}