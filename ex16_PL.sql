/*
파일명 : ex16_PL.sql

PL/SQL(Procedual Language extension to SQL)
    SQL을 확장한 절차적 언어 입니다.
    여러 SQL을 하나의 블록(block)으로 구성하여 SQL을 제어할 수 있습니다.
    
프로시저(Procedure)
    데이터베이스에서 실행 가능한 하나 이상의 SQL문을 묶어서 하나의
    논리적 작업단위로 만든 데이터베이스 객체입니다.
*/

/*
익명 프로시저 -- 일회용 프로시저 DB에 저장되지 않습니다.
[기본구조]
    DECLARE -- 변수정의
    BEGIN -- 처리 로직 시작
    EXCEPTION -- 예외처리
    END -- 처리 로직 종료
*/
-- 실행 결과를 출력하도록 설정
SET SERVEROUTPUT ON;

-- 스크립드 경과 시간을 출력하도록 설정
SET TIMING ON;


/*
[출력값]
RESULT > DEPTNO=10, DNAME=Administration, LOC=1700


PL/SQL 프로시저가 성공적으로 완료되었습니다.

경과 시간: 00:00:00.016
*/
DECLARE -- 변수 정의(변수 선언)
    V_STRD_DT       VARCHAR2(8);
    V_STRD_DEPTNO   NUMBER;
    V_DEPTNO        NUMBER;
    V_DNAME         VARCHAR2(50);
    V_LOC           VARCHAR2(50);
    V_RESULT_MSG    VARCHAR2(500) DEFAULT 'SUCCESS';
BEGIN -- 로직 시작 영역
    V_STRD_DT := TO_CHAR(SYSDATE, 'YYYYMMDD'); -- V_STRD_DT 변수에 년월일을 집어넣음 
    V_STRD_DEPTNO := 10; -- V_STRD_DEPTNO 변수에 10을 집어넣음
    
    SELECT T1.department_id
         , T1.department_name
         , T1.location_id
      INTO V_DEPTNO -- department_id 값을 V_DEPTNO에 담기
         , V_DNAME
         , V_LOC
      FROM departments T1
     WHERE T1.department_id = V_STRD_DEPTNO;
    
    --조회 결과 변수 설정
    -- [출력값] RESULT > DEPTNO=10, DNAME=Administration, LOC=1700
    V_RESULT_MSG := 'RESULT > DEPTNO='||V_DEPTNO||', DNAME='||V_DNAME||', LOC='||V_LOC;
    --조회 결과 출력
    DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG ); --출력문
EXCEPTION --예외 처리 (BEGIN에서 오류나면 실행하는 영역)
    WHEN VALUE_ERROR THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], VALUE_ERROR_MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
    WHEN OTHERS THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
END;
/
-- 작업종료

/*
[]에 들어 있는거는 생략가능
프로시저
[기본구조]
CREATE OR REPLACE PROCEDURE 프로시저 이름(파라미터(매개변수)1, 파라미터(매개변수)2 ....)
    IS [AS] 
        [선언부] -- (변수선언)
    BEGIN
        [실행부]
    [EXCEPTION]
        [EXCEPTION 처리]
    END;
    /
*/

CREATE OR REPLACE PROCEDURE print_hello_proc -- 매개변수 없으면 () 생략 가능
    IS -- 프로시저 시작
        msg VARCHAR2(20) := 'hello world'; -- 변수 초기값 선언
    BEGIN
        DBMS_OUTPUT.PUT_LINE(msg);
    END;
/

EXEC print_hello_proc;

/*
IN 매개변수
    값이 프로시저 안으로 들어감
    프로시저 실행에 필요한 값을 직접 입력받는 형식의 파라미터 지정 방식입니다.
*/
CREATE TABLE emp2 AS
SELECT employee_id empno, last_name name, salary, department_id depno
FROM employees;

select * from emp2;

CREATE OR REPLACE PROCEDURE update_emp_salary_proc(eno IN NUMBER) -- eno IN NUMBER (컬럼선언)
    IS
    BEGIN
        UPDATE emp2 SET salary = salary* 1.1
        WHERE empno = eno;
        COMMIT;
    END;
/
-- salary : 3100
select * from emp2
WHERE empno = 115;

-- salary : 3410
-- 여기서 115라는 값을 입력받음
-- depno 컬럼의 값을 eno에 저장 그다음에 내가 만든 프로시저로 가서 BEGIN 실행한다.
EXEC update_emp_salary_proc(115); 

/*
OUT 매개변수
    프로시저의 반환값이 없으므로 OUT 매개변수로 값을 받을 수 있다.
    프로시저 실행 후 호출한 프로그램으로 값을 반환 받을수 있는 방식입니다.
    참조형 매개변수와 비슷
*/
CREATE OR REPLACE PROCEDURE find_emp_proc(v_eno IN NUMBER, 
        v_fname OUT NVARCHAR2, v_lname OUT NVARCHAR2, v_sal OUT NVARCHAR2)
IS
    BEGIN
        SELECT first_name, last_name, salary
        INTO v_fname, v_lname, v_sal
        FROM employees WHERE employee_id = v_eno;
    END;
/
-- VARCHAR2(바이트) NVARCHAR2(문자길이) 차이
-- 변수선언
VARIABLE v_fname NVARCHAR2(25);
VARIABLE v_lname NVARCHAR2(25);
VARIABLE v_sal NUMBER;

EXEC find_emp_proc(115, :v_fname, :v_lname, :v_sal);
PRINT v_fname; -- 출력문 (System.out.println 자바의 출력문과 같다.)
PRINT v_lname; -- 출력문 (System.out.println 자바의 출력문과 같다.)
PRINT v_sal;   -- 출력문 (System.out.println 자바의 출력문과 같다.)

/*
IN OUT 매개변수
    IN OUT 동시에 사용할수 있는 매개변수 입니다.
*/

CREATE OR REPLACE PROCEDURE find_sal(v_io IN OUT NUMBER)
IS
    BEGIN
    SELECT salary
    INTO v_io
    FROM employees WHERE employee_id = v_io;
    END;
/

-- 익명 프로시저 안에서 실행
/*
[결과값]
eno=115
salary=3100
*/
DECLARE
    v_io NUMBER := 115;
    BEGIN
    DBMS_OUTPUT.PUT_LINE('eno='||v_io);
    find_sal(v_io);
    DBMS_OUTPUT.PUT_LINE('salary='||v_io);
    END;
/

VAR v_io NUMBER;    
EXEC :v_io := 115;
PRINT v_io;
EXEC find_sal(:v_io);
PRINT v_io;

/*
함수(Function)
    특정 기능들을 모듈화, 재사용할 수 있게 복잡한 쿼리문을 간격하게 만들수 있습니다.
    
[기본구조]
CREATE OR REPLACE FUNCTION function_name(파라미터1, 파라티머2...)
RETURN datatype -- 반환되는 값의 유형
    IS [AS] -- 선언부
    BEGIN
        [실행부 - PL/SQL 블럭]
    [EXCEPTION]
        [EXCEPTION 처리]
    RETURN 변수;
    END;
/
*/
CREATE OR REPLACE FUNCTION fn_get_dept_name(p_dept_no NUMBER)
RETURN VARCHAR2
    IS
        V_TEST_NAME VARCHAR2(30);
    BEGIN
        SELECT department_name
        INTO V_TEST_NAME -- department_name 값을 V_TEST_NAME에 담기
        FROM departments
        WHERE department_id = p_dept_no;
        
        RETURN V_TEST_NAME;
    END;
/

SELECT fn_get_dept_name(10) FROM dual;