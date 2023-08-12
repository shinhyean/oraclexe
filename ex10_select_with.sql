/*
���ϸ� : ex10_select_with.sql

WITH ��
    WITH ���� �������� ����� �ӽ÷� �����ϰ� ����� �� �ִ� ����Դϴ�.
    �������̺�ǥ���� CTE(Common Table Expression)
    
    �ַ� ������ ������ �����ϰ� �ۼ��ϰų� �������� ���̴µ� Ȱ��˴ϴ�.
*/

-- �μ��� ��� �޿��� ����ϴ� ����
WITH AvgSalByDept AS (
    SELECT 
        department_id,
        AVG(salary) AS avgsalary
    FROM employees
    GROUP BY department_id
)
SELECT d.department_name, AvgSalByDept.avgsalary
FROM departments d
JOIN AvgSalByDept
ON d.department_id = AvgSalByDept.department_id
;

WITH AvgSalByDept AS (
    SELECT 
        department_id,
        AVG(salary) AS avgsalary
    FROM employees
    GROUP BY department_id
)
SELECT d.department_name, AvgSalByDept.avgsalary
FROM departments d
JOIN AvgSalByDept
ON d.department_id = AvgSalByDept.department_id
AND d.department_id = 10

UNION ALL
SELECT d.department_name, AvgSalByDept.avgsalary
FROM departments d
JOIN AvgSalByDept
ON d.department_id = AvgSalByDept.department_id
AND d.department_id = 20;

-- WITH ���� ���� ǥ��
WITH RecursiveCTE (id, name, manager_id, depth) AS(
    SELECT employee_id, last_name, manager_id, 0
    FROM employees
    WHERE manager_id IS NULL -- �ֻ��� �Ŵ��� (���̺� employees���� �Ŵ��� ���̵� 0�̸� SELECT�� ����) ���๮(100	King	null	0)
    UNION ALL -- select������ ��ģ��.
    SELECT e.employee_id, e.last_name, e.manager_id, rc.depth + 1
    FROM employees e
    INNER JOIN RecursiveCTE rc ON e.manager_id = rc.id
)
select id, name, manager_id, depth
from RecursiveCTE;

