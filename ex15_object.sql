/*
파일명 : ex15_object.sql

데이터베이스 객체(Database Objects)
    테이블(Table) : 기본 저장단위이며 행으로 구성되어 있습니다.
    뷰(View)    : 하나 이상의 테이블에 있는 데이터의 부분집합을 논리적으로 나타냅니다. (뷰는 실제로는 존재하지 않는 가상의 논리적인 테이블)
    시퀀스 : 일련의 숫자를 자동으로 생성해주는 객체입니다.
    인덱스(Index) : 테이블의 데이터에 대한 빠른검색을 지원해주는 색인 객체입니다. 데이터의 무결성을 위해서도 사용됩니다.
    동의어 : 객체에 다른 이름을 부여합니다.

*/

-- 뷰 생성
CREATE VIEW empvu80
AS SELECT employee_id, last_name, salary
    FROM employees
    WHERE department_id = 80;
    
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE department_id = 80;
    
DESC empvu80;

SELECT * FROM empvu80;

-- alias(별명) 사용 뷰 생성
CREATE VIEW salvu50
AS SELECT employee_id AS ID_NUMBER, last_name name, salary*12 ANN_SALARY
    FROM employees
    WHERE department_id = 50;

DESC salvu50;
    
SELECT employee_id AS ID_NUMBER, last_name name, salary*12 ANN_SALARY, department_id
FROM employees
WHERE department_id = 50;
    
SELECT * FROM salvu50
WHERE ann_salary >= 50000;

CREATE VIEW salvu_hangle
AS SELECT employee_id 아이디, last_name 이름, salary*12 연봉
    FROM employees
    WHERE department_id = 50;
    
SELECT * FROM salvu_hangle;

-- 뷰 수정 (AS를 않쓰고 가로안에서 처리했다.)
CREATE OR REPLACE VIEW empvu80
    (id_number, name, sal, department_id)
    AS SELECT employee_id, first_name || ' ' || last_name, 
    salary, department_id
    FROM employees
    WHERE department_id = 80;

DESC empvu80;

SELECT * FROM empvu80;

-- 실제 원본 테이블에 영향을 미칠 수도 있다.
UPDATE empvu80 SET department_id = 90
WHERE id_number = 145;

ROLLBACK;

SELECT * FROM employees
WHERE employee_id = 145;

/*
복합 뷰 생성
    두 개 이상 기본 테이블에 의해 정의된 뷰
*/
CREATE OR REPLACE VIEW dept_sum_vu
    (name, minsal, maxsal, avgsal)
AS SELECT d.department_name, MIN(e.salary),
        MAX(e.salary), AVG(e.salary)
    FROM employees e JOIN departments d
    ON e.department_id = d.department_id
    GROUP BY d.department_name;

select * from dept_sum_vu;

/*
뷰 DML 작업 수행 규칙
    1. 행 제거할수 없는 경우
        - 그룹 함수
        - GROUP BY 절
        - DISTINCT 키워드
        - Pseudocolumn ROWNUM 키워드
    2. 뷰의 데이터를 수정할 수 없는 경우
        - 그룹 함수
        - GROUP BY 절
        - DISTINCT 키워드
        - Pseudocolumn ROWNUM 키워드
        - 표현식으로 정의되는 열
    3. 뷰를 통해 데이터를 추가할 수 없는 경우
        - 그룹 함수
        - GROUP BY 절
        - DISTINCT 키워드
        - Pseudocolumn ROWNUM 키워드
        - 표현식으로 정의되는 열
        - 뷰에서 선택되지 않은 기본 테이블의 NOU NULL 열
    
*/

-- ROWNUM (가상의컬럼): 쿼리의 결과의 각 행에 순차적인 번호를 할당해준다.
SELECT ROWNUM, employee_id, last_name
FROM employees
WHERE department_id = 80;

-- DML 작업거부
CREATE OR REPLACE VIEW empvu10
    (employee_number, employee_name, job_title)
AS SELECT employee_id, last_name, job_id
    FROM employees
    WHERE department_id = 10
    WITH READ ONLY;

