-- SUB QUERIES --
-- : 다른 쿼리 내에서 실행되는 쿼리

-- Ex) (practice계정) 유재식씨의 부서와 같은 부서에서 일하는 직원 --------------------------------
SELECT * FROM employee;

-- 1. 서브쿼리
SELECT dept_code FROM employee WHERE emp_name = '유재식'; -- D6, 해당 쿼리는 메인 쿼리 출력을 위한 서브쿼리

-- 메인쿼리
SELECT * FROM employee WHERE dept_code = 'D6'; -- 유재식씨와 같은 부서에서 일하는 직원(본인 포함)

-- 서브 쿼리를 포함한 메인쿼리
SELECT  -- 메인 쿼리는 select절에서 코드 컨벤션에 따라 엔터를 치고 컬럼을 입력
       *
  FROM employee
 WHERE dept_code = (SELECT dept_code  -- 서브쿼리 일 때에는 select절에서 코드 컨벤션에 따라 컬럼을 옆에다 입력
 						    FROM employee
 						   WHERE emp_name = '유재식');
 						   
-- 이와 같은 방법으로 유재식씨의 사원 번호를 추출하여 해당 사원을 제거하기
SELECT
       *
  FROM employee
 WHERE dept_code = (SELECT dept_code
                      FROM employee
                     WHERE emp_name = '유재식')
   AND emp_id <> (SELECT emp_id
                    FROM employee
                   WHERE emp_name = '유재식');
                   
-- 조회의 결과값으로 나온 테이블을 사용하여 쿼리를 작성하고 싶은 경우
-- from절에 해당 테이블을 조회하는 쿼리를 서브쿼리로 작성한다.(= 인라인 뷰)

-- 2. 상관 서브쿼리 -------------------------------------------------
-- 2-1.(swcamp 계정) 메뉴 조회 시 메뉴의 카테고리에 있는 메뉴들의 평균 가격보다 높은 메뉴만 조회(단일행 서브쿼리)
SELECT
       a.menu_code
     , a.menu_name
     , a.menu_price
     , a.category_code
     , a.orderable_status
  FROM tbl_menu a
 WHERE a.menu_price > (SELECT AVG(b.menu_price) -- 메뉴의 평균을 조회하는 서브쿼리
                         FROM tbl_menu b
                        WHERE b.category_code = a.category_code);
								-- 서브쿼리에서 메인 쿼리에 있는 컬럼값을 활용하였으므로 상관 서브쿼리
								
-- 2-2. group by 절을 활용(상관 서브 쿼리를 사용하지 않은 다중행 서브쿼리) ------
-- 메뉴 카테고리의 평균과 같은 가격인 메뉴
SELECT
       *
  FROM tbl_menu a
 WHERE a.menu_price IN (SELECT AVG(b.menu_price) -- IN: or을 대체할 수 있는 함수. 카테고리별 그룹의 평균값 중 하나만 일치하면 결과값 매칭
                         FROM tbl_menu b
--                         WHERE b.category_code = a.category_code -- 자신의 카테고리와 일치할 때(카테고리가 다른데 평균값만 일치하는 경우를 방지)
                        GROUP BY b.category_code); -- 카테고리 코드 별로 그룹화
                        
-- 질문) *에 모든 컬럼이 포함된다는 뜻인데 왜 상관 서브쿼리가 아닌건지
-- => 서브쿼리의 내용을 독립적으로 실행하였을 때 문제 없이 결과 값이 나온다면 상관 서브쿼리가 아니다.
-- 주로 where절에 메인 쿼리의 컬럼에 쓰인 경우 상관 서브쿼리

-- 3. EXISTS ------------------------------------
-- TRUE FALSE를 판별하여 존재 여부를 출력
-- 메뉴가 있는 카테고리 조회
SELECT
		 category_code
	  , category_name
  FROM tbl_category a
 WHERE EXISTS(SELECT 1
                FROM tbl_menu b
               WHERE b.category_code = a.category_code)
 ORDER BY 1;

-- 4번 카테고리를 메인 쿼리에서 where조건으로 판별 중 동작하는 서브쿼리
SELECT 1
  FROM tbl_menu b
 WHERE b.category_code = 4;
 
-- +) JOIN을 활용한 메뉴가 있는 카테고리 조회 -----------------------------------
-- 3번의 exists를 사용한 예제와 같은 결과값이 나온다.
SELECT
       a.category_Code
     , a.category_name
  FROM tbl_category a
  JOIN tbl_menu b ON (a.category_code = b.category_code)
 GROUP BY a.category_code, a.category_name;


-- 두 테이블을 카테고리 코드로 조인 하게되면 
-- 1. NULL값을 가진 값들은 매칭 조건에 맞지 않아 조회되지 않으므로 메뉴가 있는 카테고리만 조회된다.
-- 2. 같은 카테고리 코드를 가진 메뉴가 여러개이므로 group by절을 사용하여 같은 카테고리 코드를 같인 행들을 묶어준다.


