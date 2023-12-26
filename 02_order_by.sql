SELECT
	    menu_code
	  , menu_name
	  , menu_price
	FROM tbl_menu
-- ORDER BY menu_price ASC; -- ascending: 오름차순, descending: 내림차순
  ORDER BY menu_price; -- 옵션을 생략하면 기본값은 오름차순 정렬
 
-- 내림차순 정렬
SELECT
		 menu_code
	  , menu_name
	  , menu_price
	FROM tbl_menu
  ORDER BY menu_price DESC;

-- 컬럼의 순번을 활용한 정렬(실제 테이블의 순서가 아닌 조회할 때의 컬럼 순서 기준)
SELECT
		 menu_price  -- 1번째
	  , menu_name   -- 2번째
	FROM tbl_menu
  ORDER BY 1 ASC;

-- 별칭을 활용한 청렬
SELECT
		 menu_code AS 'mc'
	  , menu_price AS 'mp'
	  , menu_name AS 'mn'
	FROM tbl_menu
  ORDER BY mn DESC; -- 별칭으로 정렬할 때는 별칭 명에 single quatation(')을 붙이면 안된다.

-- 컬럼의 복수개로 정렬
SELECT
		 menu_price
	  , menu_name
	FROM tbl_menu
  ORDER BY 2 DESC, 1 ASC;
 -- ,를 기준으로 가장 앞의 옵션(가격으로 내림차순)을 기준으로 첫번째 정렬이된 후
 -- 같은 가격인 경우 두번 째 정렬 옵션(이름으로 오름차순)을 적용한다.
 
 
-- -------------------------------------------------------
-- Field 함수
SELECT FIELD('a', 'b', 'z', 'a');
	-- Field는 첫번째 인자가 뒤에 오는 인자중 몇번째에 오는지 찾아주는 함수이다.
	-- 해당 코드의 결과는 3이 나온다.
SELECT FIELD('z', 'c', 'd', 'a');

-- table에서 조회 시 field 활용
SELECT
		 FIELD(orderable_status, 'N', 'Y') -- orderable_status에는 각 행의 데이터값(=컬럼 값)이 치환되어 들어간다.
	  , orderable_status
	  , menu_name
	  , menu_code
	FROM tbl_menu;
--  해당 코드는
	
-- field를 활용한 order by
SELECT
		 menu_name
	  , orderable_status
	FROM tbl_menu
  ORDER BY FIELD(orderable_status, 'N', 'Y') ASC;
 
-- null 값에 대한 정렬
SELECT
		 * 					-- 모든 컬럼에 대한 값을 조회하면 자동으로 NULL값에 대해 정렬되어 오름차순으로 나온다.
	FROM tbl_category;
	
--  1) 오름차순 시: NULL 값이 가장 먼저 나옴
SELECT
		 *
	FROM tbl_category
 ORDER BY ref_category_code ASC;  
 
--  2) 내림차순 시: NULL 값이 나중에 나옴
SELECT
		 *
	FROM tbl_category
 ORDER BY ref_category_code DESC;

--  3) 오름차순에서 NULL값이 나중에 오게 하기
SELECT
		 *
	FROM tbl_category
 ORDER BY -ref_category_code DESC;  -- DESC를 통해 NULL을 나중에 보낸 후 -> 인자 앞의 -로 null이 아닌 값을 ASC로 바꿈

--  4) 내림차순에서 NULL값이 처음에 오게 하기
SELECT
		 *
	FROM tbl_category
 ORDER BY -ref_category_code ASC; -- 인자 앞에 -를 붙이면 NULL값을 제외한 값이 입력한 옵션(ASC)과 반대로 정렬됨.