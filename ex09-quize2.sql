-- 1. �� ������ ��(last_name)�� �ش� ������ �Ŵ����� ������ ��(last_name) ��ȸ�ϱ�
SELECT e.last_name AS ����_��,
       m.last_name AS �Ŵ���_��
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id;

-- 2. �� ������ ��(last_name)�� �ش� ������ �μ� �̸�(department_name) ��ȸ�ϱ�
SELECT e.last_name AS ����_��,
       d.department_name AS �μ�_�̸�
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- 3. �� �μ��� �̸�(department_name)�� �ش� �μ��� ��� �޿�(avg_salary) ��ȸ�ϱ�
SELECT d.department_name AS �μ�_�̸�,
       AVG(e.salary) AS ���_�޿�
FROM departments d
JOIN employees e ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 4. �� �μ��� �̸�(department_name)�� �ش� �μ��� �ִ� �޿�(max_salary) ��ȸ�ϱ�
SELECT d.department_name AS �μ�_�̸�,
       MAX(e.salary) AS �ִ�_�޿�
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;


-- 5. �� ������ ��(last_name)�� �ش� ������ ���� �μ��� �ּ� �޿�(min_salary) ��ȸ�ϱ�
-- ���������� ������ �ȴ�.
SELECT oe.last_name, od.min_salary
FROM employees oe
JOIN(
    SELECT d.department_id, MIN(e.salary) AS min_salary
    FROM departments d
    JOIN employees e ON e.department_id = d.department_id
    GROUP BY d.department_id
    ) od
ON oe.department_id = od.department_id;

-- 6. �� �μ��� �̸�(department_name)�� �ش� �μ��� ���� ���� �� ���� ���� �޿�(highest_salary) ��ȸ�ϱ�
SELECT d.department_name AS �μ�_�̸�,
       MAX(e.salary) AS highest_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

-- 7. �� ������ ��(last_name)�� �ش� ������ �Ŵ����� ��(last_name) �� �μ� �̸�(department_name) ��ȸ�ϱ�
SELECT e.last_name AS ����_��,
       m.last_name AS �Ŵ���_��,
       d.department_name AS �μ�_�̸�
FROM employees e
JOIN employees m ON e.manager_id = m.employee_id
JOIN departments d ON e.department_id = d.department_id;

-- 8. �� ������ ��(last_name)�� �ش� ������ ���� �μ��� �Ŵ����� ��(last_name) ��ȸ�ϱ�
SELECT e.last_name AS ����_��,
       m.last_name AS �Ŵ���_��
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN employees m ON d.manager_id = m.employee_id;

-- �����
SELECT oe.last_name AS W_LAST_NAME, om.last_name  AS M_LAST_NAME
FROM(
    SELECT e.last_name, d.department_id, d.manager_id
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
) oe
JOIN employees om ON oe.manager_id = om.employee_id;

-- 9. �� ������ ��(last_name)�� �ش� ������ ���� ��簡 �ִ� ��� ���� ����� ��(last_name) ��ȸ�ϱ�
SELECT e1.last_name AS ����_��,
       e2.last_name AS ����_���_��
FROM employees e1
JOIN employees e2 ON e1.manager_id = e2.employee_id;

-- 10. ������ �߿��� �޿�(salary)�� 10000 �̻��� �������� ��(last_name)�� �ش� ������ �μ� �̸�(department_name) ��ȸ�ϱ�
SELECT e.last_name AS ����_��,
       d.department_name AS �μ�_�̸�,
       e.salary AS �޿�
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary >= 10000
ORDER BY e.salary DESC;

/*
11.
�� �μ��� �̸�(department_name), �ش� �μ��� �Ŵ����� ID(manager_id)�� �Ŵ����� ��(last_name),
������ ID(employee_id), ������ ��(last_name), �׸��� �ش� ������ �޿�(salary) ��ȸ�ϱ�.
�������� �޿�(salary)�� �ش� �μ��� ��� �޿����� ���� �������� ��ȸ�մϴ�.
����� �μ� �̸��� ������ �޿��� ���� ������ ���ĵ˴ϴ�.
*/
SELECT d.department_name AS �μ�_�̸�,
       e1.manager_id AS �Ŵ���_ID,
       e1.last_name AS �Ŵ���_��,
       e2.employee_id AS ����_ID,
       e2.last_name AS ����_��,
       e2.salary AS ����_�޿�
FROM departments d
JOIN employees e1 ON d.department_id = e1.department_id
JOIN employees e2 ON e1.manager_id = e2.employee_id
WHERE e2.salary > (
    SELECT AVG(salary)
    FROM employees e3
    WHERE e3.department_id = d.department_id
)
ORDER BY d.department_name, e2.salary DESC;

SELECT d.department_name AS �μ�_�̸�,
       d.manager_id AS �Ŵ���_ID,
       m.last_name AS �Ŵ���_��,
       e.employee_id AS ����_ID, 
       e.last_name AS ����_��, 
       e.salary AS ����_�޿�
FROM departments d
JOIN employees m ON d.manager_id = m.employee_id
JOIN employees e ON e.department_id = d.department_id
--WHERE 1 = 1
WHERE e.salary > (
            -- �� �μ��� ��� �޿�
            SELECT AVG(e1.salary)
            FROM employees e1
            WHERE e1.department_id = d.department_id
            )
ORDER BY d.department_name, e.salary DESC;

-- ���μ��� ��� �޿��� GROUP BY�� ��� 
SELECT d.department_name AS �μ�_�̸�,
       d.manager_id AS �Ŵ���_ID,
       m.last_name AS �Ŵ���_��,
       e.employee_id AS ����_ID, 
       e.last_name AS ����_��, 
       e.salary AS ����_�޿�
       --, da.Avg_Salary
FROM departments d
JOIN employees m ON d.manager_id = m.employee_id
JOIN employees e ON e.department_id = d.department_id
JOIN(
     SELECT department_id, AVG(salary) AS Avg_Salary
     FROM employees
     GROUP BY department_id
) da
ON d.department_id = da.department_id
WHERE e.salary > da.Avg_Salary
ORDER BY d.department_name, e.salary DESC;