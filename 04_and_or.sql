-- AND, OR 연산자

-- SELECT * FROM tbl_category; -- category_code
-- SELECT * FROM tbl_menu;

-- ------------------------------------------------
-- 주문이 가능하거나 카테고리 번호가 10번인 메뉴 출력
SELECT
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu -- ; 뒤에 ';'를 붙여서 해당 테이블의 내용을 빠르게 확인 후 작업하는 경우도 많음
 WHERE menu_price > 5000
    OR category_code = 10;
    
-- 주문이 가능하고 카테고리 번호가 10번인 메뉴 출력
SELECT
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price > 5000
   AND category_code = 10;