-- Join 미사용 연습 문제
-- 1. 모든 사원 모든 컬럼 조회
SELECT * FROM employee;

-- 2. 사원들의 사번(사원번호), 이름 조회
SELECT
		 emp_id
	  , emp_name
  FROM employee;
  
-- 3. 201번 사번의 사번 및 이름 조회
SELECT
		 emp_id
	  , emp_name
  FROM employee
 WHERE emp_id = 201;
 
-- 4. employee 테이블에서 부서 코드가 'D9'인 사원 조회
SELECT
		 *
  FROM employee
 WHERE dept_code = 'D9';

 
-- 5. employee 테이블에서 직급 코드가 'J1'인 사원 조회
SELECT
		 *
  FROM employee
 WHERE job_code = 'J1';
 
-- 6. employee 테이블에서 급여가 300만원 이상(>=)인 사원의
-- 사번, 이름, 부서코드, 급여를 조회하시오.
SELECT
		 emp_id
	  , emp_name
	  , dept_code
	  , salary
  FROM employee
 WHERE salary >= 3000000
 ORDER BY 4;


-- 7. 부서코드가 'D6'이고 급여를 300만원보다 많이 받는
-- 직원의 이름, 부서코드, 급여 조회
SELECT
		 emp_name
	  , dept_code
	  , salary
  FROM employee
 WHERE dept_code = 'D6'
   AND salary >= 3000000
 ORDER BY 3;

-- 8. 보너스를 받지 않는 사원에 대한
-- 사번, 직원명, 급여, 보너스를 조회
SELECT
		 emp_id
	  , emp_name
	  , salary
	  , bonus		 
  FROM employee
  WHERE bonus IS NULL;

 
-- 9. 'D9' 부서에서 근무하지 않는 사원의
-- 사번, 이름, 부서코드를 조회
SELECT
		 emp_no
	  , emp_name
	  , dept_code
  FROM employee
 WHERE dept_code NOT LIKE '%D9%';

 
-- 10. employee 테이블에서 퇴사 여부가 N인 직원들 조회하고
-- 사번, 이름, 입사일을 별칭을 사용해 조회해 보기
-- (퇴사 여부 컬럼은 ENT_YN이고 N은 퇴사 안한 사람, Y는 퇴사 한 사람)
SELECT
		 emp_id ID
	  , emp_name E_Name
	  , hire_date H_Date
-- 	  , ent_yn
  FROM employee
 WHERE ent_yn LIKE 'N';

-- 11. employee 테이블에서 급여 350만원 이상
-- 550만원 이하를 받는 직원의
-- 사번, 이름, 급여, 부서코드, 직급코드를 별칭을 사용해 조회해 보기
SELECT
		 emp_id AS id
	  , emp_name AS E_name
	  , salary AS salary
	  , dept_code AS D_code
	  , job_code AS J_code
  FROM employee
 WHERE salary BETWEEN 3500000 AND 5500000;

 
-- 12. employee 테이블에서 '성이 김씨'인 직원의 사번, 이름, 입사일 조회
SELECT
		 emp_id
	  , emp_name
	  , hire_date
  FROM employee
 WHERE emp_name LIKE '김%'; 

-- 와일드 카드(wild card)
-- 1. % : 0개 이상의 문자
-- 2. _ : 1개의 문자
-- ex) '하__' 라는 조건을 준다면 '하'로 시작하고 '하'뒤에 반드시 2글자가 붙어있는 조건만 출력 

 
-- 13. employee 테이블에서 '성이 김씨'가 아닌 직원의 사번, 이름, 입사일 조회
SELECT
		 emp_id
	  , emp_name
	  , hire_date
  FROM employee
 WHERE emp_name NOT LIKE '%김%';


-- 14. EMPLOYEE 테이블에서 '하'문자가 이름에 포함 된
-- 직원의 이름, 주민번호, 부서코드 조회
SELECT
		 emp_name
	  , emp_no
	  , dept_code
  FROM employee
 WHERE emp_name LIKE '%하%';

 
-- 15. 'J2'직급이면서 급여가 200만원 이상인 직원이거나
-- 'J7'직급인 직원의 이름, 급여, 직급코드 조회
SELECT
		 emp_name
	  , salary
	  , job_code
  FROM employee
 WHERE job_code = 'J2'
   AND salary >= 2000000
    OR job_code = 'J7';

 
