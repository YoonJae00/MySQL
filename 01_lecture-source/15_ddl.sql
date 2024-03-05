-- DDL(Data Definition Language)
-- DDL 은 데이터베이스의 스키마(테이블)를 정의하거나 수정하는데 사용되는
-- SQL 의 한 부분이다.

-- 1-1 create
-- 테이블 생성을 위한 구문
-- if not exists 를 적용하면 기존에 존재하는 테이블이라도
-- 에러가 발생하지 않는다.

-- 테이블의 컬럼 설정 방법  [] : 없어도 됨.
-- 컬럼이름 데이터타입(길이) [not null] [default value] [auto_increment] colum_contraint;

-- tb1 예시 테이블 생성하기
CREATE TABLE if NOT EXISTS tb1 (
	pk INT PRIMARY KEY,
	fk INT,
	col1 VARCHAR(255),
	CHECK(col1 IN ('Y','N'))
) ENGINE = INNODB;
-- ENGINE = INNODB : 테이블을 innodb 라고 불리는 스토리지 엔진으로 생성하겠다는 의미
--						 : (mysql 에서 가장 많이 쓰임)

DESCRIBE tb1;

INSERT INTO tb1 VALUES(1,10,'Y');	-- null 불가 auto_increment 사용안함

SELECT * FROM tb1;

-- auto_increment
-- insert 시 primary 키에 해당하는 컬럼에 자동으로 번호를 발생(중복되지 않게)
-- 시켜 저장할 수 있다.


CREATE TABLE if NOT EXISTS tb2 (
	pk INT AUTO_INCREMENT PRIMARY KEY,
	fk INT,
	col1 VARCHAR(255),
	CHECK(col1 IN ('Y','N'))
) ENGINE = INNODB;

DESCRIBE tb2;

INSERT INTO tb2 VALUES(NULL,20,'N');	-- null 가능
INSERT INTO tb2 VALUES(NULL,20,'N');

SELECT * FROM tb2;

-- alter
-- 테이블에 추가/변경/수정/삭제 하는 모든 것은 alter 명령어를 사용하여 적용한다.

-- 열 추가
-- alter table 태이블명 add 컬럼명 컬럼정의
-- tb2 테이블에 col2 라는 컬럼 추가(int 형, not null 제약조건 존재)

ALTER TABLE tb2
ADD col2 INT NOT NULL;

DESCRIBE tb2;

-- 열 삭제
-- alter table 테이블명 drop column 컬럼명
-- col2 컬럼 삭제
ALTER TABLE tb2
DROP COLUMN col2;

DESCRIBE tb2;

-- 열 이름 및 데이터 형식 변경
-- alter table 테이블명 change column 기존컬럼명 바꿀컬럼명 컬럼정의
-- fk -> change_fk 컬럼으로 변경 not null 조건

ALTER TABLE tb2
CHANGE COLUMN fk change_fk INT NOT NULL;

DESCRIBE tb2;

-- 열 제약 조건 추가 및 삭제
-- alter table 테이블명 drop 제약조건
-- tb2 테이블의 primary key 제약조건 제거

ALTER TABLE tb2
DROP PRIMARY KEY;

-- auto_increment 가 걸려 있는 컬럼은 primary key 제거가 안된다.
-- 따라서 modify 명령어로 제거한다.

ALTER TABLE tb2
MODIFY pk INT;

DESCRIBE tb2;

-- 수정 후 primary key 삭제
ALTER TABLE tb2
DROP PRIMARY KEY;

DESCRIBE tb2;

-- tb2 테이블의 pk 컬럼에 primary key 추가하기
-- add
ALTER TABLE tb2
ADD PRIMARY KEY(pk);

DESCRIBE tb2;

-- 컬럼 여러 개 추가하기
ALTER TABLE tb2
ADD col3 DATE NOT NULL,
ADD col4 TINYINT NOT NULL;

-- date 형이 추가가 안 되는 것은 MySQL 이 5.7 버전 이후 0으로 채워진 date
-- 컬럼이 존재하면 안 되기 때문이다. (막아 놓음)

SELECT @@GLOBAL.sql_mode;

DESCRIBE tb2;

-- drop
-- 테이블을 삭제하기 위한 구문
CREATE TABLE if NOT EXISTS tb3 (
	pk INT AUTO_INCREMENT PRIMARY KEY,
	fk INT,
	col1 VARCHAR(255),
	CHECK(col1 IN ('Y','N'))
) ENGINE = INNODB;

-- drop table tb3
DROP TABLE if EXISTS tb3;

DROP TABLE if EXISTS tb1,tb2;

-- truncate
-- 논리적으로는 where 절이 없는 delete 구문과 큰 차이가 없어 보인다.
-- 하지만 어차피 데이터를 다 삭제할 경우 행마다 하나씩 지워지는
-- delete 보다 drop 이후 바로 테이블을 재생성 해주는 truncate 가
-- 훨씬 효율적으로 한 번에 테이블을 초기화 시켜준다.

CREATE TABLE if NOT EXISTS tb1 (
	pk INT AUTO_INCREMENT PRIMARY KEY,
	fk INT,
	col1 VARCHAR(255),
	CHECK(col1 IN ('Y','N'))
) ENGINE = INNODB;

INSERT INTO tb1 VALUES (NULL,10,'Y');
INSERT INTO tb1 VALUES (NULL,20,'Y');
INSERT INTO tb1 VALUES (NULL,30,'Y');
INSERT INTO tb1 VALUES (NULL,40,'Y');

SELECT * FROM tb1;

-- 테이블 초기화
-- TRUNCATE TABLE tb1;
TRUNCATE tb1;	-- table 키워드 생략 가능

