/*
���ϸ� : ex07_select_join.sql

JOIN 
    SQL���� �� �� �̻��� ���̺��� ���õ� ����� �����ϱ� ���� ����
*/

/*
Natural Join
    �� ���̺��� ������ ������ �̸��� ��ġ�ϴ� ���� ������� �ڵ�����
    ���̺��� ������ �� �ֽ��ϴ�.
*/
SELECT department_id, department_name,
        location_id, city
FROM departments
NATURAL JOIN locations;

/*
USING ���� ����
*/
SELECT employee_id, last_name,
        location_id, department_id
FROM employees JOIN departments
USING (department_id);

/*
ON ���� ����
    ON ���� ����Ͽ� ���� ������ �����մϴ�.
*/
SELECT e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id
FROM employees e JOIN departments d -- ��Ī�� �ټ� �ִ�
ON (e.department_id = d.department_id);

SELECT e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id
FROM employees e INNER JOIN departments d
ON (e.department_id = d.department_id);

-- join on�� �����ϱ�
SELECT e.employee_id, e.last_name, 
        e.department_id, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id;

-- ON ���� �ƿ��Ͽ� 3-Way ����
SELECT e.employee_id, e.last_name, e.first_name, l.city, d.department_name
FROM employees e 
JOIN departments d
ON (e.department_id = d.department_id)
JOIN locations l
ON (l.location_id = d.location_id);

-- ���ο� �߰� ���� ����
SELECT e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id, e.manager_id
FROM employees e JOIN departments d
ON e.department_id = d.department_id
AND e.manager_id = 149;

SELECT e.employee_id, e.last_name, e.department_id,
        d.department_id, d.location_id, e.manager_id
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE e.manager_id = 149;

/*
���̺� ��ü ����
    ON ���� ����ϴ� Self Join
*/

SELECT worker.last_name emp, manager.last_name mgr
FROM employees worker JOIN employees manager
ON worker.manager_id = manager.employee_id;


/*
NonequiJoin
    ��ȣ ������ �ܿ� �ٸ� �����ڸ� �����ϴ� ���� �����Դϴ�.


CREATE TABLE job_grades(
grade_level CHAR(1),
lowest_sal NUMBER(8,2) NOT NULL,
highest_sal NUMBER(8,2) NOT NULL
);

ALTER TABLE job_grades
ADD CONSTRAINT jobgrades_grade_pk PRIMARY KEY (grade_level);

INSERT INTO job_grades VALUES('A', 1000, 2999);
INSERT INTO job_grades VALUES('B', 3000, 5999);
INSERT INTO job_grades VALUES('C', 6000, 9999);
INSERT INTO job_grades VALUES('D', 10000, 14999);
INSERT INTO job_grades VALUES('E', 15000, 24999);
INSERT INTO job_grades VALUES('F', 25000, 40000);

COMMIT;
*/
SELECT e.last_name, e.salary, j.grade_level
FROM employees e JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;


/*
INNER JOIN�� OUTER JOIN

    INNER JOIN
        ��ġ���� �ʴ� ���� ��¿� ǥ�õ��� �ʽ��ϴ�. (������ �ش� �� ���)
    
    OUTER JOIN
        �� ���̺��� ���� ������� �ٸ� ���̺���� ������ ���� ����� �����Ͽ� ��ȯ�մϴ�.
*/

/*
LEFT OUTER JOIN
    DEOARTMENTS ���̺� �����Ǵ� ���� ���
    ���� ���̺��� EMPLOYEES ���̺��� ��� ���� �˻��մϴ�.(NULL���� ��ȸ�� �ȴ�.)
*/
-- ANSI ǥ��
SELECT e.last_name, e.department_id, d.department_name
FROM employees e 
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id;

-- LEFT OUTER JOIN�� ������� �ʾ�����
SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id = d.department_id(+);

-- JOIN : NULL���� ��ȸ�� �ȵȴ�.
SELECT e.last_name, e.department_id, d.department_name
FROM employees e 
JOIN departments d -- JOIN = INNER JOIN �� ����. 
ON e.department_id = d.department_id;

/*
RIGHT OUTER JOIN
    EMPLOYEES ���̺� �����Ǵ� ���� ���
    ������ ���̺��� DEOARTMENTS ���̺��� ��� ���� �˻��մϴ�.(NULL���� ��ȸ�� �ȴ�.)
*/
SELECT e.last_name, e.department_id, d.department_name
FROM employees e 
RIGHT OUTER JOIN departments d
ON e.department_id = d.department_id;

/*
FULL OUTER JOIN
    DEOARTMENTS, EMPLOYEES ���̺� �����Ǵ� ���� ���
    ���̺��� ������� �˻��մϴ�.
*/
SELECT e.last_name, e.department_id, d.department_name
FROM employees e 
FULL OUTER JOIN departments d
ON e.department_id = d.department_id;

/*
Cartesian Product
    ���� ������ �߸��ǰų� ������ ������ ��� ����� ��� ���� ������ ǥ�õǴ� 
    Cartesian Product�� ��Ÿ���ϴ�.
*/

/*
CROSS JOIN
    �� ���̺��� ���� ���� �����մϴ�.
*/
SELECT last_name, department_name
FROM employees 
CROSS JOIN departments;







































