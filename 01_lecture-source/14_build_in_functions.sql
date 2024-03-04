-- build in functions
-- MySQL 은 문자열, 숫자, 날짜, 시간에 관한 다양한 작업 수행에 많은
-- 내장 함수를 제공하고 있다.

-- concat(문자열 1, 문자열2, ...)
-- concat_ws(구분자, 문자열 1, 문자열 2, ...)

SELECT CONCAT('호랑이','기린','토끼');
SELECT CONCAT_WS('-','2024','03','04');

-- elt : 해당 위치의 문자열 반환
-- field : 찾을 문자열 위치 반환
-- find_in_set : 찾을 문자열의 위치 반환
-- instr : 기준 문자열에서 부분 문자열의 시작 위치 반환
-- locate : instr 과 동일하고 순서만 반대

SELECT ELT(2,'사과','딸기','바나나'),
		 FIELD('딸기','사과','딸기','바나나'),
		 FIND_IN_SET('바나나','사과,딸기,바나나'),
		 INSTR('사과딸기바나나','딸기'),
		 LOCATE('딸기','사과딸기바나나');
		 
-- format(숫자,소수점 자리수)
-- 1000 단위마다 콤마(,) 표시를 해주며 소수점 아래 자릿수 까지 반올림 표현한다.
SELECT FORMAT(1232133123.1323131313131,3);

-- insert(기준 문자열, 위치, 길이, 삽입할 문자열)
SELECT INSERT('내 이름은 아무개 입니다.',7,3,'김유운재' );

-- left, right
-- left : 왼쪽에서 문자열의 길이만큼을 반환
-- right : 오른쪼겡서 문자열의 길이만큼을 반환

SELECT LEFT('Hello World!',4), RIGHT('Hello World!',6);

-- upper , lower
SELECT UPPER('Hello World!'), LOWER('Hello World!');

-- lpad(문자열, 길이, 채울 문자열), rpad(문자열, 길이, 채울 문자열)
-- 문자열을 길이만큼 왼쪽으로 늘린 후에 빈 곳을 문자열로 채운다.
SELECT LPAD('왼쪽',6,'@'), RPAD('오른쪽',6,'@');

-- ltrim(문자열), rtrim(문자열)
-- 왼쪽 공백 제거, 오른쪽 공백 제거
SELECT LTRIM('        왼쪽');
SELECT RTRIM('오른쪽      ');

-- trim(문자열), trim(방향 자를문자열 from 문자열 )
-- 방향 : leading (앞), both(양쪽), trailing(뒤) 
--        해당 방향에 대한 지정한 문자열을 제거할 수 있다.
SELECT TRIM(BOTH '@' FROM '@@@@MYSQL@@@@@@@@@@');

-- repeat (문자열, 횟수), replace(문자열, 찾을 문자열, 바꿀 문자열),
--	reverse(문자열)
SELECT REPLACE('마이SQL','마이','MY');

-- substring(문자열,시작위치,길이)
-- 시작 위치부터 길이 만큼의 문자를 반환
-- (길이를 생략하면 시작 위치부터 끝까지 반환)
SELECT SUBSTRING('안녕하세요 반갑습니다.',7,2),
		 SUBSTRING('안녕하세요 반갑습니다.',7);
		 
-- substring_index(문자열, 구분자, 횟수)
-- 구분자가 왼쪽부터 횟수 번째 나오면 그 이후의 오른쪽은 버린다.
-- 횟수가 음수일 떄는 오른쪽 부터 세고(뒤부터 세고) 왼쪽을 버린다.
SELECT SUBSTRING_INDEX('hong.test@gmail.com','.',-2);

-- 수학 관련 함수
-- abs(숫자) : 절댓값 반환
SELECT ABS(-1234);


