SELECT
		 menu_code
	  , menu_name
	FROM tbl_menu;
	
-- 	해당 쿼리의 실행 순서
-- 	1. FROM tbl_menu
-- 	2. SELECT 문 
	
-- 	tbl_menu가 가진 행의 개수 만큼 SELECT문이 실행된다.
	
DESC tbl_category;

SELECT
		 category_code
	  , category_name
	  , ref_category_code
	FROM tbl_category;
	
SELECT
	  	 menu_name
	  , category_name
	FROM tbl_menu a
	JOIN tbl_category b ON (a.category_code = b.category_code);
	
-- ----------------------------------------------------------------------
-- from 절이 없는 select 해보기
SELECT 7 + 3;
SELECT 10 * 2;
SELECT 6 % 3, 6 % 4;
SELECT NOW(); -- 현재 시간 출력
SELECT CONCAT('유', ' ', '관순'); -- selct '유 관순' 과 동일한 결과값 출력

-- 별칭 달아보기(AS)
SELECT 7 + 3 AS '합', 10 * 2 '곱';
SELECT 7 + 3 합, 10 * 2 곱;
SELECT 7 + 3 '합 입니다.', 10 * 2 '곱 입니다.';
SELECT 7 + 3  AS  '합 입니다.', 10 * 2 AS '곱 입니다.';
SELECT NOW() AS '현재 시간';

-- 특수 기호가 들어간 별칭은 싱클 쿼테이션(')이 반드시 필요하다.
-- ex) SELECT 7 + 3  합 입니다., 10 * 2 곱 입니다.; -> 오류 발생
-- 연산과 별칭의 구분을 확실히 하기 위해 AS 를 붙여주는것이 가장 좋다.

-- ----------------------------------------------------------------------

-- SELECT문 개인 연습

