/*
���ϸ� : ex13_DML.sql

DML(Data Manipulation Language)
    DB���� �����͸� �����ϰ� ó���ϴ� SQL��
    
    SELECT��
    INSERT�� : ���̺� ���ο� ���ڵ� ����
    UPDATE�� : ���̺� ���� ���ڵ带 ����(������Ʈ) �ϴµ� ���
    DELETE�� : ���̺��� Ư�� ���ڵ带 ����
    
    SELECT�� DML ���Ե� �� ������, ���������δ� ���� DQL(Data Query Lanaguage) �з��Ѵ�.
*/

/*
INSERT��
[�⺻����]
    INSERT INTO ���̺��(�÷���1, �÷���2, ...)
    VALUES(��1, ��2, ...);
    
    �Ǵ� 
    
    INSERT INTO ���̺��(�÷���1, �÷���2, ...) subquery(select �÷���1, �÷���2, ... from ���̺�� where ���ǽ�);
*/

select * FROM departments;

INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (280, 'Public Relations', 100, 1700);

COMMIT; -- DML ����� ���������� DB�� �ݿ�

-- null ���� ���� �� ����
-- �� ���� ����
INSERT INTO departments(department_id, department_name)
VALUES (290, 'Purchasing');

select * FROM departments;

ROLLBACK; -- DML���� ���� ����� ����� �� (COMMIT�� �������� ����)

-- NULL Ű���� ����
INSERT INTO departments 
VALUES (300, 'Finance', NULL, NULL);

/* INSERT subquery

*/

CREATE TABLE sales_reps
AS (SELECT employee_id id, last_name name, salary, commission_pct 
    FROM employees
    WHERE 1 = 2);
    
SELECT * FROM sales_reps;

-- job_id REP ���Ե� ���
SELECT employee_id, last_name, salary, commission_pct, job_id
FROM employees
WHERE job_id LIKE '%REP%';

-- sales_reps ���̺� job_id REP ���Ե� ����� �����ϱ�
INSERT INTO sales_reps(id, name, salary, commission_pct) 
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';

COMMIT;

SELECT * FROM sales_reps;

/*
UPDATE ��
    ���̺��� ���� ���� �����մϴ�.

[��������]
    UPDATE ���̺��
    SET �÷���1 = ������, �÷���2 = ������
    WHERE ������
*/

CREATE TABLE copy_emp
AS (SELECT * FROM employees WHERE 1 = 2);

INSERT INTO copy_emp
SELECT * FROM employees;

COMMIT;

SELECT * FROM copy_emp;

-- 113��ȸ�� �μ���ȣ 50������ ����
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
                     WHERE employee_id = 100) -- employee_id�� 100���� ã�� ���� department_id�� 90�� �ٲٱ�
WHERE job_id = (SELECT job_id
                FROM employees
                WHERE employee_id = 200); -- employee_id�� 200���� ���ã��
SELECT * FROM copy_emp;
SELECT * FROM copy_emp WHERE job_id = 'AD_ASST';

/*
DELETE��
    DELETE ���� ����Ͽ� ���̺��� ���� ���� ������ �� �ֽ��ϴ�.
*/

-- �����ȣ 200�� ��� ����
DELETE FROM copy_emp
WHERE employee_id = 200;

SELECT * FROM copy_emp
WHERE employee_id = 200;

ROLLBACK;

-- ���̺� ��ü ������ ����
DELETE FROM copy_emp;

SELECT * FROM copy_emp;

/*
TRUNCATE ��
    ���̺��� �� ���·�, ���̺� ���� �״�� ���ܵ�ä ���̺��� ��� ���� �����մϴ�.
    DML ���� �ƴ϶� DDL(������ ���Ǿ�) ���̹Ƿ� ���� ���(undo : ���� ���)�� �� �����ϴ�.
*/
TRUNCATE TABLE copy_emp;

/*
Ʈ�����(Transaction)
    ������ ó���� �� �����Դϴ�.
    ����Ŭ���� �߻��ϴ� ���� ���� SQL ��ɹ��� 
    �ϳ��� ������ �۾� ������ ó���ϴµ� �̸� Ʈ������̶�� �մϴ�.
    
    COMMIT : SQL���� ����� ���������� DB�� �ݿ�
    ROLLBACK : SQL���� �������� ����� ��
    SAVEPOINT : Ʈ�������� �������� ǥ���Ѵ� �ӽ� ������
    
Atomicity(���ڼ�)
1. Ʈ������� ������ �����ͺ��̽��� ��� �ݿ��ǵ��� �ƴϸ� ���� �ݿ����� �ʾƾ� �Ѵ�.
2. Ʈ����� ���� ��� ����� �ݵ�� �Ϻ��� ����Ǿ�� �ϸ�, ��ΰ� �Ϻ��� ������� �ʰ� ����ϳ��� ������ �߻��ϸ� Ʈ����� ���ΰ� ��ҵǾ�� �Ѵ�.

Consistency(�ϰ���)
1. Ʈ������� �� ������ ���������� �Ϸ��ϸ� ������ �ϰ��� �ִ� �����ͺ��̽� ���·� ��ȯ�Ѵ�.
2. �ý����� ������ �ִ� ������Ҵ� Ʈ����� ���� ���� Ʈ����� ���� �Ϸ� ���� ���°� ���ƾ� �Ѵ�.

Isolation(������,�ݸ���)
1. �� �̻��� Ʈ������� ���ÿ� ���� ����Ǵ� ��� ��� �ϳ��� Ʈ����� �����߿� �ٸ� Ʈ������� ������ ����� �� ����.
2. �������� Ʈ������� ������ �Ϸ�� ������ �ٸ� Ʈ����ǿ��� ���� ����� ������ �� ����.

Durablility(���Ӽ�,���Ӽ�)
1. ���������� �Ϸ�� Ʈ������� ����� �ý����� ���峪���� ���������� �ݿ��Ǿ�� �Ѵ�.
*/

CREATE TABLE member(
    num NUMBER PRIMARY KEY,
    name VARCHAR2(30),
    addr VARCHAR2(50));
    
SELECT * FROM member;

INSERT INTO member VALUES(1, '��ī��', '���ʸ���');
COMMIT;
INSERT INTO member VALUES(2, '������', '���ʸ���');
INSERT INTO member VALUES(3, '���̸�', '���ʸ���');
INSERT INTO member VALUES(4, '���α�', '���ʸ���');

ROLLBACK;

SELECT * FROM member;

-- SAVEPOINT
INSERT INTO member VALUES(5, '������', '���ʸ���');
SAVEPOINT mypoint;
INSERT INTO member VALUES(6, '�ߵ���', '���ʸ���');
INSERT INTO member VALUES(7, '������', '���ʸ���');
INSERT INTO member VALUES(8, '�ǰ���', '���ʸ���');
ROLLBACK TO mypoint;
COMMIT;

/*
SELECT ���� FOR UPDATE��
    FOR UPDATE �� Ư�� ���ڵ带 ���(lock) ó���ϴ� SQL�����Դϴ�.
    COMMIT �Ǵ� ROLLBACK ������� �մϴ�.
*/
SELECT employee_id, salary, job_id
FROM employees
WHERE job_id = 'SA_REP'
FOR UPDATE;
COMMIT;