-- 16. 'J2'직급이거나 'J7'직급인 직원들 중에
-- 급여가 200만원 이상인 직원의 이름, 급여, 직급코드 조회
SELECT
		 emp_name
	  , salary
	  , job_code
  FROM employee
 WHERE job_code = 'J2'
 	 OR job_code = 'J7'
   AND salary >= 2000000;


-- 17. IN 연산자로 업그레이드
SELECT
		 emp_name
	  , salary
	  , job_code
  FROM employee
 WHERE job_code IN ('J2', 'J7')
   AND salary >= 2000000;

-- ------------------------------------------
-- <JOIN 사용 연습문제>              

-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1명)
SELECT * FROM employee;
SELECT * FROM department;

SELECT
		 a.EMP_ID
	  , a.EMP_NAME
	  , b.DEPT_TITLE
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
 WHERE emp_name LIKE '%형%';

-- 2. 해외영업팀에 근무하는 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9명)
SELECT * FROM job;
SELECT
		 a.EMP_NAME
	  , c.JOB_NAME
	  , b.DEPT_ID
	  , b.DEPT_TITLE
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
  JOIN job c ON (a.JOB_CODE = c.JOB_CODE)
 WHERE b.DEPT_TITLE LIKE '%해외영업%'
 ORDER BY b.dept_title;


-- 3. 보너스포인트를 받는 직원들의 사원명, 보너스포인트, 부서명, 근무지역명을 조회하시오.(8명)(INNER JOIN 결과)
-- 부서명: job_name, 근무지역명:local_name
SELECT * FROM location;
SELECT * FROM job;
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM national;

SELECT
		 a.EMP_NAME
	  , a.BONUS
	  , b.DEPT_TITLE
	  , d.NATIONAL_NAME
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
  JOIN location c ON (b.LOCATION_ID = c.LOCAL_CODE)
  JOIN national d ON (c.NATIONAL_CODE = d.NATIONAL_CODE)
 WHERE a.BONUS IS NOT NULL;

-- 4. 부서코드가 D2인 직원들의 사원명, 직급명, 부서명, 근무지역명을 조회하시오.(3명)
SELECT
		 a.EMP_name
	  , b.JOB_NAME
	  , c.DEPT_TITLE
	  , e.NATIONAL_NAME
  FROM employee a
  JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
  JOIN department c ON (a.DEPT_CODE = c.DEPT_ID)
  JOIN location d ON (c.LOCATION_ID = d.LOCAL_CODE)
  JOIN national e ON (d.NATIONAL_CODE = e.NATIONAL_CODE)
 WHERE a.DEPT_CODE = 'D2';


-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시오.(20명)
SELECT * FROM sal_grade;

SELECT
		 a.EMP_NAME
	  , c.JOB_NAME
	  , a.SALARY
	  , a.SALARY * (1 + IFNULL(a.BONUS, 0)) * 12 AS Incentive_salary
  FROM employee a
  JOIN sal_grade b ON (a.SAL_LEVEL = b.SAL_LEVEL)
  JOIN job c ON (a.JOB_CODE = c.JOB_CODE)
 WHERE a.SALARY > b.MIN_SAL;
 
-- ifnull(a,b) 함수 or NVL(a,b) 함수
-- 인자 a에 NULL값이 들어오면 인자 b의 값으로 치환하는 함수.
 
-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의 
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15명)
SELECT
		 a.EMP_NAME
	  , b.DEPT_TITLE
	  , c.LOCAL_NAME
	  , d.NATIONAL_NAME
  FROM employee a
  JOIN department b ON (a.DEPT_CODE = b.DEPT_ID)
  JOIN location c ON (b.LOCATION_ID = c.LOCAL_CODE)
  JOIN national d ON (c.NATIONAL_CODE = d.NATIONAL_CODE)
 WHERE d.NATIONAL_CODE IN ('KO', 'JP');

-- 7. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
-- self join 사용(60명)
SELECT * FROM employee ORDER BY dept_code;

SELECT
		 a.EMP_NAME AS 사원명
	  , a.DEPT_CODE AS 부서코드
	  , b.EMP_NAME AS 동료이름
  FROM employee a
  JOIN employee b ON (a.DEPT_CODE = b.DEPT_CODE)  -- 같은부서에 근무하는 직원들을 매칭하기 위해 부서코드로 조건을 설정
 WHERE a.emp_id != b.emp_id;  -- 자기 자신이 동료로 지정된 것을 제외하기 위해 사원번호가 일치하지 않는 데이터만 조회


