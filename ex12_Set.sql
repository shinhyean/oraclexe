/*
���ϸ� : ex12_Set.sql
���� ������
    ���� ���̺� �Ǵ� ������ ����� �����ϰ� �����ϴ� ������.
    SELECT ����Ʈ�� ǥ������ �÷� ������ ��ġ�ؾ��մϴ�.
    
    UNION, UNION ALL, INTERSECT, MINUS
*/

-- UNION ������ : �� ���� ���� ����� ��ġ��, �ߺ��� ���� �����մϴ�.(�Ʒ��� ���� ��ģ��.)
SELECT employee_id, job_id
FROM employees
UNION
SELECT employee_id, job_id
FROM job_history
ORDER BY employee_id;

-- UNION ALL ������ : �� ���� ���� ����� ��ġ��, �ߺ��� ���� �����Ͽ� ��� ��ȯ�մϴ�.(�Ʒ��� ���� ��ģ��.)
SELECT employee_id, job_id
FROM employees
UNION ALL
SELECT employee_id, job_id
FROM job_history
ORDER BY employee_id;

-- INTERSECT ������ : �� ���� ���� ��� �߿��� ����� �ุ ��ȯ�մϴ�.(JOIN���� ����� ����)
SELECT employee_id, job_id
FROM employees
INTERSECT
SELECT employee_id, job_id
FROM job_history
ORDER BY employee_id;

-- MINUS ������ : ù��° ���� ��� �߿��� �ι�° ���� ����� �������� �ʴ� �ุ ��ȯ�մϴ�.(�÷� ���� �¾ƾ� ������ ���� �۵��Ѵ�.)
SELECT employee_id, job_id
FROM employees
MINUS
SELECT employee_id, job_id
FROM job_history
ORDER BY employee_id;

DESC employees;

-- !> ������(Ÿ��) ���� ��ġ���Ѿ� �մϴ�.
-- �������� ���� �� ���̺��� Ư�� �÷����� UNION�Ͽ� ��������
SELECT location_id, department_name AS "Department", TO_CHAR(NULL) "Warehouse location"
FROM departments
UNION
SELECT location_id, TO_CHAR(NULL) AS "Department", state_province
FROM locations;

SELECT employee_id, job_id, salary
FROM employees
UNION
SELECT employee_id, job_id, 0
FROM job_history;
