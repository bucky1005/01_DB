-- distinct & limit 연산자 활용하기

-- DISTINCT 연산자 활용
-- 중복된 항목을 제거하고 하나만 보여. 컬럼의 내용을 빠르게 확인할 수 있음
SELECT
		 DISTINCT category_code
  FROM tbl_menu;
  
--   DISTINCT 사용 시에는 일반 컬럼을 사용할 수 없다.(DISTINCT 무의미해지기 때문)
SELECT
		 DISTINCT category_code
-- 		, menu_name -- 얘 불가능, 이걸 쓰면 Distinct가 적용되지 않음.
  FROM tbl_menu;
  
  
-- null 값을 포함한 컬럼의 DISTINCT
SELECT
		 DISTINCT ref_category_code
  FROM tbl_category;
  
-- null을 나중으로 보내는 정렬
SELECT
		DISTINCT ref_category_code
  FROM tbl_category
 ORDER BY 1 DESC;
 
SELECT
		 DISTINCT ref_category_code AS 'rcc'
  FROM tbl_category
 ORDER BY -rcc DESC;
-- 조회를 하는 조건중에 연산이 들어간다면 별칭을 사용하여 정렬하는 것이 좋다.
 
-- 기본 정렬의 개념(순번이나 별칭을 사용하지 않고는 정렬할 수 없다.)은 syntax 에러가 발생한다.
SELECT
		 DISTINCT ref_category_code
  FROM tbl_category
 ORDER BY DISTINCT ref_category_code DESC; -- 에러 발생
 
-- -------------------------------------------------------
-- 아래의 코드는 추천하지 않는 코드
-- 컬럼 두 개 이상도 distinct로 묶을 수는 있지만, 좋은 형태는 아니다. -> 두 컬럼의 값이 모두 중복이 되는 경우에만 제거됨
-- ex) 유관순-A형과 유관순-B형이 있으면 중복제거 x, 반드시 유관순-A형 유관순-A형 처럼 두 컬럼의 값이 모두 중복이되어야 제거
-- 컬럼 두 개 이상부터는 이후 배울 Gropu by절을 통해 중복 제거를 하자.
SELECT
		 DISTINCT category_code, orderable_status
  FROM tbl_menu;
  
-- -------------------------------------------------------------  
-- limit 연산자 활용하기
-- limit 연산자는 보여지는 행의 개수를 제한하는 역할을 함.
-- limit은 select절에 포함되지 않음.
SELECT * FROM tbl_menu;

SELECT
		 *
  FROM tbl_menu
 LIMIT 0,5;  -- (시작 인덱스, 조회할 행의 개수) 0번 인덱스부터 5개를 가져와서 보여준다.
 
SELECT
		 *
  FROM tbl_menu
 LIMIT 5, 5;
 
SELECT
		 *
  FROM tbl_menu
 LIMIT 10, 5;
 
-- limit의 offset 생략 시
SELECT
		 *
  FROM tbl_menu;

SELECT
		 *
  FROM tbl_menu
 LIMIT 5;  -- 시작 인덱스를 생략하면 상위 5개를 조회한다.

-- LIMIT을 자주 쓰진 않지만 이후 top-n 분석이나 paging 처리를 할 때 사용된다.