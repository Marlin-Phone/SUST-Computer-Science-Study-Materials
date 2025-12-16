package com.beans;

public class BookBean {
    private String bookId;
    private String title;
    private String author;
    private double price;
    private String publisher;

    public BookBean() {
    }

    public BookBean(String bookId, String title, String author, double price, String publisher) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.price = price;
        this.publisher = publisher;
    }

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
}