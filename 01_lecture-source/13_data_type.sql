-- 형변환
-- sql 데이터 형변환은 명시적 형변환과 암시적(묵시적) 형변환이 있다.

-- 명시적 형변환 (Explicit Conversion)

-- cast( 표현식 as 데이터형식 [ (길이) ] )
-- convert(표현식, 데이터형식 [ (길이) ] )

-- 데이터 형식으로 가능한 것은 
-- BINARY, CHAR, DATE, DATETIME, JSON, DECIMAL, SIGNED INTEGER
-- TIME, UNSIGNED INTEGER

-- SIGNED : 부호 있는 정수

SELECT AVG(menu_price) FROM tbl_menu;

SELECT CAST( AVG(menu_price) AS SIGNED INTEGER ) FROM tbl_menu;
SELECT CONVERT ( AVG(menu_price), SIGNED INTEGER ) FROM tbl_menu;

SELECT CAST('2024$3$4' AS DATE);
SELECT CAST('2024/3/4' AS DATE);
SELECT CAST('2024%3%4' AS DATE);

-- 메뉴 가격 구하기
SELECT CONCAT(CAST(menu_price AS CHAR(5)), '원')
FROM tbl_menu;

-- 암시적 형변환 (Implicit Conversion)
-- 따로 처리하지 않아도 내부적으로 자동으로 형변환이 이루어진다.

SELECT '1' + '2'; -- 각 문자가 정수로 변환됨.
SELECT CONCAT(menu_price , '원') FROM tbl_menu;	-- menu_price 가 문자로 변환됨
SELECT 3 > 'May'; -- 문자는 0으로 변환됨.

SELECT 5 > '6May';	-- 문자에서 첫번째로 나온 숫자는 정수로 전환된다.
SELECT 5 > 'May6';	-- 숫자가 뒤에 나오면 문자로 인식되어 0으로 변환된다.
SELECT '2023-5-30';	-- 날짜 형으로 바뀔 수 있는 문자들은 DATE 형으로 변환된다.