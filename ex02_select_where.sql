/*
���ϸ� : ex02_select_where.sql

������ ����Ͽ� �� ����
    WHERE ���� ����Ͽ� ��ȯ�Ǵ� ���� �����մϴ�.
    
WHERE
    ������ �����ϴ� ������ query�� �����մϴ�.
    
    ������ ���
    - ���̸�
    - �� ����
    - �� �̸�, ��� �Ǵ� �� ����Ʈ
*/
--WHERE
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 90;

/*
���ڿ� �� ��¥
    ���ڿ� �� ��¥ ���� ���� �ٿ�ǥ�� �����ϴ�.
    ���� ���� ��ҹ��ڸ� �����ϰ� ��¥ ���� ������ �����մϴ�.
    
    �⺻ ��¥ ǥ�������� DD(��)-MON(��)-RR(��)
    RR/MM/DD
*/
SELECT last_name, job_id, department_id 
FROM employees
WHERE last_name = 'Whalen';

SELECT last_name, hire_date
FROM employees
WHERE hire_date = '03/06/17';

/*
�� ������
    Ư�� ǥ������ �ٸ����̳� ǥ�ǰ� ���Ѵ� ���ǿ��� ���˴ϴ�.
    
    =  ����
    >  ���� ŭ
    >= ���� ũ�ų� ����
    <  ���� ����
    <= ���� �۰ų� ����
    <> ���� ����
    BETWEEN ... AND ...    �ΰ� ����(��谪 ����)
    IN(set)                �� ����Ʈ �� ��ġ�ϴ� �� �˻�
    LIKE                   ��ġ�ϴ� ���� ���� �˻�
    IS NULL                NULL ������ ����
*/
-- �� ������ ���
SELECT last_name, salary
FROM employees
WHERE salary <= 3000;

-- BETWEEN �����ڸ� ����ϴ� ���� ����
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 3500;

SELECT last_name, salary
FROM employees
WHERE salary >= 2500
AND salary <= 3500;

-- IN �����ڸ� ����ϴ� ��� ����
SELECT employee_id, last_name, salary, manager_id
FROM employees
WHERE manager_id IN (100, 101, 201);

SELECT employee_id, last_name, salary, manager_id
FROM employees
WHERE manager_id = 100
OR manager_id = 101
OR manager_id = 201;

/*
LIKE �����ڸ� ����Ͽ� ���� ��ġ
    LIKE �����ڸ� ����Ͽ� ��ȿ�� �˻� ���ڿ� ���� ��ü ���� �˻��� �����մϴ�.
    �˻� ���ǿ��� ���ͳ� ���ڳ� ���ڰ� ȣ�Ե� �� �ֽ��ϴ�.
    - %(�ۼ�Ʈ) : 0�� �̻��� ���ڸ� ��Ÿ���ϴ�.
    - _ : �� ���ڸ� ��Ÿ���ϴ�.
*/
SELECT first_name
FROM employees
WHERE first_name LIKE 'A%';

-- ��ü ���� ����
SELECT first_name
FROM employees
WHERE first_name LIKE '_o%';

-- ESCAPE �ĺ��� (Ư�� ����� ���ְ� ���ڷ� �ν��� �� �ְ� ���ش�)
SELECT employee_id, last_name, job_id
FROM employees
WHERE job_id LIKE '%SA\_%' ESCAPE '\';

/*
NULL ���� ���
    IS NULL �����ڷ� NULL�� �׽�Ʈ �մϴ�.
*/
SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL;

/*
�� �����ڸ� ����Ͽ� ��������
    AND : ���� ��� ������ ��� ���� ��� TRUE ��ȯ
    OR  : ���� ��� ���� �� �ϳ��� ���� ��� TRUE ��ȯ
    NOT : ������ ������ ��� TRUE�� ��ȯ
*/
 
-- AND ������ ���
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
AND job_id LIKE '%MAN%';

-- OR ������ ���
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
OR job_id LIKE '%MAN%';

-- NOT ������ ���
SELECT last_name, job_id
FROM employees
WHERE job_id NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');























