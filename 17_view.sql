-- VIEW -- 
SELECT
       menu_name 
     , menu_price
  FROM tbl_menu;
  
CREATE OR REPLACE VIEW v_menu
AS
SELECT
       menu_name  '메뉴이름'
     , menu_price '메뉴가격'
  FROM tbl_menu;
  
SELECT 메뉴이름 FROM v_menu; -- 뷰 생성 시 별칭으로 생성했다면 뷰를 통한 조회는 별칭으로만 가능하다.

-- 원본인 tbl_menu의 11번 메뉴 가격을 10원으로 수정해보기
UPDATE tbl_menu
   SET menu_price = 10
 WHERE menu_code = 11;
 
-- v_menu(뷰)로 확인해보자
SELECT * FROM v_menu;

-- VIEW를 통한 DML(절대 비추!)  ------------------------
SELECT * FROM tbl_menu;

-- category_code = 4 번만 볼 수 있는 VIEW 생성
CREATE VIEW hansik AS
SELECT 
       menu_code 
     , menu_name
     , menu_price
     , category_code
     , orderable_status
  FROM tbl_menu 
 WHERE category_code = 4;

-- 생성된 VIEW 조회
SELECT * FROM hansik;

-- INSERT INTO hansik VALUES (null, '식혜맛국밥', 5500, 4, 'Y');    -- 에러 발생
INSERT 
  INTO hansik
VALUES (99, '수정과맛국밥', 5500, 4, 'Y');   
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- update 
UPDATE hansik
   SET menu_name = '버터맛국밥', menu_price = 5700 
 WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;

-- delete
DELETE FROM hansik WHERE menu_code = 99;
SELECT * FROM hansik;
SELECT * FROM tbl_menu;