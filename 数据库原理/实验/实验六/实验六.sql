USE xscj;

-- CREATE VIEW

CREATE VIEW v_开课信息 AS
SELECT 课程号, 课程名, 开课学期, 学时
FROM kc
WHERE 开课学期 >= 3;

SELECT *
FROM v_开课信息;

-- INSERT

INSERT INTO v_开课信息
VALUES ('003', '概率论', 3, 80);

SELECT *
FROM v_开课信息;
SELECT *
FROM kc;

-- UPDATE
UPDATE v_开课信息
SET 开课学期 = 5, 学时 = 100
WHERE 课程号 = '003';

SELECT *
FROM v_开课信息;
SELECT *
FROM kc;

-- DELETE
DELETE FROM v_开课信息
WHERE 课程号 = '003';

SELECT *
FROM v_开课信息;

SELECT *
FROM kc;