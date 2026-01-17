# 数据库表的插入,更新和删除操作
import sqlite3
regions = [("021", "上海"),('022',"天津"),("023", "重庆"),("024","沈阳")]
# 打开SQLite数据库
con = sqlite3.connect("D:\\code\\Python\\实验四\\sales.db")
# 使用不同的方法分别插入一行数据
con.execute("INSERT INTO region(id, name) values ('020','广东')")
con.execute("INSERT INTO region(id, name) values (?,?)", ('001','北京'))
# 插入多行数据
con.executemany("INSERT INTO region(id, name) values (?,?)", regions)
# 修改一行数据
n = con.execute("UPDATE region SET name = ? where id = ?", ('广州','020'))
# 删除一行数据
con.execute("DELETE FROM region WHERE id = ?", ('024',))
print("删除了", n.rowcount, "行记录")
con.commit() # 提交事务
con.close() # 关闭数据库连接