-- DML(데이터 조작어) --

-- 1. INSERT(테이블에 행 추가하기)
DESC tbl_menu;
SELECT * FROM tbl_category;

INSERT
  INTO tbl_menu
(
  menu_code
, menu_name
, menu_price
, category_code
, orderable_status
)
VALUES
(
  NULL
, '바나나해장국'
, 8500
, 4
, 'Y'
);

SELECT * FROM tbl_menu ORDER BY 1 DESC; -- 추가한 행 확인하기

-- 2. DELETE(행 삭제하기) 
DELETE
  FROM tbl_menu
 WHERE menu_code = 22; -- where절에 조건을 쓰지 않으면 모든 행이 삭제 되므로 주의할 것(update도 마찬가지임)
 
-- 이후 다시 insert 하면 auto increment에 의해 menu_code는 23번부터 삽입됨

-- 3. UPDATE(행 내용 변경하기)
UPDATE tbl_menu
   SET menu_name = '딸기해장국', menu_price = 8000
 WHERE menu_code = 23;
 
-- ------------------------------------------------------------------
INSERT
  INTO tbl_menu
(
  menu_code, menu_name, menu_price
, category_code, orderable_status
)
VALUES
(
  17, '아샷추매운탕', 9000 -- menu_code에서 17번은 이미 존재하므로 primary key 조건에 위배되어 오류 발생
, 4, 'N'
);

-- 위 구문의 오류 수정
REPLACE  -- replace를 사용하면 기존의 menu_code가 17번인 행의 내용을 교체한다.
  INTO tbl_menu
(
  menu_code, menu_name, menu_price
, category_code, orderable_status
)
VALUES
(
  17, '아샷추매운탕', 9000
, 4, 'N'
);

SELECT * FROM tbl_menu WHERE menu_code = 17;