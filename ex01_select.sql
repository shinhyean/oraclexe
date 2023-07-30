/*
���ϸ� : ex01_selcet.sql
SQL (Structured Query Language) - ������ ���� ���
    ������ ������ ���̽� �ý��ۿ��� �ڷḦ ���� �� ó���ϱ� ���� ����� ���
    
SELECT��
    �����ͺ��̽����� ���� �˻� ��ɾ�
*/
-- ��� �� ���� * 
SELECT * 
FROM departments;

-- Ư�� �� ����(�������� projection)
SELECT department_id, location_id
FROM departments;

/*
�����
    ��������ڸ� ����Ͽ� ����/��¥ ������ ǥ���� �ۼ�
    + ���ϱ�
    - ����
    * ���ϱ�
    / ������
*/
-- ��� ������ ���
SELECT LAST_NAME, SALARY, SALARY + 300
FROM employees;

/*
������ �켱����
    ���ϱ�� ������� ���ϱ� ���⺸�� ���� ����
*/
SELECT LAST_NAME, SALARY, 12*SALARY+100
FROM employees;

SELECT LAST_NAME, SALARY, 12*(SALARY+100)
FROM employees;

/*
������� Null ��
    Null ���� �����ϴ� ������� Null�� ���
*/
SELECT last_name, 12*salary*commission_pct, salary, commission_pct
FROM employees;

/*
�� alias ���� - ����
    �� �Ӹ����� �̸��� �ٲߴϴ�.
    �� �̸� �ٷ� �ڿ� ���ɴϴ�.(�� �̸��� alias ���׿� ���� ������ as Ű���尡 �ü� �ֽ��ϴ�.)
    �����̳� Ư�� ���ڸ� �����ϰų� ��ҹ��ڸ� �����ϴ� ��� ū ����ǥ�� �ʿ��մϴ�.
*/
SELECT last_name as name, commission_pct comm, salary * 10 as �޿�10��
FROM employees;

SELECT last_name as "Name", salary * 12 as "Annual Salary"
FROM employees;

/*
���� ������
    ���̳� ���ڿ��� �ٸ����� �����մϴ�.
    �� ���� ���μ�(||)���� ��Ÿ���ϴ�.
    ��� ���� ���� ǥ������ �ۼ� �մϴ�.
*/
SELECT last_name||job_id AS "Employees", last_name, job_id
FROM employees;

/*
���ͷ� ���ڿ�
    ���ͷ��� SELECT ���� ���Ե� ����, ���� �Ǵ� ��¥ �Դϴ�.
    ��¥ �� ���� ���ͷ� ���� ���� ����ǥ�� ����� �˴ϴ�.
    �� ���ڿ��� ��ȯ�Ǵ� �� �࿡ �ѹ� ��µ˴ϴ�.
*/
SELECT last_name || ' is a ' || job_id AS "Employees Details"
FROM employees;

/*
    �ڽ��� ����ǥ �����ڸ� �����մϴ�.
    �����ڸ� ���Ƿ� �����մϴ�.
    ������ �� ��뼺�� �����մϴ�.
*/
SELECT department_name || q'[ Department's Manager Id: ]' || manager_id
AS "Department and Manger"
FROM departments;

/*
�ߺ��� 
    �⺹������ Query ������� �ߺ� ���� ������ ������� ǥ�õ˴ϴ�.
    
DISTICT
    ������� �ߺ��� ����
*/
SELECT department_id
FROM employees;

-- �ߺ�����
SELECT DISTINCT department_id
FROM employees;

/*
���̺� ����ǥ��
    DESCRIBE ����� ����Ͽ� ���̺� ������ ǥ���մϴ�.
*/
DESCRIBE employees;

DESC employees;









