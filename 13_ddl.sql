-- DDL -- 

-- 1. Create
CREATE TABLE if NOT EXISTS tbl (
  pk INT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

DESC tbl;

INSERT
  INTO tbl
VALUES
(
  3, 5, 'n'
);

SELECT * FROM tbl;

-- n을 소문자로 넣어서 대문자로 변경
UPDATE tbl
   SET col1 = 'N'
 WHERE pk = 3;
 
-- 1-1. tb2 생성(auto increment 사용)
CREATE TABLE if NOT EXISTS tb2 (
  pk INT PRIMARY KEY AUTO_INCREMENT, -- auto increment는 Primary key인 컬럼에만 설정가능
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

DESC tb2;

INSERT
  INTO tb2
VALUES
(
  NULL, 2, 'Y'
);

INSERT
  INTO tb2
VALUES
( NULL, 3, 'N' ),
( NULL, 4, 'Y' );

SELECT * FROM tb2;

-- 2. ALTER
-- 2-1) 컬럼 추가
ALTER TABLE tb2 ADD col2 INT NOT NULL;

DESC tb2;

-- 2-2) 컬럼 삭제
ALTER TABLE tb2 DROP COLUMN col2;

DESC tb2;

-- 2-3) 컬럼 변경(이름 및 정의 변경)
ALTER TABLE tb2
CHANGE COLUMN fk change_fk INT NOT NULL;

DESC tb2;

-- 2-4) 제약조건 제거
ALTER TABLE tb2 DROP PRIMARY KEY;  -- auto increment가 달려있으면 삭제 불가

-- auto increment 제거
ALTER TABLE tb2 MODIFY pk INT;

-- primary key 다시 제거
ALTER TABLE tb2 DROP PRIMARY KEY;

DESC tb2;

-- 3.Drop (노션 예제 보기)

-- 4. Truncate

-- 테이블 생성
CREATE TABLE if NOT EXISTS tb3 (
  pk INT AUTO_INCREMENT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN ('Y', 'N'))
) ENGINE=INNODB;

-- 데이터 삽입
INSERT
  INTO tb3
VALUES
( NULL, 10, 'Y' ),
( NULL, 20, 'Y' ),
( NULL, 30, 'Y' ),
( NULL, 40, 'Y' );

SELECT * FROM tb3;

TRUNCATE tb3;