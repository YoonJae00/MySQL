-- view 

-- cte : 쿼리 내부 (1개의 쿼리문) 에서 with ~ as 절을 사용해서
--			"임시" 로 정의되는 테이블

-- select 쿼리문을 저장한 객체로 가상테이블 이라고 불린다.
-- 실질적인 데이터를 물리적으로 저장하지 않고, 쿼리만 저장했지만,
-- 테이블을 사용하는 것과 동일하게 사용할 수 있다.

-- view 는 데이터를 쉽게 읽고 이해할 수 있도록 돕는 동시에,
-- 원본데이터의 보안을 유지하는데 도움이 된다.
SELECT * FROM tbl_menu;

-- view 생성
CREATE VIEW hansik AS
SELECT menu_code, menu_name, menu_price, category_code, orderable_status
FROM tbl_menu
WHERE category_code = 4;

SELECT * FROM hansik;

-- view 라는 가상의 테이블은 베이스 테이블 (tbl_menu) 의 정보가 변경되면
-- view 의 결과도 같이 변경된다.

INSERT INTO tbl_menu VALUES (NULL, '식혜맛국밥', 5500, 4, 'Y');
SELECT * FROM tbl_menu;
SELECT * FROM hansik;

INSERT INTO hansik VALUES (NULL, '국밥맛식혜', 6000, 4, 'Y');
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

UPDATE hansik
SET menu_name = '버터맛국밥', menu_price = 5500
WHERE menu_code = 23;

SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- view 로 dml 명령어로 조작이 불가능한 경우
-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
-- 2. 뷰에 포함되지 않은 컬럼 중 베이스 테이블 컬럼이 
-- 	not null 제약조건이 지정된 경우
-- 3. 산술표현식이 정의된 경우
-- 4. join 을 이용해 여러 테이블을 연결한 경우
-- 5. distinct 를 포함한 경우
-- 6. 그룹함수(avg,sum 등등) 나 group by 절을 포함한 경우

-- view 삭제
DROP VIEW hansik;