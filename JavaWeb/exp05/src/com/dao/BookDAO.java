package com.dao;

import com.beans.BookBean;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=Asia/Shanghai";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "yourPassword";

    static {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    public List<BookBean> getAllBooks() {
        List<BookBean> books = new ArrayList<>();
        String sql = "SELECT bookid AS bookId, title, author, publisher, price FROM books";
        System.out.println("执行SQL: " + sql);
        
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            System.out.println("获取到结果集");
            int count = 0;
            while (rs.next()) {
                BookBean book = new BookBean();
                book.setBookId(rs.getString("bookId"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setPrice(rs.getDouble("price"));
                books.add(book);
                count++;
                System.out.println("加载图书: " + book.getTitle());
            }
            System.out.println("共加载图书: " + count + " 本");
        } catch (SQLException e) {
            System.err.println("数据库错误: " + e.getMessage());
            e.printStackTrace();
        }
        return books;
    }
    
    // 测试数据库连接的方法
    public static void testConnection() {
        try (Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD)) {
            System.out.println("数据库连接成功!");
            DatabaseMetaData meta = conn.getMetaData();
            System.out.println("数据库产品: " + meta.getDatabaseProductName());
            System.out.println("驱动版本: " + meta.getDriverVersion());
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        testConnection();
    }
    
    public List<BookBean> searchBooks(String title, String author) {
        List<BookBean> books = new ArrayList<>();
        String sql = "SELECT bookid AS bookId, title, author, publisher, price FROM books WHERE title LIKE ? OR author LIKE ?";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, "%" + title + "%");
            stmt.setString(2, "%" + author + "%");
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                BookBean book = new BookBean();
                book.setBookId(rs.getString("bookId"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPublisher(rs.getString("publisher"));
                book.setPrice(rs.getDouble("price"));
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
    public boolean insertBook(BookBean book) {
        String sql = "INSERT INTO books (bookid, title, author, publisher, price) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, book.getBookId());
            stmt.setString(2, book.getTitle());
            stmt.setString(3, book.getAuthor());
            stmt.setString(4, book.getPublisher());
            stmt.setDouble(5, book.getPrice());
            
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}