/*
파일명 : ex13_DML.sql

DML(Data Manipulation Language)
    DB에서 데이터를 조작하고 처리하는 SQL문
    
    SELECT문
    INSERT문 : 테이블에 새로운 레코드 삽입
    UPDATE문 : 테이블에 기존 레코드를 갱신(업데이트) 하는데 사용
    DELETE문 : 테이블에서 특정 레코드를 삭제
    
    SELECT는 DML 포함될 수 있지만, 세부적으로는 보통 DQL(Data Query Lanaguage) 분류한다.
*/

/*
INSERT문
[기본형식]
    INSERT INTO 테이블명(컬럼명1, 컬럼명2, ...)
    VALUES(값1, 값2, ...);
    
    또는 
    
    INSERT INTO 테이블명(컬럼명1, 컬럼명2, ...) subquery(select 컬럼명1, 컬럼명2, ... from 테이블명 where 조건식);
*/

select * FROM departments;

INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (280, 'Public Relations', 100, 1700);

COMMIT; -- DML 결과를 영구적으로 DB에 반영

-- null 값을 가진 행 삽입
-- 열 생략 가능
INSERT INTO departments(department_id, department_name)
VALUES (290, 'Purchasing');

select * FROM departments;

ROLLBACK; -- DML문의 실행 결과를 취소할 때 (COMMIT을 안했을때 가능)

-- NULL 키워드 지정
INSERT INTO departments 
VALUES (300, 'Finance', NULL, NULL);

/* INSERT subquery

*/

CREATE TABLE sales_reps
AS (SELECT employee_id id, last_name name, salary, commission_pct 
    FROM employees
    WHERE 1 = 2);
    
SELECT * FROM sales_reps;

-- job_id REP 포함된 사원
SELECT employee_id, last_name, salary, commission_pct, job_id
FROM employees
WHERE job_id LIKE '%REP%';

-- sales_reps 테이블에 job_id REP 포함된 사원을 복사하기
INSERT INTO sales_reps(id, name, salary, commission_pct) 
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

COMMIT;

SELECT * FROM sales_reps;

/*
UPDATE 문
    테이블의 기존 값을 수정합니다.

[기존형식]
    UPDATE 테이블명
    SET 컬럼명1 = 수정값, 컬럼명2 = 수정값
    WHERE 조건절
*/

CREATE TABLE copy_emp
AS (SELECT * FROM employees WHERE 1 = 2);

INSERT INTO copy_emp
SELECT * FROM employees;

COMMIT;

SELECT * FROM copy_emp;

-- 113번회원 부서번호 50번으로 변경
UPDATE copy_emp 
SET department_id = 50
WHERE employee_id = 113;

ROLLBACK;

UPDATE copy_emp 
SET department_id = 110;

UPDATE copy_emp 
SET department_id = 80
WHERE employee_id = 113;

UPDATE copy_emp 
SET department_id = (SELECT department_id
                     FROM employees
                     WHERE employee_id = 100) -- employee_id의 100번을 찾은 다음 department_id로 90을 바꾸기
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 200); -- employee_id가 200번인 사람찾기
SELECT * FROM copy_emp;
SELECT * FROM copy_emp WHERE job_id = 'AD_ASST';

/*
DELETE문
    DELETE 문을 사용하여 테이블에서 기존 행을 제거할 수 있습니다.
*/

-- 사원번호 200번 사원 삭제
DELETE FROM copy_emp
WHERE employee_id = 200;

SELECT * FROM copy_emp
WHERE employee_id = 200;

ROLLBACK;

-- 테이블 전체 데이터 삭제
DELETE FROM copy_emp;

SELECT * FROM copy_emp;

/*
TRUNCATE 문
    테이블을 빈 상태로, 테이블 구조 그대로 남겨둔채 테이블에서 모든 행을 제거합니다.
    DML 문이 아니라 DDL(데이터 정의어) 문이므로 쉽게 언두(undo : 실행 취소)할 수 없습니다.
*/
TRUNCATE TABLE copy_emp;

/*
트랜잭션(Transaction)
    데이터 처리의 한 단위입니다.
    오라클에서 발생하는 여러 개의 SQL 명령문을 
    하나의 논리적인 작업 단위로 처리하는데 이를 트랙잭션이라고 합니다.
    
    COMMIT : SQL문의 결과를 영구적으로 DB에 반영
    ROLLBACK : SQL문의 실행결과를 취소할 때
    SAVEPOINT : 트랜색젼의 한지점에 표시한는 임시 저장점
    
Atomicity(원자성)
1. 트랜잭션의 연산은 데이터베이스에 모두 반영되든지 아니면 전혀 반영되지 않아야 한다.
2. 트랜잭션 내의 모든 명령은 반드시 완벽히 수행되어야 하며, 모두가 완벽히 수행되지 않고 어느하나라도 오류가 발생하면 트랜잭션 전부가 취소되어야 한다.

Consistency(일관성)
1. 트랜잭션이 그 실행을 성공적으로 완료하면 언제나 일관성 있는 데이터베이스 상태로 변환한다.
2. 시스템이 가지고 있는 고정요소는 트랜잭션 수행 전과 트랜잭션 수행 완료 후의 상태가 같아야 한다.

Isolation(독립성,격리성)
1. 둘 이상의 트랜잭션이 동시에 병행 실행되는 경우 어느 하나의 트랜잭션 실행중에 다른 트랜잭션의 연산이 끼어들 수 없다.
2. 수행중인 트랜잭션은 완전히 완료될 때까지 다른 트랜잭션에서 수행 결과를 참조할 수 없다.

Durablility(영속성,지속성)
1. 성공적으로 완료된 트랜잭션의 결과는 시스템이 고장나더라도 영구적으로 반영되어야 한다.
*/

CREATE TABLE member(
    num NUMBER PRIMARY KEY,
    name VARCHAR2(30),
    addr VARCHAR2(50));
    
SELECT * FROM member;

INSERT INTO member VALUES(1, '피카츄', '태초마을');
COMMIT;
INSERT INTO member VALUES(2, '라이츄', '태초마을');
INSERT INTO member VALUES(3, '파이리', '태초마을');
INSERT INTO member VALUES(4, '꼬부기', '태초마을');

ROLLBACK;

SELECT * FROM member;

-- SAVEPOINT
INSERT INTO member VALUES(5, '버터플', '태초마을');
SAVEPOINT mypoint;
INSERT INTO member VALUES(6, '야도란', '태초마을');
INSERT INTO member VALUES(7, '피존투', '태초마을');
INSERT INTO member VALUES(8, '또가스', '태초마을');
ROLLBACK TO mypoint;
COMMIT;

/*
SELECT 문의 FOR UPDATE절
    FOR UPDATE 는 특정 레코드를 잠금(lock) 처리하는 SQL구문입니다.
    COMMIT 또는 ROLLBACK 잠금해제 합니다.
*/
SELECT employee_id, salary, job_id
FROM employees
WHERE job_id = 'SA_REP'
FOR UPDATE;
COMMIT;