/*
파일명 : ex04_select_quiz.sql
*/

-- Q1. "employees" 테이블에서 모든 직원들의 성(last_name), 이름(first_name)및 급여(salary) 를 조회 하세요.
SELECT last_name, first_name, salary
FROM employees;

-- Q2. "jobs" 테이블에서 모든 직무들의 직무 ID(job_id)와 직무명(job_title)를 조회하세요.
SELECT job_id, job_title
FROM jobs;

-- Q3. "departments"테이블에서 모든 부서들의 부서 ID(department_id)와 부서명(department_name)을 조회하세요.
SELECT department_id, department_name
FROM departments;

-- Q4. "locations" 테이블에서 모든 지역들의 지역 ID(location_id)와 도시(city)를 조회하세요
SELECT location_id, city
FROM locations;

-- Q5. "employees" 테이블에서 급여(salary)가 5000 이상인 직원들의 이름(first_name)과 급여(salary)를 조회하세요
SELECT first_name, salary
FROM employees
WHERE salary >= 5000;

-- Q6. "employees" 테이블에서 근무 시작일(hire_date)이 2005년 이후인 직원들의 이름(first_name)과 근무 시작일(hire_date)을 조회하세요
SELECT first_name, hire_date
FROM employees
WHERE hire_date > '05/01/01';

SELECT first_name, hire_date
FROM employees
WHERE hire_date > TO_DATE('2005/01/01', 'YYYY-MM-DD');
