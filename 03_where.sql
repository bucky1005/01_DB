-- orderable_status = 'N'인 행을 조회하기
-- = 주문 불가능한 메뉴 조회(메뉴명, 메뉴코드)
SELECT
		 menu_name
	  , menu_price
-- 	  , orderable_status -- 쿼리가 잘 조회되는지 확인 후 요청자에게 필요하지 않은 컬럼은  주석처리한 것
	FROM tbl_menu
  WHERE orderable_status = 'N';
  
--  해당 쿼리의 실행 순서
--  1. FROM 절 -> 해당 테이블을 찾아감
--  2. WHERE 절 -> 그 테이블의 특정 컬럼의 값이 'Y'와 동일하면
--  3. SELECT 절 -> SELECT 절을 수행, 다를경우 수행하지 않음

-- 해당 테이블이 가진 컬럼명을 빠르게 확인
DESC tbl_menu;
DESC tbl_category;

-- 테이블안의 데이터값들을 빠르게 확인
SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;
 
-- ----------------------------------------------------
-- '기타' 카테고리에 해당하지 않는 메뉴를 조회하시오.

-- 1) '기타' 카테고리의 번호 파악하기
SELECT * FROM tbl_category WHERE category_name = '기타';

-- 2) 해당 번호를 가지지 않는 메뉴 조회하기
SELECT * FROM tbl_menu WHERE category_code != 10; -- '!='는 '<>'로 바꾸어 쓸 수 있음


-- 추가 실습
-- '한식' 카테고리에 해당하지 않는 메뉴 조회

-- 1) '한식' 카테고리 번호 파악하기
SELECT * FROM tbl_category WHERE category_name = '한식';

-- 2) '한식' 카테고리를 제외한 메뉴 조회
SELECT * FROM tbl_menu; -- tbl_category와 연결된 컬럼명을 조회

SELECT * FROM tbl_menu WHERE category_code = 4;
SELECT * FROM tbl_menu WHERE category_code != 4 ORDER BY category_code;
-- -----------------------------------------------------
-- 10,000원 이상의 메뉴 조회
SELECT * FROM tbl_menu WHERE menu_price >= 10000;

-- 10.000원 미만의 메뉴 조회
SELECT * FROM tbl_menu WHERE menu_price < 10000;

-- 10,000원 이상 12,000원 이하의 메뉴 조회
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price >= 10000
   AND menu_price <= 12000; -- 'AND'를 '&&'로 바꾸어 쓸 수 있음. (&&는 Ansi 표준에 해당하지 않으므로 MySQL은 불가)

-- 논리 연산자 예제

-- [AND 예제] 놀이공원에서 특정 놀이기구는 7세 이상이면서 100cm 이상의 조건을 동시에 만족해야 탑승 가능
SELECT
		 *
  FROM nephew
 WHERE age >= 7
   AND height >= 100;
   
-- [OR 예제] 버스 탑승자 중 7세 미만의 유아 또는 65세 이상의 노인은 요금 무료
SELECT
		 *
  FROM customer
 WHERE age < 7
   AND age >= 65;