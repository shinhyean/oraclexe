/*
파일명 : ex12_Set.sql
집합 연산자
    여러 테이블 또는 집합의 결과를 조합하고 조작하는 연산자.
    SELECT 리스트의 표현식을 컬럼 개수가 일치해야합니다.
    
    UNION, UNION ALL, INTERSECT, MINUS
*/

-- UNION 연산자 : 두 개의 쿼리 결과를 합치고, 중복된 행을 제거합니다.(아래로 값을 합친다.)
SELECT employee_id, job_id
FROM employees
UNION
SELECT employee_id, job_id
FROM job_history
ORDER BY employee_id;

-- UNION ALL 연산자 : 두 개의 쿼리 결과를 합치고, 중복된 행을 포함하여 모두 반환합니다.(아래로 값을 합친다.)
SELECT employee_id, job_id
FROM employees
UNION ALL
SELECT employee_id, job_id
FROM job_history
ORDER BY employee_id;

-- INTERSECT 연산자 : 두 개의 쿼리 결과 중에서 공통된 행만 반환합니다.(JOIN으로 만들어 보기)
SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history
ORDER BY employee_id;

-- MINUS 연산자 : 첫번째 쿼리 결과 중에서 두번째 쿼리 결과에 존재하지 않는 행만 반환합니다.(컬럼 열이 맞아야 쿼리가 정상 작동한다.)
SELECT employee_id, job_id
FROM employees
MINUS
SELECT employee_id, job_id
FROM job_history
ORDER BY employee_id;

DESC employees;

-- !> 데이터(타입) 유형 일치시켜야 합니다.
-- 조인하지 않은 두 테이블의 특정 컬럼들을 UNION하여 가져오기
SELECT location_id, department_name AS "Department", TO_CHAR(NULL) "Warehouse location"
FROM departments
UNION
SELECT location_id, TO_CHAR(NULL) AS "Department", state_province
FROM locations;

SELECT employee_id, job_id, salary
FROM employees
UNION
SELECT employee_id, job_id, 0
FROM job_history;
