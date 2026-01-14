-- Active: 1746534293683@@127.0.0.1@3306
-- 假设数据库为xscj，表结构：
-- xs_kc表字段：学号, 课程号, 成绩, 开课学期
-- xsqk表字段：学号, 专业, 其他信息
-- kc表字段：课程号, 学分, 开课学期

USE xscj;

-- a.在XS_KC表中，统计每门课程的平均分数，并显示详细信息
SELECT 
    课程号, 
    AVG(成绩) AS 平均成绩
FROM 
    xs_kc
GROUP BY 
    课程号;

-- b.在XS_KC表中统计每个学生的选修课程的门数，并显示总学分
-- 假设需要查询每个学生的学号、选修课程门数、总学分
SELECT 
    学号,
    COUNT(课程号) AS 选修课程门数, 
    SUM(学分) AS 总学分
FROM 
    XS_KC
GROUP BY 
    学号;

-- c.统计XSQK表中各专业学生总学分，并显示详细信息
-- 先通过连接xs_kc和xsqk表，再按专业分组计算总学分
SELECT xsqk.专业名, SUM(
    (
        SELECT 学分
        FROM kc
        WHERE kc.课程号 = xs_kc.课程号
    )
) AS 总学分
FROM xsqk
JOIN xs_kc ON xsqk.学号 = xs_kc.学号
GROUP BY xsqk.专业名;

-- d.按开课学期统计KC表中各学期的学分，并显示明细信息
SELECT 开课学期, SUM(学分) AS 各学期总学分
FROM kc
GROUP BY 开课学期;

-- e.将XS_KC表中的数据记录按学号分类汇总，输出学号和平均分
SELECT 学号, AVG(成绩) AS 平均成绩
FROM XS_KC
GROUP BY 学号;

-- f.查询平均分大于70且小于80的学生学号和平均分
-- 先计算每个学生的平均分，再筛选出符合条件的记录
SELECT 学号, AVG(成绩) AS 平均成绩
FROM xs_kc
GROUP BY 学号
HAVING 平均成绩 > 70 AND 平均成绩 < 80;

-- g.查询XS_KC表，输出学号、课程号、成绩，
-- 并使查询结果首先按照课程号的升序排列，
-- 当课程号相同时再按照成绩降序排列，
-- 并将查询结果保存到新表TEMP_KC中
DROP TABLE IF EXISTS TEMP_KC;
CREATE TABLE TEMP_KC AS
SELECT 学号, 课程号, 成绩
FROM XS_KC
ORDER BY 课程号 ASC, 成绩 DESC;
SELECT * FROM xscj.TEMP_KC;
SHOW TABLES;
-- h.查询选修了“101”课程的学生的最高分和最低分
SELECT MAX(成绩) AS 最高分, MIN(成绩) AS 最低分
FROM xs_kc
WHERE 课程号 = '101';

-- i.统计每个学期所开设的课程门数
SELECT 开课学期, COUNT(课程号) AS 课程门数
FROM kc
GROUP BY 开课学期;

-- j.查询各专业的学生人数
SELECT 专业名, COUNT(学号) AS 学生人数
FROM xsqk
GROUP BY 专业名;

