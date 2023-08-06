/*
파일명 : ex06_function_group.sql
*/

-- 여러행(그룹) 함수

-- AVG() - 평균
-- MAX() - 최대값
-- MIN() - 최소값
-- SUM() - 합계
SELECT AVG(salary) AS avg_salary,
       MAX(salary) AS max_salary,
       MIN(salary) AS min_salary,
       SUM(salary) AS sum_salary
FROM employees
WHERE job_id LIKE '%REP%';

-- COUNT() 함수 - null 값이 아닌 모든 행의 개수를 반환합니다.
SELECT COUNT(*) AS total_employees
FROM employees
WHERE department_id = 50;

SELECT COUNT(1) AS total_employees
FROM employees
WHERE department_id = 50;

-- null값 있으면 있어서 COUNT가 읽어 들이지 못한다.(NULL값이랑 소수점값을 조심해야 된다. 컴퓨터가 읽어 들이지 못할 수도 있다)
SELECT COUNT(commission_pct) AS non_null_commission_count 
FROM employees
WHERE department_id = 50;

-- COUNT(DISTINCT expr)은 특정 표현식을 기준으로 중복을 제거한 행의 개수 반환합니다.
SELECT COUNT(DISTINCT department_id) AS distinct_department_count -- null값을 제외한 값들을 출력한다.
FROM employees;

-- NVL 함수를 활용하여 NULL 값을 다른 값으로 대체한 후 AVG() 함수 사용
SELECT AVG(NVL(commission_pct, 0)) AS avg_commission -- null값이 있어도 실행할수 있는 쿼리문
FROM employees;

/*
GROUP BY
    여러 행을 지정된 컬럼 기준으로 그룹화하여 집계 함수를 적용하기 위한 구문
    
HAVING
    GROUP BY와 함께 사용되며, 그룹화된 결과에 조건을 정용할 때 사용됩니다.
    
    WHERE - 개별행의 조건
    HAVING - 그룹의 조건
*/

-- 부서별 평균 급여를 구합니다.
SELECT department_id, ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY department_id;

-- GROUP BY 절에서 여러 열을 기준으로 그룹화 합니다.
SELECT department_id, job_id, SUM(salary) AS total_salary
FROM employees
WHERE department_id > 40
GROUP BY department_id, job_id
ORDER BY department_id ASC;

-- HAVING 절 사용

-- 부서별 최대 급여가 10000보다 큰 부서를 찾습니다.
SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id 
HAVING MAX(salary) > 10000;

-- 직무별 총 급여가 13000보다 큰 직무를 찾습니다.
SELECT job_id, SUM(salary) AS total_salary
FROM employees
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING SUM(salary) > 13000
ORDER BY SUM(salary); -- ORDER BY SUM(salary); == ORDER BY total_salary;

-- 그룹함수 함수중첩 가능
SELECT MAX(AVG(salary)) AS max_avg_salary
FROM employees
GROUP BY department_id;


































