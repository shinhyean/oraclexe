/*
파일명 : ex07_select_join.sql

JOIN 
    SQL에서 두 개 이상의 테이블에서 관련된 행들을 결합하기 위한 연산
*/

/*
Natural Join
    두 테이블에서 데이터 유형과 이름이 일치하는 열을 기반으로 자동으로
    테이블을 조인할 수 있습니다.
*/
SELECT department_id, department_name,
        location_id, city
FROM departments
NATURAL JOIN locations;





















