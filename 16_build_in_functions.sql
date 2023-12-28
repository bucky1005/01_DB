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

-- FORMAT(숫자, 소수점 자릿수)
SELECT FORMAT(123156421,3);

-- BIN(숫자) - 2진수, OCT(숫자) - 8진수, HEX(숫자) - 16진수
SELECT BIN(65), OCT(65), HEX(65);

-- REPEAT(문자열, 횟수)
SELECT repeat('배고파 ', 5);

-- REPLACE(문자열, 찾을 문자열, 바꿀 문자열)
-- 실제 db값은 그대로 두고 조회할 때에만 문자열을 바꿔서 보여줌
SELECT REPLACE('마리아DB', '마리아', 'Maria');

-- REVERSE(문자열)
-- 각각 리터럴이 가진 인덱스를 뒤집어서 문자를 반전 시킴
SELECT REVERSE('happiness');

-- SPACE(길이)
-- 입력한 길이만큼 공백을 만들어줌
SELECT CONCAT('내 포켓몬은', SPACE(3), '이고, 속성은', SPACE(6), '이다.');

-- SUBSTRING(문자열, 시작위치, 길이)
SELECT 
       SUBSTRING('열심히 db 공부를 해 봅시다!', 5, 4)
	  , SUBSTRING('열심히 db 공부를 해 봅 시다!',11); -- 11번째 문자부터 끝까지


-- SUBSTRING_INDEX(문자열, 시작위치, 길이)
-- -가 붙으면 오른쪽에서부터
SELECT
       SUBSTRING_index('010-123-1234', '-', 2)
     , SUBSTRING_index('010-123-1234', '-', -1);
     
-- 2. 숫자 관련 함수 ----------------------------
-- ABS(숫자) 절댓값
SELECT ABS(-123);

-- celing(숫자) - 올림, floor(숫자) - 버림, round(숫자) 반올림
SELECT CEILING(1234.56), FLOOR(1234.56), ROUND(1234.56);

-- conv(숫자, 원래 진수, 변환할 진수)
SELECT CONV('A',16,10), CONV('A', 16, 2);

-- mod(숫자1, 숫자2)
SELECT MOD(10, 3), 10%3;

-- pow(숫자1, 숫자2), sqrt(숫자)
SELECT POW(3,2), SQRT(81);

-- RAND()
-- RAND() * 생성할 난수 개수 + 난수의 초기값
SELECT FLOOR(RAND() * 6 + 5), FLOOR(RAND() * 6) + 5;

-- sign(숫자)
SELECT SIGN(10.1), SIGN(0), SIGN(-1.1);

-- truncate(숫자, 정수)
-- 소수점 몇번째 자리까지 남길 것인지 선택
-- 음수는 소수점은 버리고 숫자만큼 0으로 채움
SELECT TRUNCATE(12345.12345, 2), TRUNCATE(12345.12345, -2);

-- 3. 날짜 및 시간 관련 함수 ----------------------------
-- ADDDATE(날짜, 차이), SUBDATE(날짜, 차이)
-- adddate: 기준 날짜에서 차이 날짜만큼 더했을 때의 날짜를 알려줌
-- subdate: 기준 날짜에서 차이 날짜만큼 뺐을 때의 날짜를 알려줌
SELECT ADDDATE('2020-02-01', INTERVAL 28 DAY);
SELECT ADDDATE(CURRENT_DATE, 120); -- interval과 day 빼도 정상 동작

SELECT SUBDATE('2020-02-01', INTERVAL 1 MONTH); -- 월, 연 기준으로 계산할 때에는 interval과 month or year를 생략하면 오류
SELECT SUBDATE(CURRENT_DATE, 40);

-- ADDTIME(날짜/시간, 시간), SUBTIME(날짜/시간, 시간)
SELECT ADDTIME('2023-12-18 10:27:00', '1:0:10'), SUBTIME('2023-12-18 10:27:00', '1:0:10');
SELECT ADDTIME(NOW(), '1:0:0');

-- CURDATE(), CURTIME(), NOW(), SYSDATE()
-- curdate: current date
-- curtime: current time
-- now: 현재 날짜와 시간
-- sysdate: 시스템의 날짜와 시간
SELECT CURDATE(), CURTIME(), NOW(), SYSDATE();

SELECT CURTIME(), CURRENT_TIME(), CURRENT_TIME;

SELECT @@GLOBAL.time_zone; -- 현재 타임존 기준을 확인하는 조회문

-- YEAR(날짜), MONTH(날짜), DAY(날짜)
-- 입력된 날짜의 연, 월, 일을 추출하는 함수
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAY(CURDATE()), DAY(CAST('2023-12-28' AS DATE));
SELECT HOUR(CURTIME()), MINUTE(CURTIME()), SECOND(CURTIME());

-- DATE(날짜/시간), TIME(날짜/시간)
SELECT DATE(NOW()), TIME(NOW());

-- DATEDIFF(날짜1, 날짜2), TIMEDIFF(날짜 (or 시간1), 날짜2 (or 시간2))
-- 디데이 계산
SELECT concat(DATEDIFF('2024-06-14', NOW()), '일'), TIMEDIFF('18:00:00', CURTIME());

-- DAYOFWEEK(날짜), MONTHNAME(날짜), DAYOFYEAR(날짜)
SELECT DAYOFWEEK(CURDATE()), MONTHNAME(CURDATE()), DAYOFYEAR(CURDATE());

-- LAST_DAY(날짜)
-- 입력한 날짜에 해당하는 달의 마지막 일을 추출
SELECT LAST_DAY('20230401');

-- MAKEDATE(연도, 지난 날)
SELECT MAKEDATE(2023, 35);

-- MAKETIME(시, 분, 초)
SELECT MAKETIME(17, 50, 01);

-- QUATER(날짜)
SELECT QUATER('2023-12-28');

-- TIME_TO_SEC(시간)
-- 오늘 자정부터 흐른 시간이 얼마나 되는지 초(s)로 계산해줌
SELECT TIME_TO_SEC(CURTIME());