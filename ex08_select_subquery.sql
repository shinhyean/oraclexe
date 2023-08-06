/*
���ϸ� : ex08_select_subquery.sql
Subquery ����
    �ٸ� SELECT ���� ���ԵǴ� SELECT �� �Դϴ�.
*/

-- ������ Subquery ����
SELECT last_name, salary
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Abel');

-- Subquery���� �׷� �ռ� ���
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);

/*
���� �� Subquery
    IN
        ����Ʈ ���� ����� ����
    ANY
        =, <>, >, <, <=, >= �����ڰ� �տ� �־�� �մϴ�.
        < ANY�� �ִ밪���� ������ �ǹ��մϴ�.
        > ANY�� �ּҰ����� ŭ�� �ǹ��մϴ�.
        = ANY�� IN�� �����ϴ�.
    ALL
        > ALL�� �ִ밪���� ŭ�� �ǹ��մϴ�.
        < ALL�� �ּҰ����� ������ �ǹ��մϴ�.
*/

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY(SELECT salary FROM employees WHERE job_id = 'IT_PROG') -- 9000���� ���� ����� �˻�
AND job_id <> 'IT_PROG';

/*
9000
6000
4800
4800
4200
*/

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary > ALL(SELECT salary FROM employees WHERE job_id = 'IT_PROG') -- 9000���� ū ����� �˻�
AND job_id <> 'IT_PROG';

/*
EXISTS ������
    Subquery���� �ּ��� �� ���� ���� ��ȯ�ϸ� TRUE�� �򰡵˴ϴ�.
*/
SELECT * FROM departments
WHERE NOT EXISTS
                (SELECT * FROM employees 
                WHERE employees.department_id = departments.department_id);

SELECT * FROM departments
WHERE department_id NOT IN
                (SELECT department_id FROM employees 
                WHERE employees.department_id = departments.department_id);
                
/*
Subquery�� null��
    ��ȯ�� �� �� �ϳ��� null ���̸� ��ü query�� ���� ��ȯ���� �ʽ��ϴ�.
    null ���� ���ϴ� ��� ������ ����� null�̱� �����Դϴ�.
*/

SELECT emp.last_name
FROM employees emp
WHERE emp.employee_id NOT IN(SELECT mgr.manager_id FROM employees mgr);

SELECT emp.last_name
FROM employees emp
WHERE emp.employee_id IN(NULL, 100,102,103);