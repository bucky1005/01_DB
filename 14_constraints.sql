-- CONSTRAINTS --
-- 연습 시 데이터 삽입할 때 제약조건에 걸리도록 삽입 후 오류 메세지 확인하기

-- 1.NOT NULL -------------------
DROP TABLE IF EXISTS user_notnull;
CREATE TABLE IF NOT EXISTS user_notnull (
    user_no INT NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255)
) ENGINE=INNODB;

INSERT 
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

-- 이름에 not null 제약조건 에러
INSERT 
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user03', 'pass03', NULL, '남', '010-1234-8878', 'son123@gmail.com'),
(4, 'user04', 'pass04', '유명인', '여', '010-7779-7979', 'yu79@gmail.com');

SELECT * FROM user_notnull;

-- 2. unique -------------------
DROP TABLE IF EXISTS user_unique;
CREATE TABLE IF NOT EXISTS user_unique (
    user_no INT NOT NULL UNIQUE,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    UNIQUE (phone)
) ENGINE=INNODB;

INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

-- phone 컬럼에서 unique 제약조건 에러
INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(4, 'user04', 'pass04', '유명인', '여', '010-777-7777', 'yu79@gmail.com');

SELECT * FROM user_unique;

-- 3. Primary key -------------------
DROP TABLE IF EXISTS user_primarykey;
CREATE TABLE IF NOT EXISTS user_primarykey (
--     user_no INT PRIMARY KEY,
    user_no INT,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    PRIMARY KEY (user_no)
) ENGINE=INNODB;

INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

-- primary key를 동일한 값으로 중복 입력
INSERT 
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(2, 'user03', 'pass03', '손세림', '남', '010-1233-8878', 'son123@gmail.com');

SELECT * FROM user_primarykey;

-- 4.Foreign key -------------------

-- 4-1. 회원등급 -> 부모 테이블 생성(참조될 테이블)
DROP TABLE IF EXISTS user_grade;
CREATE TABLE IF NOT EXISTS user_grade (
    grade_code INT NOT NULL UNIQUE,
    grade_name VARCHAR(255) NOT NULL
) ENGINE=INNODB;

INSERT 
  INTO user_grade
VALUES 
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

SELECT * FROM user_grade;

-- 4-2.회원 -> 자식 테이블 생성(부모를 참조할 테이블)
DROP TABLE IF EXISTS user_foreignkey1;
CREATE TABLE IF NOT EXISTS user_foreignkey1 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT ,
    FOREIGN KEY (grade_code) -- 참조한 값을 내 테이블의 grade_code 컬럼에 연결할 것
		REFERENCES user_grade (grade_code) -- 부모 테이블에 있는 grade_code를 참조할 것
) ENGINE=INNODB;

INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

-- 부모테이블에 없는 회원등급으로 회원 데이터 추가해보기
INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(4, 'user03', 'pass03', '손세림', '남', '010-1233-8878', 'son123@gmail.com', 50);

SELECT * FROM user_foreignkey1;

-- 자식 테이블에서 FOREIGN KEY 제약조건 컬럼 NULL 값으로 INSERT
INSERT 
  INTO user_foreignkey1
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(5, 'user03', 'pass03', '손세림', '남', '010-1233-8878', 'son123@gmail.com', null);

SELECT * FROM user_foreignkey1;

-- 부모 테이블에서 참조중인 값을 삭제/변경 하고자 할 때 오류가 발생하지 않도록 조건 달기
DROP TABLE IF EXISTS user_foreignkey2;
CREATE TABLE IF NOT EXISTS user_foreignkey2 (
    user_no INT PRIMARY KEY,
    user_id VARCHAR(255) NOT NULL,
    user_pwd VARCHAR(255) NOT NULL,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3),
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    grade_code INT ,
    FOREIGN KEY (grade_code) 
		REFERENCES user_grade (grade_code)
        ON UPDATE SET NULL
        ON DELETE SET NULL
) ENGINE=INNODB;

INSERT 
  INTO user_foreignkey2
(user_no, user_id, user_pwd, user_name, gender, phone, email, grade_code)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com', 20);

SELECT * FROM user_foreignkey2;

-- 부모 테이블에서 우수회원 등급 삭제
SELECT * FROM user_grade;
DELETE FROM user_grade WHERE grade_code = 20;  -- 자식테이블1 에는 삭제룰이 적용 되지 않아 삭제가 안됨.

DELETE FROM user_foreignkey1 WHERE 1 = 1; -- user_foreignkey1 테이블의 참조하는 데이터 삭제

SELECT * FROM user_foreignkey2;
DELETE FROM user_grade WHERE grade_code = 20;

-- 부모 테이블에 우수회원 등급 새로 추가 '40'
INSERT
  INTO user_grade
VALUES (40, '에메랄드 회원');

-- null값으로 변화된 자식 테이블의 행들을 새로 추가한 회원등급으로 업데이트
UPDATE user_foreignkey2
   SET grade_code = 40
 WHERE grade_code IS NULL; -- 회원 등급 20이 삭제되고 null로 바뀐 자리를 새로운 등급 40으로 변경

SELECT * FROM user_foreignkey2;

-- 5.CHECK -------------------
DROP TABLE IF EXISTS user_check;
CREATE TABLE IF NOT EXISTS user_check (
    user_no INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(255) NOT NULL,
    gender VARCHAR(3) CHECK(gender IN ('남','여')),
    age INT CHECK (age >= 19)
) ENGINE=INNODB;

INSERT 
  INTO user_check
VALUES 
(null, '홍길동', '남', 25),
(null, '이순신', '남', 33);

-- 성별에 check 제약조건 위배한 데이터 삽입
INSERT 
  INTO user_check
VALUES 
(NULL, '손세림', '중', 25);

-- 나이에 check 제약조건 위배한 데이터 삽입
INSERT 
  INTO user_check
VALUES 
(NULL, '손세림', '중', 16);

SELECT * FROM user_check;

-- 6.DEFAULT
DROP TABLE IF EXISTS tbl_country;
CREATE TABLE IF NOT EXISTS tbl_country (
    country_code INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(255) DEFAULT '한국',
    population VARCHAR(255) DEFAULT '0명',
    add_day DATE DEFAULT (current_date),
    add_time DATETIME DEFAULT (current_time)
) ENGINE=INNODB;

-- default로 insert or update를 하면 default로 초기 세팅된 값으로 적용
INSERT 
  INTO tbl_country
VALUES (null, default, default, default, DEFAULT);

INSERT 
  INTO tbl_country
VALUES (null, null, default, default, DEFAULT);

INSERT 
  INTO tbl_country
VALUES (null, null, null, NULL, 'hi');

SELECT * FROM tbl_country;

-- insert 시 default 설정된 컬럼을 무시하고 insert하면 null이 아닌 default로 초기 세팅된 값이 적용 
INSERT
  INTO tbl_country
(country_code
,country_name)
VALUES
(NULL , '일본');