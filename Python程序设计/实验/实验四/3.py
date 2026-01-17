# 数据库的查询操作
import sqlite3
# 连接数据库
con = sqlite3.connect(r"D:\code\Python\实验四\sales.db")
# 查询数据库表的记录内容
cur = con.execute("SELECT id, name from region")
for row in cur: # 遍历查询结果
    print(row)
con.close()