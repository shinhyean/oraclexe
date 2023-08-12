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