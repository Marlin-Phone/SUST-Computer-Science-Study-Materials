-- 新建数据库与表
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARSET = utf8mb4;
USE demo_db;
CREATE TABLE IF NOT EXISTS users (
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(50) NOT NULL,
email VARCHAR(100) DEFAULT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- 插入几条测试数据
INSERT INTO users (username, email) VALUES
('zhangsan', 'zhangsan@example.com'),
('lisi', 'lisi@example.com');
-- 简单查询
SELECT id, username, email, created_at FROM users;