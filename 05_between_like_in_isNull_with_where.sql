-- between & liek & in & is null 연산자 활용하기

-- between 연산자 활용(이상, 이하의 조건에서만 사용가능 / 초과, 미만은 불가)
-- 가격이 5000원 이상 9000원 이하인 메뉴 전체 컬럼 조회
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price > 5000
   AND menu_price < 9000;
   
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price BETWEEN 5000 AND 9000; -- AND 연산자를 사용한 것 보다 간단하게 작성 가능
 
-- 반대의 범위로 테스트
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price < 5000
    OR menu_price > 9000;
   
SELECT
		 *
  FROM tbl_menu
 WHERE menu_price NOT BETWEEN 5000 AND 9000;
--  WHERE NOT menu_price BETWEEN 5000 AND 9000; -- not의 위치는 커럼명 앞뒤로 가능

-- like 연산자 활용
-- 메뉴 중에 '밥'이 들어간 메뉴 조회
SELECT
		 *
  FROM tbl_menu
 WHERE menu_name LIKE '%밥%'; -- 해당 값이 포함된 값을 검색할 때에는 앞뒤로 '%'를 붙여준다.
 
-- 메뉴 중에 '밥'이 들어간 메뉴 제외하고 조회
SELECT
		 *
  FROM tbl_menu
 WHERE menu_name NOT LIKE '%밥%';

-- ----------------------------------------------
-- in 연산자

-- 카테고리 코드가 중식, 커피, 기타인 메뉴 조회(OR 사용)
SELECT * FROM tbl_category; -- 중식: 5, 커피: 8, 기타: 10번

SELECT
		 *
  FROM tbl_menu
 WHERE category_code = 5
 	 OR category_code = 8
 	 OR category_code = 10
 ORDER BY category_code;
 
-- 카테고리 코드가 중식, 커피, 기타인 메뉴 조회(in 사용)
-- IN은 OR을 여러개 사용해야 할 때 사용하면 간단하게 작성 가능
SELECT
		 *
  FROM tbl_menu
 WHERE category_code IN (5, 8, 10)
 ORDER BY category_code;
 
-- ---------------------------------------------------
-- IS NULL 연산자 활용 (null을 조회할 때 사용)
SELECT * FROM tbl_category;

-- ref_category_code(상위 카테고리 번호)가 없는 카테고리 조회
SELECT
		 *
  FROM tbl_category
 WHERE ref_category_code IS NULL;
 
-- 반대의 경우
SELECT
		 *
  FROM tbl_category
 WHERE ref_category_code IS NOT NULL; --  not의 위치 확인!
--  WHERE NOT ref_category_code IS NULL; --  not의 위치 확인!


