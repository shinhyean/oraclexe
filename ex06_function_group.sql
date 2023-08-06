/*
���ϸ� : ex06_function_group.sql
*/

-- ������(�׷�) �Լ�

-- AVG() - ���
-- MAX() - �ִ밪
-- MIN() - �ּҰ�
-- SUM() - �հ�
SELECT AVG(salary) AS avg_salary,
       MAX(salary) AS max_salary,
       MIN(salary) AS min_salary,
       SUM(salary) AS sum_salary
FROM employees
WHERE job_id LIKE '%REP%';

-- COUNT() �Լ� - null ���� �ƴ� ��� ���� ������ ��ȯ�մϴ�.
SELECT COUNT(*) AS total_employees
FROM employees
WHERE department_id = 50;

SELECT COUNT(1) AS total_employees
FROM employees
WHERE department_id = 50;

-- null�� ������ �־ COUNT�� �о� ������ ���Ѵ�.(NULL���̶� �Ҽ������� �����ؾ� �ȴ�. ��ǻ�Ͱ� �о� ������ ���� ���� �ִ�)
SELECT COUNT(commission_pct) AS non_null_commission_count 
FROM employees
WHERE department_id = 50;

-- COUNT(DISTINCT expr)�� Ư�� ǥ������ �������� �ߺ��� ������ ���� ���� ��ȯ�մϴ�.
SELECT COUNT(DISTINCT department_id) AS distinct_department_count -- null���� ������ ������ ����Ѵ�.
FROM employees;

-- NVL �Լ��� Ȱ���Ͽ� NULL ���� �ٸ� ������ ��ü�� �� AVG() �Լ� ���
SELECT AVG(NVL(commission_pct, 0)) AS avg_commission -- null���� �־ �����Ҽ� �ִ� ������
FROM employees;

/*
GROUP BY
    ���� ���� ������ �÷� �������� �׷�ȭ�Ͽ� ���� �Լ��� �����ϱ� ���� ����
    
HAVING
    GROUP BY�� �Բ� ���Ǹ�, �׷�ȭ�� ����� ������ ������ �� ���˴ϴ�.
    
    WHERE - �������� ����
    HAVING - �׷��� ����
*/

-- �μ��� ��� �޿��� ���մϴ�.
SELECT department_id, ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY department_id;

-- GROUP BY ������ ���� ���� �������� �׷�ȭ �մϴ�.
SELECT department_id, job_id, SUM(salary) AS total_salary
FROM employees
WHERE department_id > 40
GROUP BY department_id, job_id
ORDER BY department_id ASC;

-- HAVING �� ���

-- �μ��� �ִ� �޿��� 10000���� ū �μ��� ã���ϴ�.
SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id 
HAVING MAX(salary) > 10000;

-- ������ �� �޿��� 13000���� ū ������ ã���ϴ�.
SELECT job_id, SUM(salary) AS total_salary
FROM employees
WHERE job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING SUM(salary) > 13000
ORDER BY SUM(salary); -- ORDER BY SUM(salary); == ORDER BY total_salary;

-- �׷��Լ� �Լ���ø ����
SELECT MAX(AVG(salary)) AS max_avg_salary
FROM employees
GROUP BY department_id;


































