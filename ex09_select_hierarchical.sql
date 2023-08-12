/*
���ϸ� : ex09_select_hierarchical.sql

----------------����Ŭ���� ��----------------

��������
    Ʈ�� ������ ������ �����Ϳ��� �θ�-�ڽ� ���踦 ���� �����ϴµ� ���Ǵ� SQL
    �ַ� ������, ������ ������, ������ �ּ� � Ȱ��˴ϴ�.

���� Ű����
    START WITH : ���� ������ ���� ������ �����մϴ�. �ֻ��� �θ� ��带 �����մϴ�.
    CONNECT BY : �θ�-�ڽ� ���踦 �����ϴ� Ű�����, PRIOR Ű����� �Բ� ���˴ϴ�.
    PRIOR : �θ�-�ڽ� ���踦 ǥ���ϴ� Ű����� �ڽ� �÷��տ� ���˴ϴ�.
    NOCYCLE : ����Ŭ�� ������� �ʵ��� �����ϴ� �ɼ� �Դϴ�.
    LEVEL : �� ������ ���̸� ��Ÿ���� �ǻ� �÷����� ���˴ϴ�.
    SYS_CONNECT_BY_PATH : ���� ������ ��θ� ���ڿ��� ǥ�����ִ� �Լ��Դϴ�.
    ORDER SIBLINGS BY : ���� ������ �����ϴµ� ����մϴ�.
*/

-- id, name, manager_id, depth

SELECT 
    e.employee_id,
    e.last_name,
    e.manager_id,
    LEVEL AS depth,
    LPAD(' ', LEVEL*2-2) || SYS_CONNECT_BY_PATH(e.last_name, '/') AS hierarchy_path -- LPAD(' ', LEVEL*2-2) : ĭ �ٿ��
FROM
    employees e
START WITH
    e.manager_id IS NULL
CONNECT BY
    PRIOR e.employee_id =  e.manager_id
ORDER SIBLINGS BY e.employee_id;

-- NOCYCLE ����Ŭ�� ������� �ʵ��� ����(���ѷ�������)
SELECT * FROM employees
WHERE manager_id IS NULL;

UPDATE employees SET
manager_id = 100
WHERE employee_id = 100;

COMMIT;

