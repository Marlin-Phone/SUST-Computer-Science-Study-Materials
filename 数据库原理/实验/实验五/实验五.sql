SHOW DATABASES;
USE xscj;

INSERT INTO xscj.xs_kc (学号, 课程号, 成绩, 学分) VALUES
('101101', '302', 59, 3),
('101101', '301', 58, 3);
-- a.查询不及格学生的学号、课程名、授课教师、开课学期的信息
SELECT 学号, 课程名, 授课教师, 开课学期
FROM xs_kc
JOIN kc ON kc.课程号 = xs_kc.课程号
WHERE 成绩 < 60;

-- b.按学号分组汇总总分高于100的学生记录，并按总分的降序排列
SELECT 学号, SUM(成绩) AS 总分
FROM xs_kc
GROUP BY 学号
HAVING SUM(成绩) > 100
ORDER BY SUM(成绩) DESC;

-- c.使用子查询求恰好有两门课程不及格的学生信息
SELECT xsqk.*
FROM xsqk
WHERE xsqk.学号 IN (
    SELECT 学号
    FROM xs_kc
    WHERE 成绩 < 60
    GROUP BY 学号
    HAVING COUNT(*) = 2
);

-- d.使用子查询查询每门课程的最高分的学生记录
SELECT xsqk.姓名, xs_kc.课程号, xs_kc.成绩 AS 最高分, xs_kc.学号
FROM xs_kc
JOIN xsqk ON xsqk.学号 = xs_kc.学号
JOIN (
    SELECT 课程号, MAX(成绩) AS 最高分
    FROM xs_kc
    GROUP BY 课程号
) AS temp ON xs_kc.课程号 = temp.课程号 AND xs_kc.成绩 = temp.最高分;

-- e.使用子查询查询每个学生的最低分的课程记录
SELECT xsqk.姓名, xs_kc.学号, xs_kc.课程号, xs_kc.成绩 AS 最低分
FROM xs_kc
JOIN xsqk ON xsqk.学号 = xs_kc.学号
JOIN (
    SELECT MIN(成绩) AS 最低分, 学号
    FROM xs_kc
    GROUP BY 学号
) AS temp ON xs_kc.成绩 = temp.最低分 AND xs_kc.学号 = temp.学号;