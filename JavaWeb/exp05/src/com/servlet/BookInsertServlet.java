package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import com.beans.BookBean;
import com.dao.BookDAO;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class BookInsertServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String bookId = request.getParameter("bookId");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        double price = Double.parseDouble(request.getParameter("price"));
        String publisher = request.getParameter("publisher");
        
        BookBean book = new BookBean(bookId, title, author, price, publisher);
        
        BookDAO bookDAO = new BookDAO();
        boolean success = bookDAO.insertBook(book);
        
        if (success) {
            response.sendRedirect("display.jsp");
        } else {
            response.sendRedirect("errorPage.jsp");
        }
    }
}