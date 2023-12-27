-- Transaction --

-- 1.auto commit 비활성화
SET autocommit = 0;

-- 2.Transaction 사용

START TRANSACTION;

INSERT
  INTO tbl_menu
VALUES
(
  NULL, '바나나해장국', 8500
, 4, 'Y'
);

UPDATE tbl_menu
   SET menu_name = '수정된 메뉴1'
 WHERE menu_code = 5;j

UPDATE tbl_menu
   SET menu_name = '수정된 메뉴2'
 WHERE menu_code = 6;

SELECT * FROM tbl_menu;  -- ROLLBACK 전과 후에 실행한 결과가 다르게 나온다.
								 -- ROLLBACK 전: 실제 DB에 적용된 데이터가 아님.
								 -- ROLLBACK or Commit 이후: select 한 값이 실제 DB에 적용된 상태.

COMMIT;
ROLLBACK;