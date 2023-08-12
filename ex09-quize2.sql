-- 1. 각 직원의 성(last_name)과 해당 직원의 매니저인 직원의 성(last_name) 조회하기
SELECT e.last_name AS 직원_성,
       m.last_name AS 매니저_성
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;

-- 2. 각 직원의 성(last_name)과 해당 직원의 부서 이름(department_name) 조회하기
SELECT e.last_name AS 직원_성,
       d.department_name AS 부서_이름
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 3. 각 부서의 이름(department_name)과 해당 부서의 평균 급여(avg_salary) 조회하기
SELECT d.department_name AS 부서_이름,
       AVG(e.salary) AS 평균_급여
FROM departments d
JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 4. 각 부서의 이름(department_name)과 해당 부서의 최대 급여(max_salary) 조회하기
SELECT d.department_name AS 부서_이름,
       MAX(e.salary) AS 최대_급여
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;


-- 5. 각 직원의 성(last_name)과 해당 직원이 속한 부서의 최소 급여(min_salary) 조회하기
-- 서프쿼리도 조인이 된다.
SELECT oe.last_name, od.min_salary
FROM employees oe
JOIN(
    SELECT d.department_id, MIN(e.salary) AS min_salary
    FROM departments d
    JOIN employees e ON e.department_id = d.department_id
    GROUP BY d.department_id
    ) od
ON oe.department_id = od.department_id;

-- 6. 각 부서의 이름(department_name)과 해당 부서에 속한 직원 중 가장 높은 급여(highest_salary) 조회하기
SELECT d.department_name AS 부서_이름,
       MAX(e.salary) AS highest_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 7. 각 직원의 성(last_name)과 해당 직원의 매니저의 성(last_name) 및 부서 이름(department_name) 조회하기
SELECT e.last_name AS 직원_성,
       m.last_name AS 매니저_성,
       d.department_name AS 부서_이름
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
JOIN departments d ON e.department_id = d.department_id;

-- 8. 각 직원의 성(last_name)과 해당 직원이 속한 부서의 매니저의 성(last_name) 조회하기
SELECT e.last_name AS 직원_성,
       m.last_name AS 매니저_성
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN employees m ON d.manager_id = m.employee_id;

-- 강사님
SELECT oe.last_name AS W_LAST_NAME, om.last_name  AS M_LAST_NAME
FROM(
    SELECT e.last_name, d.department_id, d.manager_id
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
) oe
JOIN employees om ON oe.manager_id = om.employee_id;

-- 9. 각 직원의 성(last_name)과 해당 직원의 보고 상사가 있는 경우 보고 상사의 성(last_name) 조회하기
SELECT e1.last_name AS 직원_성,
       e2.last_name AS 보고_상사_성
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.employee_id;

-- 10. 직원들 중에서 급여(salary)가 10000 이상인 직원들의 성(last_name)과 해당 직원의 부서 이름(department_name) 조회하기
SELECT e.last_name AS 직원_성,
       d.department_name AS 부서_이름,
       e.salary AS 급여
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary >= 10000
ORDER BY e.salary DESC;

/*
11.
각 부서의 이름(department_name), 해당 부서의 매니저의 ID(manager_id)와 매니저의 성(last_name),
직원의 ID(employee_id), 직원의 성(last_name), 그리고 해당 직원의 급여(salary) 조회하기.
직원들의 급여(salary)가 해당 부서의 평균 급여보다 높은 직원들을 조회합니다.
결과는 부서 이름과 직원의 급여가 높은 순으로 정렬됩니다.
*/
SELECT d.department_name AS 부서_이름,
       e1.manager_id AS 매니저_ID,
       e1.last_name AS 매니저_성,
       e2.employee_id AS 직원_ID,
       e2.last_name AS 직원_성,
       e2.salary AS 직원_급여
FROM departments d
JOIN employees e1 ON d.department_id = e1.department_id
JOIN employees e2 ON e1.manager_id = e2.employee_id
WHERE e2.salary > (
    SELECT AVG(salary)
    FROM employees e3
    WHERE e3.department_id = d.department_id
)
ORDER BY d.department_name, e2.salary DESC;

SELECT d.department_name AS 부서_이름,
       d.manager_id AS 매니저_ID,
       m.last_name AS 매니저_성,
       e.employee_id AS 직원_ID, 
       e.last_name AS 직원_성, 
       e.salary AS 직원_급여
FROM departments d
JOIN employees m ON d.manager_id = m.employee_id
JOIN employees e ON e.department_id = d.department_id
--WHERE 1 = 1
WHERE e.salary > (
            -- 각 부서의 평균 급여
            SELECT AVG(e1.salary)
            FROM employees e1
            WHERE e1.department_id = d.department_id
            )
ORDER BY d.department_name, e.salary DESC;

-- 각부서의 평균 급여에 GROUP BY절 사용 
SELECT d.department_name AS 부서_이름,
       d.manager_id AS 매니저_ID,
       m.last_name AS 매니저_성,
       e.employee_id AS 직원_ID, 
       e.last_name AS 직원_성, 
       e.salary AS 직원_급여
       --, da.Avg_Salary
FROM departments d
JOIN employees m ON d.manager_id = m.employee_id
JOIN employees e ON e.department_id = d.department_id
JOIN(
     SELECT department_id, AVG(salary) AS Avg_Salary
     FROM employees
     GROUP BY department_id
) da
ON d.department_id = da.department_id
WHERE e.salary > da.Avg_Salary
ORDER BY d.department_name, e.salary DESC;