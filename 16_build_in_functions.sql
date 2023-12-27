-- BUILD IN FUNCTIONS --
-- 시험 출제

-- 1. 문자열 관련 함수 ----------------------------
-- ASCII(아스키 코드), char(숫자)
SELECT ASCII('a'), CHAR(97);

-- bit_length(문자열), char_length(문자열), length(문자열)
-- 영어, 숫자, 특수기호 제외 한 문자당 3byte 할당
SELECT
       BIT_LENGTH('한글')
     , CHAR_LENGTH('한글')
     , LENGTH('한글');
     
-- concat(문자열1, 문자열2, ..., 문자열n) & concat_ws(구분자, 문자열1, 문자열2, ...)
-- 숫자는 우측 정렬, 문자는 좌측 정렬
SELECT CONCAT('nice', 'to', 'meet', 'you');
SELECT CONCAT_WS(' ', 'nice', 'to', 'meet', 'you');
SELECT concat(cast(menu_price AS CHAR), '원') FROM tbl_menu;

-- ELT(위치, 문자열1, 문자열2, ...) & FIELD(찾을 문자열, 문자열1, 문자열2, ...)
-- FIND_IN_SET(찾을 문자열, 문자열 리스트) & INSTR(기준 문자열, 부분 문자열)
-- LOCATE(부분 문자열, 기준 문자열)
SELECT
       ELT(2, '축구', '야구', '농구')
     , FIELD('축구', '야구', '농구', '축구')
     , FIND_IN_SET('축구', '야구,농구,축구')
     , INSTR('축구농구야구', '농구')
     , LOCATE('야구', '축구농구야구'); -- instr과 locate는 서로 인자가 반대
     
-- INSERT(기준 문자열, 위치, 삭제할 길이, 삽입할 문자열)
SELECT INSERT('가랏 피카츄!', 4, 3, '파이리');
SELECT INSERT('가랏 피카츄!', 4, 2, '파이리');
SELECT INSERT('가랏 꼬부기!', 4, 1, '피츄');

-- LEFT(문자열, 길이) & RIGHT(문자열, 길이)
SELECT LEFT('Hello world!', 5), RIGHT('Nice to meet you!', 4);

-- UPPER(문자열) & LOWER(문자열)
SELECT LOWER('Hello World!'), UPPER('Nice to meet you!');

-- LPAD(문자열, 길이, 채울 문자열)
SELECT LPAD('왼쪽', 5, '@'), RPAD('오른쪽', 6, '^');

-- LTRIM(문자열) & RTRIM(문자열)
-- TRIM(문자열)  & TRIM(방향, 자를_문자열, FROM 문자열)
SELECT LTRIM('                  왼쪽 공백 제거'), RTRIM('오른쪽 공백 제거                  ');
SELECT TRIM('          MariaDB             ')
	  , TRIM(BOTH '@' FROM '@@@@MariaDB@@@@')
	  , TRIM(LEADING '@' FROM '@@@@MariaDB@@@@')  -- leading: 왼쪽으로 끌고감(= LTRIM)
	  , TRIM(TRAILING '@' FROM '@@@@MariaDB@@@@'); -- trailing: 오른쪽으로 끌고감 (= RTRIM)

SELECT CONCAT_WS(' ',menu_name, '의 가격은', menu_price, '입니다') FROM tbl_menu;

-- 2. 숫자 관련 함수 ----------------------------

-- 3. 날짜 및 시간 관련 함수 ----------------------------

