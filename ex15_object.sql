/*
���ϸ� : ex15_object.sql

�����ͺ��̽� ��ü(Database Objects)
    ���̺�(Table) : �⺻ ��������̸� ������ �����Ǿ� �ֽ��ϴ�.
    ��(View)    : �ϳ� �̻��� ���̺� �ִ� �������� �κ������� �������� ��Ÿ���ϴ�. (��� �����δ� �������� �ʴ� ������ ������ ���̺�)
    ������ : �Ϸ��� ���ڸ� �ڵ����� �������ִ� ��ü�Դϴ�.
    �ε���(Index) : ���̺��� �����Ϳ� ���� �����˻��� �������ִ� ���� ��ü�Դϴ�. �������� ���Ἲ�� ���ؼ��� ���˴ϴ�.
    ���Ǿ� : ��ü�� �ٸ� �̸��� �ο��մϴ�.

*/

-- �� ����
CREATE VIEW empvu80
AS SELECT employee_id, last_name, salary
    FROM employees
    WHERE department_id = 80;
    
DESC empvu80;

SELECT * FROM empvu80;

-- alias ��� �� ����
CREATE VIEW salvu50
AS SELECT employee_id AS ID_NUMBER, last_name name, salary*12 ANN_SALARY
    FROM employees
    WHERE department_id = 50;
    
SELECT * FROM salvu50
WHERE ann_salary >= 50000;