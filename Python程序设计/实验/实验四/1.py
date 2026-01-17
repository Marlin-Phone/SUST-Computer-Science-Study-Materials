# 创建数据库和表
import sqlite3
# 创建SQLite数据库:D:\code\Python\实验四\sales.db
con = sqlite3.connect("D:\code\Python\实验四\sales.db")
# 创建表regions,包含id(主码)和name两个列
con.execute("create table region(id primary key, name)")

con.close()