-- 8. 보너스포인트가 없는 직원들 중에서 직급코드가 J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8명)
SELECT
		 a.EMP_NAME
	  , b.JOB_NAME
	  , a.SALARY
  FROM employee a
  JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
 WHERE a.BONUS IS NULL
   AND a.JOB_CODE IN('J4', 'J7');


-- 9. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오
-- (해당 컬럼을 찾고, 해당 컬럼을 지닌 테이블들을 찾고, 테이블들을 어떤 순서로 조인해야 하는지 고민하고 SQL문을 작성할 것)
SELECT
		 a.EMP_ID
	  , a.EMP_NAME
	  , b.JOB_NAME
	  , c.DEPT_TITLE
	  , d.LOCAL_NAME
	  , a.SALARY
  FROM employee a
  JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
  JOIN department c ON (a.DEPT_CODE = c.DEPT_ID)
  JOIN location d ON (c.LOCATION_ID = d.LOCAL_CODE) 
 WHERE b.JOB_NAME = '대리'
   AND d.LOCAL_NAME LIKE '%ASIA%';

-- 9. 확장 문제 직급, 부서, 지역이 배치되지 않은 사원까지 모두 조회하고자 하는 경우(left join) 사용
-- 한번 left join을 하게되면 모든 조인에 left 조인이 들어가게 된다.
SELECT
		 a.EMP_ID
	  , a.EMP_NAME
	  , b.JOB_NAME
	  , c.DEPT_TITLE
	  , d.LOCAL_NAME
	  , a.SALARY
  FROM employee a
  LEFT JOIN job b ON (a.JOB_CODE = b.JOB_CODE) -- 직급이 없는 사원도 모두 조인
  LEFT JOIN department c ON (a.DEPT_CODE = c.DEPT_ID)  -- 부서 배치가 되지 않은 사원도 모두 조인
  LEFT JOIN location d ON (c.LOCATION_ID = d.LOCAL_CODE) -- 지역 배정이 되지 않은 사원도 모두 조인
 WHERE b.JOB_NAME = '대리'
   AND d.LOCAL_NAME LIKE 'ASIA%';
   
-- 팀스터디 --
-- self join을 사용하여 매니저-사원 관계에 있는 사원들 사원번호, 이름, 매니저번호, 매니저 이름을 조회 하시오.
SELECT
		 b.EMP_ID AS 사원번호
	  , b.EMP_NAME AS 사원이름
	  , a.EMP_ID AS 매니저_번호
	  , a.EMP_NAME AS 매니저_이름
  FROM employee a
  JOIN employee b ON (a.EMP_ID = b.MANAGER_ID);
  
SELECT * FROM employee;

SELECT
		 emp_id
	  , emp_name
	  , email
	  , phone
	  , dept_code
	  , salary
	  , hire_date
  FROM employee;
  
SELECT
		 emp_id
	 , emp_name
	 , salary
  FROM employee
 WHERE salary >= 3000000
   AND salary < 5000000;
   
SELECT
		 a.menu_code
	  , a.menu_name
	  , b.category_code
	  , b.category_name
  FROM tbl_menu a
  JOIN tbl_category b ON (a.category_code = b.category_code)
 ORDER BY 3 ASC;
 
-- employeedb 에서
-- 직급이 ‘차장’이면서 ‘해외영업’팀에 근무하는 직원의
-- (1)이름, (2)부서명, (3)근무국가명, (4)연봉(보너스 포인트 적용)을 조회
SELECT * FROM national;
SELECT * FROM department;
SELECT * from location;
SELECT * FROM job;

SELECT
		 a.EMP_NAME AS 이름
	  , c.DEPT_TITLE AS 부서명
	  , e.NATIONAL_NAME AS 근무국가명
	  , a.SALARY * 12 * (1 + IFNULL(a.BONUS, 0)) AS 연봉
  FROM employee a
  JOIN job b ON (a.JOB_CODE = b.JOB_CODE)
  JOIN department c ON (a.DEPT_CODE = c.DEPT_ID)
  JOIN location d ON (c.LOCATION_ID = d.LOCAL_CODE)
  JOIN national e ON (d.NATIONAL_CODE = e.NATIONAL_CODE)
 WHERE b.JOB_NAME = '차장'
   AND c.DEPT_TITLE LIKE '해외영업%';

-- 사수 - 사원 관계 매칭
SELECT
  FROM employee a