-- GROUP BY & HAVING & ROLLUP --

-- 조회의 6가지 절을 모두 활용한 예제
-- 1) select: group by 절에서 그룹을 묶는 조건으로 활용한 컬럼만 조회 또는 그룹 함수를 통해 조회
-- 2) from: 테이블 또는 조인을 활용한 result set을 작성한다.
-- 3) where: from 절의 각 행마다 적용될 조건을 작성한다.
-- 4) group by: where 절까지 만족하는 행들에 대해 그룹이 될 컬럼을 작성한다.
-- 5) having: 그룹별로 적용할 조건을 group by 에서 작성한 컬럼
--            또는 그룹 함수를 통해 조회한다.
-- 6) order by: 제일 마지막에 해석되며 select의 결과(result set)의
--              순번, 별칭, 컬럼명 등으로 오름차순 또는 내림차순 한다.

SELECT * FROM tbl_menu;
SELECT * FROM tbl_category;

SELECT
		 category_code
	  , COUNT(*)  -- group by절로 묶인 모든 행의 갯수 세기
	  , COUNT(category_code)  -- category_code가 NULL이 아닌 행만 갯수 세기
	  , SUM(menu_price)
	  , AVG(menu_price)
  FROM tbl_menu
 WHERE category_code IS NOT NULL -- 한 행마다 조건을 걸어줄 때 where 절을 사용 is not null은 null을 제외한 결과만 출력
 GROUP BY category_code
 HAVING SUM(menu_price) >= 24000
 ORDER BY 2;
 
 
-- 1. 실행 순서 ** 중요 **
-- FROM (+ join) -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY (ORDER BY는 항상 마지막에 실행됨)
 
-- 2. group by 절을 할 때에는 여러 컬럼이 조건을 기준으로 묶이기 때문에
-- 조건에 사용한 컬럼을 제외한 다른 컬럼을 조회하면 올바른 결과값을 얻을 수 없음.
-- 따라서 group by 절에서는 그룹을 묶을 조건으로 사용한 컬럼과, 그룹 함수(count, sum, avg 등)만 출력 가능

-- 3. 메뉴가 없는 카테고리까지 셀 것인지 구분해서 count 해보기
SELECT
	    COUNT(*)
	  , COUNT(a.menu_name)
  FROM tbl_menu a
 RIGHT JOIN tbl_category b ON (a.category_code = b.category_code); -- right join: 메뉴가 없는 카테고리 코드까지 전부 포함하도록 함.

-- 4. 함수의 종류
--  1) 단일행 함수: NVL 또는 IFNULL과 같이 단일 행바다 적용되어 행의 갯수만큼 결과가 나오는 경우
--  2) 그룹 함수: count, sum, avg와 같이 그룹마다 적용되어 그룹의 갯수만큼 결과가 나오는 경우(NVL 사용 X)
--                GROUP BY를 적용하지 않은 조회는 전체 테이블을 하나로 간주하여 함수행 결과가 하나이다.

-- ------------------------------------------
-- ROLL UP
-- 중간 합계 및 최종 합계를 도출
-- 5. group by에서 두 개 이상의 컬럼으로 그룹 형성 시
--   앞의 컬럼을 기준으로 중간 합계가 나오게 된다.
SELECT
		 menu_price
	  , category_code
	  , SUM(menu_price)
  FROM tbl_menu
 GROUP BY menu_price, category_code
  WITH ROLLUP;


-- ROLLUP 실습을 위한 테이블 만들기 --
CREATE TABLE sales (
    CODE INT AUTO_INCREMENT,  -- Auto_incement: 내가 추가한 데이터 행의 개수에 따라 자동으로 증가하며 인덱스를 매겨줌.
    YEAR VARCHAR(4),
    MONTH VARCHAR(2),
    product VARCHAR(50),
    amount DECIMAL(10, 2),
    PRIMARY KEY(CODE)
);

INSERT
  INTO sales
(
  CODE, YEAR, MONTH  -- 내용이 세로로 너무 길어지면 3개씩 묶어서 한 줄에 쓰는 것이 좋다.
, product, amount
)
VALUES
(
  NULL, '2023', LPAD('1', 2, '0')  -- '2023'은 문자열 2023은 숫자
, 'Product A', 1000.00
),
(
  NULL, '2023', LPAD('1', 2, '0')  -- LPAD('1', 2, '0'): 첫번째 인자는 넣을 문자, 두번째 인자는 몇자리까지 표시할 지, 세번째 인자는 남는 자리를 어떤 문자로 채울지 적는다.
, 'Product B', 1500.00
),
(
  NULL, '2023', LPAD('2', 2, '0')
, 'Product A', 2000.00
),
(
  NULL, '2023', LPAD('2', 2, '0')
, 'Product B', 2500.00
),
(
  NULL, '2024', LPAD('3', 2, '0')
, 'Product A', 1200.00
),
(
  NULL, '2024', LPAD('3', 2, '0')
, 'Product B', 1700.00
); -- 해당 쿼리를 실행하는 만큼 데이터가 추가됨.

-- 7번 이상의 code값을 가진 항목을 삭제(수동삭제, 권장하지 않는 방법)
-- but, auto_increment에서는 12번까지 생성되었던 index 항목을 저장하고 있기 때문에 
-- 행을 더 추가하면 13번 index부터 생성됨.
DELETE
  FROM sales
 WHERE CODE >= 7; 
 
-- ROLLUP 실습을 위한 테이블 만들기 끝 -- 

SELECT * FROM sales;

SELECT
       year
     , month
     , product
     , SUM(amount) AS total_sales
  FROM sales
 GROUP BY YEAR, MONTH, product
  WITH ROLLUP;