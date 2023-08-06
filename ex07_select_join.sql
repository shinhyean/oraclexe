/*
파일명 : ex07_select_join.sql

JOIN 
    SQL에서 두 개 이상의 테이블에서 관련된 행들을 결합하기 위한 연산
*/

/*
Natural Join
    두 테이블에서 데이터 유형과 이름이 일치하는 열을 기반으로 자동으로
    테이블을 조인할 수 있습니다.
*/
SELECT department_id, department_name,
        location_id, city
FROM departments
NATURAL JOIN locations;

/*
USING 절로 조인
*/
SELECT employee_id, last_name,
        location_id, department_id
FROM employees JOIN departments
USING (department_id);

/*
ON 절로 조인
    ON 절을 사용하여 조인 조건을 지정합니다.
*/
SELECT e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id
FROM employees e JOIN departments d -- 별칭을 줄수 있다
ON (e.department_id = d.department_id);

SELECT e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id
FROM employees e INNER JOIN departments d
ON (e.department_id = d.department_id);

-- join on절 사용않하기
SELECT e.employee_id, e.last_name, 
        e.department_id, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- ON 절을 아용하여 3-Way 조인
SELECT e.employee_id, e.last_name, e.first_name, l.city, d.department_name
FROM employees e 
JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (l.location_id = d.location_id);

-- 조인에 추가 조건 적용
SELECT e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id, e.manager_id
FROM employees e JOIN departments d
ON e.department_id = d.department_id
AND e.manager_id = 149;

SELECT e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id, e.manager_id
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE e.manager_id = 149;

/*
테이블 자체 조인
    ON 절을 사용하는 Self Join
*/

SELECT worker.last_name emp, manager.last_name mgr
FROM employees worker JOIN employees manager
ON worker.manager_id = manager.employee_id;


/*
NonequiJoin
    등호 연산자 외에 다른 연산자를 포함하는 조인 조건입니다.


CREATE TABLE job_grades(
grade_level CHAR(1),
lowest_sal NUMBER(8,2) NOT NULL,
highest_sal NUMBER(8,2) NOT NULL
);

ALTER TABLE job_grades
ADD CONSTRAINT jobgrades_grade_pk PRIMARY KEY (grade_level);

INSERT INTO job_grades VALUES('A', 1000, 2999);
INSERT INTO job_grades VALUES('B', 3000, 5999);
INSERT INTO job_grades VALUES('C', 6000, 9999);
INSERT INTO job_grades VALUES('D', 10000, 14999);
INSERT INTO job_grades VALUES('E', 15000, 24999);
INSERT INTO job_grades VALUES('F', 25000, 40000);

COMMIT;
*/
SELECT e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;


/*
INNER JOIN과 OUTER JOIN

    INNER JOIN
        일치하지 않는 행은 출력에 표시되지 않습니다. (교집합 해당 행 출력)
    
    OUTER JOIN
        한 테이블의 행을 기반으로 다른 테이블과의 연결이 없는 행까지 포함하여 반환합니다.
*/

/*
LEFT OUTER JOIN
    DEOARTMENTS 테이블에 대응되는 행이 없어도
    왼쪽 테이블인 EMPLOYEES 테이블의 모든 행을 검색합니다.(NULL값도 조회가 된다.)
*/
-- ANSI 표준
SELECT e.last_name, e.department_id, d.department_name
FROM employees e 
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

-- LEFT OUTER JOIN을 사용하지 않았을때
SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

-- JOIN : NULL값이 조회가 안된다.
SELECT e.last_name, e.department_id, d.department_name
FROM employees e 
JOIN departments d -- JOIN = INNER JOIN 과 같다. 
ON e.department_id = d.department_id;

/*
RIGHT OUTER JOIN
    EMPLOYEES 테이블에 대응되는 행이 없어도
    오르쪽 테이블인 DEOARTMENTS 테이블의 모든 행을 검색합니다.(NULL값도 조회가 된다.)
*/
SELECT e.last_name, e.department_id, d.department_name
FROM employees e 
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;

/*
FULL OUTER JOIN
    DEOARTMENTS, EMPLOYEES 테이블에 대응되는 행이 없어도
    테이블의 모든행을 검색합니다.
*/
SELECT e.last_name, e.department_id, d.department_name
FROM employees e 
FULL OUTER JOIN departments d
ON e.department_id = d.department_id;

/*
Cartesian Product
    조인 조건이 잘못되거나 완전히 생략된 경우 결과가 모든 행의 조합이 표시되는 
    Cartesian Product로 나타냅니다.
*/

/*
CROSS JOIN
    두 테이블의 교차 곱을 생성합니다.
*/
SELECT last_name, department_name
FROM employees 
CROSS JOIN departments;







































