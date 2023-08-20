/*
���ϸ� : ex16_PL.sql

PL/SQL(Procedual Language extension to SQL)
    SQL�� Ȯ���� ������ ��� �Դϴ�.
    ���� SQL�� �ϳ��� ���(block)���� �����Ͽ� SQL�� ������ �� �ֽ��ϴ�.
    
���ν���(Procedure)
    �����ͺ��̽����� ���� ������ �ϳ� �̻��� SQL���� ��� �ϳ���
    ���� �۾������� ���� �����ͺ��̽� ��ü�Դϴ�.
*/

/*
�͸� ���ν��� -- ��ȸ�� ���ν��� DB�� ������� �ʽ��ϴ�.
[�⺻����]
    DECLARE -- ��������
    BEGIN -- ó�� ���� ����
    EXCEPTION -- ����ó��
    END -- ó�� ���� ����
*/
-- ���� ����� ����ϵ��� ����
SET SERVEROUTPUT ON;

-- ��ũ���� ��� �ð��� ����ϵ��� ����
SET TIMING ON;


/*
[��°�]
RESULT > DEPTNO=10, DNAME=Administration, LOC=1700


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.

��� �ð�: 00:00:00.016
*/
DECLARE -- ���� ����(���� ����)
    V_STRD_DT       VARCHAR2(8);
    V_STRD_DEPTNO   NUMBER;
    V_DEPTNO        NUMBER;
    V_DNAME         VARCHAR2(50);
    V_LOC           VARCHAR2(50);
    V_RESULT_MSG    VARCHAR2(500) DEFAULT 'SUCCESS';
BEGIN -- ���� ���� ����
    V_STRD_DT := TO_CHAR(SYSDATE, 'YYYYMMDD'); -- V_STRD_DT ������ ������� ������� 
    V_STRD_DEPTNO := 10; -- V_STRD_DEPTNO ������ 10�� �������
    
    SELECT T1.department_id
         , T1.department_name
         , T1.location_id
      INTO V_DEPTNO -- department_id ���� V_DEPTNO�� ���
         , V_DNAME
         , V_LOC
      FROM departments T1
     WHERE T1.department_id = V_STRD_DEPTNO;
    
    --��ȸ ��� ���� ����
    -- [��°�] RESULT > DEPTNO=10, DNAME=Administration, LOC=1700
    V_RESULT_MSG := 'RESULT > DEPTNO='||V_DEPTNO||', DNAME='||V_DNAME||', LOC='||V_LOC;
    --��ȸ ��� ���
    DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG ); --��¹�
EXCEPTION --���� ó�� (BEGIN���� �������� �����ϴ� ����)
    WHEN VALUE_ERROR THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], VALUE_ERROR_MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
    WHEN OTHERS THEN
        V_RESULT_MSG := 'SQLCODE['||SQLCODE||'], MESSAGE =>'||SQLERRM;
        DBMS_OUTPUT.PUT_LINE( V_RESULT_MSG );
END;
/
-- �۾�����

/*
[]�� ��� �ִ°Ŵ� ��������
���ν���
[�⺻����]
CREATE OR REPLACE PROCEDURE ���ν��� �̸�(�Ķ����(�Ű�����)1, �Ķ����(�Ű�����)2 ....)
    IS [AS] 
        [�����] -- (��������)
    BEGIN
        [�����]
    [EXCEPTION]
        [EXCEPTION ó��]
    END;
    /
*/

CREATE OR REPLACE PROCEDURE print_hello_proc -- �Ű����� ������ () ���� ����
    IS -- ���ν��� ����
        msg VARCHAR2(20) := 'hello world'; -- ���� �ʱⰪ ����
    BEGIN
        DBMS_OUTPUT.PUT_LINE(msg);
    END;
/

EXEC print_hello_proc;

/*
IN �Ű�����
    ���� ���ν��� ������ ��
    ���ν��� ���࿡ �ʿ��� ���� ���� �Է¹޴� ������ �Ķ���� ���� ����Դϴ�.
*/
CREATE TABLE emp2 AS
SELECT employee_id empno, last_name name, salary, department_id depno
FROM employees;

select * from emp2;

CREATE OR REPLACE PROCEDURE update_emp_salary_proc(eno IN NUMBER) -- eno IN NUMBER (�÷�����)
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
-- ���⼭ 115��� ���� �Է¹���
-- depno �÷��� ���� eno�� ���� �״����� ���� ���� ���ν����� ���� BEGIN ����
EXEC update_emp_salary_proc(115); 

/*
OUT �Ű�����
    ���ν����� ��ȯ���� �����Ƿ� OUT �Ű������� ���� ���� �� �ִ�.
    ���ν��� ���� �� ȣ���� ���α׷����� ���� ��ȯ ������ �ִ� ����Դϴ�.
    ������ �Ű������� ���
*/
CREATE OR REPLACE PROCEDURE find_emp_proc(v_eno IN NUMBER, 
        v_fname OUT NVARCHAR2, v_lname OUT NVARCHAR2, v_sal OUT NVARCHAR2) -- 
IS
    BEGIN
        SELECT first_name, last_name, salary
        INTO v_fname, v_lname, v_sal
        FROM employees WHERE employee_id = v_eno;
    END;
/
-- VARCHAR2(����Ʈ) NVARCHAR2(���ڱ���) ����
-- ��������
VARIABLE v_fname NVARCHAR2(25);
VARIABLE v_lname NVARCHAR2(25);
VARIABLE v_sal NUMBER;

EXEC find_emp_proc(115, :v_fname, :v_lname, :v_sal);
PRINT v_fname;
PRINT v_lname;
PRINT v_sal;

/*
IN OUT �Ű�����
    IN OUT ���ÿ� ����Ҽ� �ִ� �Ű����� �Դϴ�.
*/

CREATE OR REPLACE PROCEDURE find_sal(v_io IN OUT NUMBER)
IS
    BEGIN
    SELECT salary
    INTO v_io
    FROM employees WHERE employee_id = v_io;
    END;
/

-- �͸� ���ν��� �ȿ��� ����
/*
[�����]
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
�Լ�(Function)
    Ư�� ��ɵ��� ���ȭ, ������ �� �ְ� ������ �������� �����ϰ� ����� �ֽ��ϴ�.
    
[�⺻����]
CREATE OR REPLACE FUNCTION function_name(�Ķ����1, �Ķ�Ƽ��2...)
RETURN datatype -- ��ȯ�Ǵ� ���� ����
    IS [AS] -- �����
    BEGIN
        [����� - PL/SQL ��]
    [EXCEPTION]
        [EXCEPTION ó��]
    RETURN ����;
    END;
/
*/
CREATE OR REPLACE FUNCTION fn_get_dept_name(p_dept_no NUMBER)
RETURN VARCHAR2
    IS
        V_TEST_NAME VARCHAR2(30);
    BEGIN
        SELECT department_name
        INTO V_TEST_NAME -- department_name ���� V_TEST_NAME�� ���
        FROM departments
        WHERE department_id = p_dept_no;
        
        RETURN V_TEST_NAME;
    END;
/

SELECT fn_get_dept_name(10) FROM dual;