SELECT * FROM empvu10;

-- SQL 오류: ORA-42399: 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
UPDATE empvu10 SET
employee_name = 'Whalen1'
WHERE employee_number = 200;

/*
WITH CHECK OPTION
    뷰에 대한 데이터 변경작업 제한
*/
CREATE OR REPLACE VIEW high_salary_eployee_vu
AS SELECT * FROM  employees WHERE salary > 10000
WITH CHECK OPTION CONSTRAINT  high_salary_eployee_ck;

SELECT * FROM high_salary_eployee_vu;

-- ORA-01402: 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다
UPDATE high_salary_eployee_vu SET
salary = 2400
WHERE employee_id = 100;

-- WITH CHECK OPTION의 조건에 위배되지 않아 변경이 가능합니다.
UPDATE high_salary_eployee_vu SET
salary = 26000
WHERE employee_id = 100;

-- 뷰 제거
DROP VIEW high_salary_eployee_vu;


/*
시퀀스(Sequence)
    연속적인 숫자 값을 자동으로 증감 시켜서 값을 리턴하는 객체입니다.
    채번할때 많이 사용한다.
    
*/

CREATE SEQUENCE my_seq
        INCREMENT BY 1      -- 증가값 (1씩증가)
        START WITH 1        -- 시작값
        MINVALUE 1          -- 최소값
        MAXVALUE 99999999   -- 최대값
        NOCYCLE             -- 최대값 도달시 시작부터 반복 안함
        CACHE 20            -- 미리 번호를 메로리에 생성 (메모리가 고장날 경우 미리 메모리에 저장해 놓은 번호가 날아감)
        ORDER;              -- 요청 순서대로 값을 생성

-- 번호 출력
SELECT my_seq.NEXTVAL FROM dual;

-- 현재 시퀀스 값 확인
SELECT my_seq.CURRVAL FROM dual;

-- 시퀀스 삭제
DROP SEQUENCE my_seq;

DROP TABLE dept3;
CREATE TABLE dept3 AS
SELECT * FROM dept WHERE 1 = 2; 

SELECT * FROM dept3;

INSERT INTO dept3 VALUES(my_seq.NEXTVAL, 'A', 1, SYSDATE);
INSERT INTO dept3 VALUES(my_seq.NEXTVAL, 'B', 2, SYSDATE);
INSERT INTO dept3 VALUES(my_seq.NEXTVAL, 'C', 3, SYSDATE);

/*
인덱스(Index) (튜닝할려면, 쿼리성능을 올릴려면)
    데이터베이스에서 데이터를 빠르게 검색하기 위해 특정 열(또는 열의 조합)을
    정렬하여 저장하는 구조로, 데이터 조회 성능을 향상시키는데 사용됩니다.
    
    pk(기본키) - 테이블 생성시 자동으로 인덱스 생성이 됩니다.
    
    데이터가 많으면 인덱스 쓰고, 데이터가 많이 없으면 풀 스켄 때리면 된다.
*/
SELECT * FROM employees
WHERE last_name = 'King';

-- ROWID : 실제 데이터가 있는 물리적 주소
SELECT last_name, ROWID FROM employees
ORDER BY last_name;

-- employees 테이블의 last_name 열에 대한 인덱스 생성
CREATE INDEX emp_last_name_idx
    ON employees(last_name);
    
-- 인덱스 제거
DROP INDEX emp_last_name_idx;

/*
동의어(SYNONYM)
    동의어를 생성하여 객체에 대체 이름을 부여할 수 있습니다.
*/

-- 동의어 생성
CREATE SYNONYM d_sum
FOR dept_sum_vu;

SELECT * FROM dept_sum_vu;

SELECT * FROM d_sum;

-- 동의어 제거
DROP SYNONYM d_sum;

/*
ROWID : ROW 고유의 아이디
        데이터베이스 내부에서 행의 물리적 위치를 나타냅니다.
ROWNUM : 쿼리의 결과의 각 행에 순차적인 번호를 할당해 준다.
*/
SELECT ROWNUM, ROWID, employee_id, last_name, salary
FROM employees;
















































































