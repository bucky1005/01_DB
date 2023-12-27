-- Data Type --

-- 1. 명시적 형변환  ---------------------
SELECT AVG(menu_prcie) FROM tbl_menu;

-- 1) 숫자 -> 숫자 변환
-- 소수점에서 반올림해 정수까지 변환
SELECT CAST(AVG(menu_price) AS UNSIGNED INTEGER) AS '가격평균' FROM tbl_menu;

-- 소수점 이하 한자리까지 변환
SELECT CAST(AVG(menu_price) AS FLOAT) AS '가격평균' FROM tbl_menu;

-- 소수점 이하 12자리 까지 변환
SELECT CAST(AVG(menu_priee) AS DOUBLE) AS '가격평균' FROM tbl_menu;

-- 2) 문자 -> 날짜
-- 2023년 12월 27일을 date형으로 변환
SELECT CAST('2023$12$27' AS DATE);
SELECT CONVERT('2023/12/27', DATE);
SELECT CONVERT('2023-12-27', DATE);
SELECT CONVERT('2023#12#27', DATE);

-- 3) 숫자 -> 문자
SELECT CONCAT(CAST(1000 AS CHAR), '원');


-- 2. 암시적 형변환 ---------------------
-- 연산자 사용 시 자동 형변환이 되는데 주의해야 한다.
-- -> 암시적 형변환이 일어나는 경우에도 꼭 cast를 사용하여 명시적 형변환으로 타입을 바꿀 것
SELECT 1 + '2';  -- 결과값: 3
SELECT '1' + '2';  -- 결과값: 3

-- 문자열 끼리 합치고 싶을 때에는 CONCAT을 사용
SELECT CONCAT('1', '2'); -- 결과값: 12

-- 모든 문자는 산술연살 또는 비교 연산을 만나면 0이 된다.
SELECT '안녕' + '하세요'; -- 결과값: 0
SELECT 5 > '반가워';  -- 결과값: 1 (= true)