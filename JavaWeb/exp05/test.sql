CREATE DATABASE test;

USE test;

CREATE TABLE books (
    bookid VARCHAR(10) NOT NULL PRIMARY KEY,
    title VARCHAR(50),
    author VARCHAR(20),
    publisher VARCHAR(40),
    price FLOAT 
);

insert into books (bookid, title, author, publisher, price)
values
    ('204', 'Head First Servlets & JSP', 'Bryan Basham', '中国电力出版社', 98),
    ('201', 'Servlets 与 JSP 核心课程', 'hall Marty', '清华大学出版社', 45),
    ('202', 'Tomcat 与 Java Web 开发技术详解', '孙卫琴', '机械工业出版社', 45),
    ('203', 'JSP 应用开发技术', '柳永坡', '人民邮电出版社', 52),
    ('205', 'J2EE 1.4 编程指南', 'Spielman Sue', '电子工业出版社', 68);

SELECT * FROM books;

-- 添加customer表结构
CREATE TABLE customer (
    custName VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL PRIMARY KEY,
    phone VARCHAR(20) NOT NULL
);

-- 插入示例客户数据
INSERT INTO customer (custName, email, phone)
VALUES
    ('张三', 'zhangsan@example.com', '13800138000'),
    ('李四', 'lisi@example.com', '13900139000');

SELECT * FROM customer;

SELECT * FROM books;

DELETE FROM books WHERE bookid = '1';

DESC test.customer;