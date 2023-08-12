/*
파일명 : ex09_select_hierarchical.sql

----------------오라클에서 씀----------------

계층쿼리
    트리 구조를 가지는 데이터에서 부모-자식 관계를 쉽게 쿼리하는데 사용되는 SQL
    주로 조직도, 계층적 데이터, 계층적 주소 등에 활용됩니다.

관련 키워드
    START WITH : 계층 쿼리의 시작 지점을 지정합니다. 최상위 부모 노드를 선택합니다.
    CONNECT BY : 부모-자식 관계를 설정하는 키워드로, PRIOR 키워드와 함께 사용됩니다.
    PRIOR : 부모-자식 관계를 표현하는 키워드로 자식 컬럼앞에 사용됩니다.
    NOCYCLE : 사이클을 허용하지 않도록 설정하는 옵션 입니다.
    LEVEL : 각 레벨의 깊이를 나타내는 의사 컬럼으로 사용됩니다.
    SYS_CONNECT_BY_PATH : 계층 구조의 경로를 문자열로 표현해주는 함수입니다.
    ORDER SIBLINGS BY : 형제 노드들을 정렬하는데 사용합니다.
*/

-- id, name, manager_id, depth

SELECT 
    e.employee_id,
    e.last_name,
    e.manager_id,
    LEVEL AS depth,
    LPAD(' ', LEVEL*2-2) || SYS_CONNECT_BY_PATH(e.last_name, '/') AS hierarchy_path -- LPAD(' ', LEVEL*2-2) : 칸 뛰우기
FROM
    employees e
START WITH
    e.manager_id IS NULL
CONNECT BY
    PRIOR e.employee_id =  e.manager_id
ORDER SIBLINGS BY e.employee_id;

-- NOCYCLE 사이클을 허용하지 않도록 설정(무한루프방지)
SELECT * FROM employees
WHERE manager_id IS NULL;

UPDATE employees SET
manager_id = 100
WHERE employee_id = 100;

COMMIT;

