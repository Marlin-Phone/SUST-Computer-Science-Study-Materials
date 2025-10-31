SELECT * FROM goods;

show DATABASES;

SHOW TABLES;

# 创建管理员账号（数据库端口 3306）
-- mysql -h 127.0.0.1 -P 3306 -u root -p -e "
USE cookieshop;
INSERT INTO user (username, email, password, name, phone, isadmin, isvalidate) 
VALUES ('admin', 'admin@cookieshop.com', '123456', '系统管理员', '13800138000', b'1', b'1')
ON DUPLICATE KEY UPDATE isadmin=b'1', isvalidate=b'1';

SELECT * FROM user WHERE isadmin=b'1';

SELECT * FROM user;