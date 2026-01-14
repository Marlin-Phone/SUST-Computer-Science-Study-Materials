-- a
SELECT 课程名, 授课教师
FROM KC;

-- b
SELECT 姓名, 联系电话
FROM XSQK
WHERE 性别 = '女';

-- c
SELECT 学号, 课程号, 成绩
FROM XS_KC
WHERE 成绩 > 80;

-- d
SELECT *
FROM XS_KC
WHERE 成绩 > 80 OR 成绩 < 60;

-- e 查询不在1980年7、8、9月出生的学生信息
SELECT *
FROM XSQK
WHERE 出生日期 NOT BETWEEN '1980-07-01' AND '1980-09-30';

INSERT INTO XSQK VALUE ('114514', '陈明', '男', '1980-07-01', '电子信息与人工智能学院','13811111111', '计算机', '50', '为了完成这个查询添加的人');

-- f
SELECT *
FROM XSQK
WHERE 姓名 LIKE('陈_');

-- g
SELECT *
FROM XSQK 
WHERE 学号 LIKE('%1%');

INSERT INTO xsqk VALUE ('191981', '陈小明', '男', '1981-01-01', '电子信息与人工智能学院', '13811141112', '计算机', '50', '为了完成这个查询添加的人')   

-- h 查询电话号码第7位为4和6的记录信息
SELECT *
FROM XSQK
WHERE 联系电话 LIKE('______4%') OR 联系电话 LIKE('______6%');

-- i
SELECT *
FROM KC
WHERE 开课学期 IN(1, 3, 5);

-- j
SELECT 学号, 姓名, 出生日期
FROM XSQK
ORDER BY 出生日期 ASC;