-- 서브쿼리 추가 실습(practice 계정) ----------------------------------------------------
-- 1. 가장 높은 급여를 받는 사원 조회하기(MAX(컬럼명))
SELECT
       *
  FROM employee
 WHERE salary = (SELECT MAX(salary)
                     FROM employee);
                     
-- 2. 평균 급여가 가장 높은 부서 조회하기(AVG(컬럼명), MAX(컬럼명)) -- 반드시 컬럼명이 들어가야함.
-- 연산식은 함수의 인자값에 바로 사용할 수 없으므로, 별칭을 달아 별칭으로 입력해주어야 사용가능.

-- 1)

-- 2) >= ALL 을 활용한 방법
-- 서브 쿼리 중에 다중행 서브쿼리인 경우에는 비교 연산자가 일반 비교연산자와 달라진다.
-- > ALL, < ALL, > ANY, < ANY, IN
-- 1. > ALL: 모든 서브쿼리 결과보다 크다(서브쿼리의 최대값보다 크다)
-- 2. < ALL: 모든 서브쿼리 결과보다 작다(서브쿼리의 최소값보다 작다)
-- 3. > ANY: 서브쿼리 결과 중 최소 하나보다는 크다(서브쿼리의 최소값보다 크다)
-- 4. < ANY: 서브쿼리 결과 중 최대 하나보다는 작다(서브쿼리의 최대값보다 작다)
-- 5. IN: 서브쿼리 결과 중에 하나라도 일치한다.
SELECT
		 dept_code
  FROM employee
 GROUP BY dept_code
HAVING avg(salary) >= ALL (SELECT AVG(salary) -- all: all 뒤에 나오는 다중행의 모든 결과값
                          FROM employee
								 GROUP BY dept_code);
								 

SELECT
       a.dept_code
     , b.dept_title
  FROM employee a
  JOIN department b ON (b.dept_id = a.dept_code)
 GROUP BY a.dept_code
HAVING AVG(a.salary) = (SELECT max(c.sal_avg)
                        FROM (SELECT AVG(salary) sal_avg
                                FROM employee
                               GROUP BY dept_code) c);

-- max(c.sal_avg)  => 별칭을 사용해야 하는 이유
-- (1) SELECT max(c.sal_avg)
-- (2)       FROM (SELECT AVG(salary) sal_avg
-- (3)       FROM employee
-- (4)      GROUP BY dept_code) c);

-- (1)에서 SELECT max(AVG(salary))로 작성하게되면 
-- (2)에서 FROM (SELECT AVG(salary)에서 평균값이 한번 계산 된 후 FROM절의 조건으로 남게되고
-- (2)에서 계산된 평균값이 (1)에서는 연산의 결과값이 아닌 인자값으로 넘어가기 때문에
-- (1)에서 다시한번 평균을 구한 후 MAX값을 구하게된다. => 즉 AVG 연산이 두 번 수행된다.
-- 따라서 반드시 별칭을 설정하여 평균값을 구한 결과를 저장한 후 MAX 연산을 수행해야 한다.

								 
SELECT * FROM employee;

-- AVG, GROUP BY를 사용하여 부서별 평균 급여를 조회하시오
-- 표시 : 부서 이름, 평균 급여
SELECT
       b.DEPT_TITLE
     , AVG(a.salary)
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
 GROUP BY a.dept_code;


-- MAX, MIN, GROUP BY를 사용하여 직급별 가장 높은 급여를 조회하시오
-- 표시 : 직급 이름, 가장 높은 급여, 가장 낮은 급여  
SELECT
       b.JOB_NAME
     , MAX(a.salary)
     , MIN(a.salary)
  FROM employee a
  JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
 GROUP BY a.JOB_CODE;
 
-- 서브쿼리를 사용하여 '송은희'와 같은 직급인 사원들을 조회하시오
-- 표시 : 사원명, 직급 이름, 부서 이름
SELECT
       a.emp_name
     , b.JOB_NAME
     , c.DEPT_TITLE     
  FROM employee a
  JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
  JOIN department c ON (a.DEPT_CODE = c.DEPT_ID)
 WHERE a.job_code = (SELECT d.JOB_CODE
                     FROM employee d
                    WHERE d.emp_name = '송은희');

-- '갈릭미역파르페'와 같은 카테고리 코드를 가진 메뉴들을 조회하여라.
-- 표시 : 메뉴 이름, 카테고리 코드
SELECT
       menu_name
     , category_code
  FROM tbl_menu a
 WHERE category_code = (SELECT category_code
                          FROM tbl_menu
                         WHERE menu_name = '갈릭미역파르페');