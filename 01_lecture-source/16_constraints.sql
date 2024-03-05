-- constraints
-- 제약조건으로 테이블에 데이터가 입력되거나 수정될 떄의
-- 규칙을 정의한다.

-- 1-1. not null
-- null 값을 허용하지 않는 제약조건

DROP TABLE if EXISTS user_notnull;
CREATE TABLE if not exists user_notnull (
	user_no INT NOT NULL,
	user_id VARCHAR(255) NOT NULL,
	user_pwd VARCHAR(255) NOT NULL,
	user_name VARCHAR(255) NOT NULL,
	gender VARCHAR(3),
	phone VARCHAR(255) NOT NULL,
	email VARCHAR(255)
)ENGINE = INNODB;

DESCRIBE user_notnull;

INSERT INTO user_notnull
(user_no,user_id,user_pwd,user_name,gender,phone,email)
VALUES
(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@gmail.com'),
(2,'user02','pass02','유관순','여','010-1256-1234','yu123@gmail.com'),
(3,'user03','pass03','김윤재','남','010-1234-1212','yoon123@gmail.com');

SELECT * FROM user_notnull;

-- unique
-- 중복값을 허용하지 않는 제약조건

DROP TABLE if EXISTS user_unique;
CREATE TABLE if not exists user_unique (
	-- user_no INT PRIMARY KEY,	-- primary key
	user_no INT,
	user_id VARCHAR(255) NOT NULL,
	user_pwd VARCHAR(255) NOT NULL,
	user_name VARCHAR(255) NOT NULL,
	gender VARCHAR(3),
	phone VARCHAR(255) NOT NULL,
	email VARCHAR(255),
	UNIQUE(phone)  -- 맨위나 이거나 둘다 가능
)ENGINE = INNODB;

-- not null 조건과 unique 조건을 합친 것이 primary key 라는 것이다.
DESCRIBE user_unique;

INSERT INTO user_unique
(user_no,user_id,user_pwd,user_name,gender,phone,email)
VALUES
(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@gmail.com'),
(2,'user02','pass02','유관순','여','010-1256-1234','yu123@gmail.com'),
(3,'user03','pass03','김윤재','남','010-1234-1212','yoon123@gmail.com');
SELECT * FROM user_unique;

-- uniqie 제약조건 에러 (전화번호 중복 값 적용)
INSERT INTO user_unique
(user_no,user_id,user_pwd,user_name,gender,phone,email)
VALUES
(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@gmail.com');

-- primary key
-- 테이블에서의 한 행의 정보를 찾기 위해 사용 할 컬럼을 의미한다.
-- 테이블에 대한 식별자 역할을 한다. (한 행씩 구분하는 역할)
-- not null + unique 제약조건의 의미
-- 한 테이블 당 1개만 설정이 가능하다.
-- 컬럼레벨, 테이블 레벨 둘 다 설정이 가능하다.
-- 한 개 컬럼에 설정할 수도 있고 여러 개를 묶어서 설정할 수도 있다(복합키)

CREATE TABLE if not exists user_primary (
	-- user_no INT PRIMARY KEY,	-- primary key
	user_no INT,
	user_id VARCHAR(255) NOT NULL,
	user_pwd VARCHAR(255) NOT NULL,
	user_name VARCHAR(255) NOT NULL,
	gender VARCHAR(3),
	phone VARCHAR(255) NOT NULL,
	email VARCHAR(255),
	PRIMARY KEY(user_no),
)ENGINE = INNODB;

DESCRIBE user_primary;

INSERT INTO user_primary
(user_no,user_id,user_pwd,user_name,gender,phone,email)
VALUES
(1,'user01','pass01','홍길동','남','010-1234-5678','hong123@gmail.com'),
(2,'user02','pass02','유관순','여','010-1256-1234','yu123@gmail.com'),
(3,'user03','pass03','김윤재','남','010-1234-1212','yoon123@gmail.com');

SELECT * FROM user_primary;
-- not null 적용확인
INSERT INTO user_primary
(user_no,user_id,user_pwd,user_name,gender,phone,email)
VALUES
(NULL,'user01','pass01','홍길동','남','010-1234-5678','hong123@gmail.com');
-- unique 확인
INSERT INTO user_primary
(user_no,user_id,user_pwd,user_name,gender,phone,email)
VALUES
(4,'user01','pass01','홍길동','남','010-1234-5378','hong123@gmail.com');

-- foregin key
-- 참조 된 다른 테이블에서 제공하는 값만 사용할 수 있다.
-- foregin key 제약조건에 의해 테이블 간의 관계(relationship)가 형성 된다.
-- 제공되는 값 외에는 null 을 사용할 수 있다.

-- 부모 테이블
DROP TABLE if EXISTS user_grade;
CREATE TABLE if NOT EXISTS user_grade (
	grade_code INT NOT NULL UNIQUE,	-- primary
	grade_name VARCHAR(255) NOT null
) ENGINE = INNODB;

DESCRIBE user_grade;

INSERT INTO user_grade
VALUES
(10,'일반회원'),
(20,'우수회원'),
(30,'특별회원');

SELECT * FROM user_grade;

-- 자식 테이블
DROP TABLE if EXISTS user_foreignkey1;

CREATE TABLE if not exists user_foreignkey1 (
	user_no INT PRIMARY KEY,	-- primary key
	user_id VARCHAR(255) NOT NULL,
	user_pwd VARCHAR(255) NOT NULL,
	user_name VARCHAR(255) NOT NULL,
	gender VARCHAR(3),
	phone VARCHAR(255) NOT NULL,
	email VARCHAR(255),
	grade_code INT,
	FOREIGN KEY(grade_code)	REFERENCES user_grade(grade_code)
)ENGINE = INNODB;

DESCRIBE user_foreignkey1;

INSERT INTO user_foreignkey1
(user_no,user_id,user_pwd,user_name,gender,phone,email,grade_code)
VALUES
-- (1,'user01','pass01','홍길동','남','010-1234-5678','hong123@gmail.com'),
-- (2,'user02','pass02','유관순','여','010-1256-1234','yu123@gmail.com'),
(3,'user03','pass03','유관순1','여','010-1256-1234','yu123@gmail.com',10),
(4,'user04','pass04','유관순2','여','010-1256-1234','yu123@gmail.com',20);


SELECT * FROM user_foreignkey1;
SELECT * FROM user_grade;

INSERT INTO user_foreignkey1
(user_no,user_id,user_pwd,user_name,gender,phone,email,grade_code)
VALUES
(5,'user05','pass05','유관순3','여','010-1256-1234','yu123@gmail.com',30);

-- check
-- check 제약 조건 : 위반 시 허용하지 않는다.
DROP TABLE if EXISTS user_check;
CREATE TABLE if NOT EXISTS user_check (
	user_no INT AUTO_INCREMENT PRIMARY KEY,
	user_name VARCHAR(255) NOT NULL,
	gender VARCHAR(3) CHECK (gender IN ('남','여')),
	age INT CHECK(age >= 19)
) ENGINE = INNODB;

DESCRIBE USER_check;

INSERT INTO user_check
VALUES
(NULL,'홍길동','남',25),
(NULL,'이순신','남',33);

-- check 제약조건 성별 위반
INSERT INTO user_check
VALUES
(NULL,'홍길동','남성',25);

-- check 제약조건 나이 위반
INSERT INTO user_check
VALUES
(NULL,'홍길동','남',17);

-- default
-- 컬럼에 null 대신 기본값을 적용
-- date
-- 컬럼 타입이 date 일 시 current_date 만 가능
-- 컬럼 타입이 datetime 일 시 current_time 과 current_timestamp, now() 모두 사용 가능

DROP TABLE if EXISTS tbl_country;
CREATE TABLE if NOT EXISTS tbl_country (
	country_code INT AUTO_INCREMENT PRIMARY KEY,
	country_name VARCHAR(255) DEFAULT '한국',
	population VARCHAR(255) DEFAULT '0명',
	add_day DATE DEFAULT (CURRENT_DATE),
	add_time DATETIME DEFAULT (CURRENT_TIME)
) ENGINE = INNODB;
DESCRIBE tbl_country;
SELECT * FROM tbl_country;

-- default 설정이 되어있는 컬럼들에 default 값이 들어갈 수 있도록 한다.
INSERT INTO tbl_country
VALUES (NULL,DEFAULT,DEFAULT,DEFAULT,DEFAULT);

SELECT * FROM tbl_country;