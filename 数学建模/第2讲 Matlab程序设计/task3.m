function isLeap = task3(year)
% project1.m: 判断某一年是否为闰年
% 输入: year - 一个整数年份
% 输出: isLeap - 逻辑值，true为闰年，false为平年

if mod(year, 4) == 0 && mod(year, 100) ~= 0 || mod(year, 400) == 0
    isLeap = true;
else
    isLeap = false;
end

% 在命令行窗口中调用此函数进行测试：
% >> project1(2000)
% ans =
%   logical
%    1
% >> project1(1900)
% ans =
%   logical
%    0
% >> project1(2024)
% ans =
%   logical
%    1