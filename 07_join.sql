-- Join 활용하기
-- Join은 From절의 일부이다.
-- 따라서 실제 모습은 아래와 같은 형태이지만 가독성을 위해 엔터로 구분한다.
SELECT
		 *
  FROM tbl_menu JOIN tbl_category ON tbl_menu.category_code = tbl_category.category_code;
  
-- 내가 조회하고자 하는 테이블에 필요한 다른 테이블의 컬럼을 조인으로 붙임
-- 따라서 내가 조회하고자 하는 테이블을 기준으로 조인된 다른 컬럼도 정렬됨

-- 조인 할 두 테이블 각각 전체 조회
SELECT
		 *
  FROM tbl_menu;

SELECT
		 *
  FROM tbl_category;

-- 메뉴명과 카테고리명만 조회
SELECT
		 menu_name
	  , category_name
  FROM tbl_menu
  JOIN tbl_category ON (tbl_menu.category_code = tbl_category.category_code); -- ON 뒤에는 조인의 조건을 적어줌.
  
-- 테이블 명에도 별칭(alias) 가능
SELECT
		 menu_name
	  , category_name
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code); -- 조건을 매우 간단하게 표현 가능

-- 두 테이블에 같은 컬럼명이 있는 상태에서 조인 시 유의할 점
SELECT
		 menu_name
	  , category_name
  FROM tbl_menu a
  JOIN tbl_category b ON (category_code = category_code);
  -- 조건에서 테이블명을 명시하지 않고 컬럼명만 입력한 경우 ambiguous error 발생
  -- 컬럼명이 다르다면 정상 동작하지만 컬럼명이 동일하다면 구분되지 않으므로 반드시 테이블명(별칭)을 명시해야 한다.
  
SELECT
		 menu_name
	  , category_name
	  , a.category_code  -- 조인으로 묶인 두 테이블이  동일한 컬럼을 가진경우 조회할 컬럼도 반드시 별칭을 명시해주어야 한다.
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code);
  
-- 관례상 join시에는 쿼리에 사용되는 모든 컬럼에 별칭을 다는 것을 원칙으로 한다.
-- 겹치지 않는 컬럼명은 별칭을 달지 않아도 동작은 하지만 혼동 방지를 위해 모든 컬럼에 명시한다.
SELECT
		 a.menu_name
	  , b.category_name
	  , b.category_code
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code)
 WHERE a.category_code = 8;
  
-- 테이블 명에 별칭을 달 때에는 순서대로 a, b, c, d ... 의 순서로 별칭을 하는 것이 가장 좋다.

-- -------------------------------------------------------------
-- 1) INNER JOIN: ON 또는 USING 뒤에 오는 JOIN 조건을 만족하여 매칭되는 결과물만 JOIN 함
SELECT
		 *
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code)
 WHERE b.category_code = 7; -- 7번에 상응하는 메뉴 테이블의 내용이 존재하지 않으므로 조회 결과 없음

-- 2) LEFT JOIN: join 키워드를 기준으로 왼쪽 테이블은 관계 유무에 상관없이 모두 나오도록 join
UPDATE tbl_menu
	SET category_code
 WHERE menu_code = 1;
 
DESC tbl_menu;
 
-- 3) RIGHT JOIN: join 키워드를 기준으로 오른쪽 테이블의 행이 모두 나오도록 join
SELECT
		 *
  FROM tbl_menu a
  JOIN tbl_category b USING (category_code);
  
SELECT
  FROM tbl_menu a
 RIGHT JOIN tbl_category b USING (category_code);

-- 4) CROSS JOIN: 매칭될 수 있는 모든 조건에 대해 join이 발생함. 주로 조건을 잘못 썼을 경우 cross join이 발생.
SELECT
		 *
  FROM tbl_menu a
  JOIN tbl_category b ON (1=1);  -- 조건이 항상 true이므로 모든 행에 대하여 cross join됨
  
SELECT
		 *
  FROM tbl_menu a
 CROSS JOIN tbl_category b;

-- 5) self JOIN: 자기 자신을 참조하여 조인하는 것. 한 테이블에 상위 하위의 개념이 존재하게됨
-- self join은 하나의 테이블에 상위 개념과 하위 개념이 모두 들어있을 때 자기 자신 테이블을 join하게 되는 경우에 사용한다.
-- ex) 신입사원 - 사수 / 하위 카테고리 - 상위 카테고리 / 댓글 - 대댓글 등
SELECT 
		 *
  FROM tbl_category;
  
SELECT
		 a.category_name
	  , b.category_name
  FROM tbl_category a
  JOIN tbl_category b ON (a.ref_category_code = b.category_code);

USE menudb;
SELECT * FROM tbl_category;
SELECT * FROM tbl_menu;