-- MySQL 8.0 schema for CookieShop (goods, `order`, orderitem, recommend, type, `user`)
-- Charset: utf8mb4, Collation: utf8mb4_0900_ai_ci
-- Safe to run on a clean database. If re-running, drop existing tables or import CookieShop/cookieshop-mysql8.0.sql directly.

-- 1) Create database (optional)
-- CREATE DATABASE IF NOT EXISTS cookieshop CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
-- USE cookieshop;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- Table: type (product categories)
DROP TABLE IF EXISTS `type`;
CREATE TABLE `type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_type_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: user (customers/admins)
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `name` VARCHAR(45) DEFAULT NULL,
  `phone` VARCHAR(45) DEFAULT NULL,
  `address` VARCHAR(200) DEFAULT NULL,
  `isadmin` BIT(1) NOT NULL DEFAULT b'0',
  `isvalidate` BIT(1) NOT NULL DEFAULT b'0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_user_username` (`username`),
  UNIQUE KEY `uk_user_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: goods (products)
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `cover` VARCHAR(255) DEFAULT NULL,
  `image1` VARCHAR(255) DEFAULT NULL,
  `image2` VARCHAR(255) DEFAULT NULL,
  `price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `intro` VARCHAR(500) DEFAULT NULL,
  `stock` INT NOT NULL DEFAULT 0,
  `type_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_goods_type_id` (`type_id`),
  CONSTRAINT `fk_goods_type` FOREIGN KEY (`type_id`) REFERENCES `type` (`id`)
    ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: order (orders header)
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `total` DECIMAL(12,2) NOT NULL DEFAULT 0.00,
  `amount` INT NOT NULL DEFAULT 0,
  `status` TINYINT NOT NULL DEFAULT 1,   -- 1未付款/2已付款/3已发货/4已完成
  `paytype` TINYINT NOT NULL DEFAULT 1,  -- 1微信/2支付宝/3货到付款
  `name` VARCHAR(45) DEFAULT NULL,
  `phone` VARCHAR(45) DEFAULT NULL,
  `address` VARCHAR(200) DEFAULT NULL,
  `datetime` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_order_user_id` (`user_id`),
  KEY `idx_order_status` (`status`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
    ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: orderitem (orders detail lines)
DROP TABLE IF EXISTS `orderitem`;
CREATE TABLE `orderitem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `price` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  `amount` INT NOT NULL DEFAULT 1,
  `goods_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_orderitem_order_id` (`order_id`),
  KEY `idx_orderitem_goods_id` (`goods_id`),
  CONSTRAINT `fk_orderitem_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT `fk_orderitem_goods` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`)
    ON UPDATE RESTRICT ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table: recommend (home page recommendations)
DROP TABLE IF EXISTS `recommend`;
CREATE TABLE `recommend` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` TINYINT NOT NULL, -- 1条幅 2热销 3新品
  `goods_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_recommend_goods_id` (`goods_id`),
  KEY `idx_recommend_type` (`type`),
  CONSTRAINT `fk_recommend_goods` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`)
    ON UPDATE RESTRICT ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET FOREIGN_KEY_CHECKS = 1;
