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





















