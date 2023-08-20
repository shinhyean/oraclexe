/*
CURSOR 
 데이터베이스에서 조회한 결과 집합을 가리키며, 
 이를 통해 결과 집합을 반복적으로 처리하거나 
 데이터를 조작하는 등의 작업을 수행할 수 있습니다.

암시적 커서
    SQL 문장을 실행하면 자동으로 생성되는 커서입니다. 
    주로 단일 값 조회나 작은 결과셋에 사용되며, 개발자가 커서를 명시적으로 
    선언하지 않아도 자동으로 생성되므로 간단한 조회 작업에 용이합니다.


 - SQL%FOUND     : 해당 SQL문에 의해 반환된 총 행수가 1개 이상일 경우TRUE (BOOLEAN)
 - SQL%NOTFOUND  : 해당 SQL문에 의해 반환된 총 행수가 없을 경우 TRUE (BOOLEAN)
 - SQL%ISOPEN    : 항상 FALSE, 암시적 커서가 열려 있는지의 여부 검색
                    ( PL/SQL은 실행 후 바로 묵시적 커서를 닫기 때문에 항상 상 false)
 - SQL%ROWCOUNT  : 해당 SQL문에 의해 반환된 총 행수, 가장 최근 수행된 SQL문에 의해 영향을 받은 행의 갯수(정수)
 

*/

SET SERVEROUTPUT ON;
DECLARE
    BEGIN
    DELETE FROM emp WHERE department_id = 10;
    DBMS_OUTPUT.PUT_LINE('처리 건수 : ' || TO_CHAR(SQL%ROWCOUNT)|| '건');
    END;
/

/*

 

명시적 커서
    개발자가 직접 정의하고 열고, 
    데이터베이스 쿼리 결과를 사용자 지정된 변수에 할당하며, 처리합니다. 
    명시적 커서는 명시적으로 열리고 닫히며 데이터 처리를 완전히 제어할 수 있는 장점이 있습니다.

   - %ROWCOUNT : 현재까지 반환된 모든 행의 수를 출력
   - %FOUND : FETCH한 데이터가 행을 반환하면 TRUE
   - %NOTFOUND : FETCH한 데이터가 행을 반환하지 않으면 TRUE (LOOP를 종료할 시점을 찾는다)
   - %ISOPEN : 커서가 OPEN되어있으면 TRUE

https://goddaehee.tistory.com/117
*/


CREATE OR REPLACE PROCEDURE retrieve_high_salaries(p_min_salary IN NUMBER) IS
    CURSOR emp_cursor IS
        SELECT employee_id, first_name, last_name, salary
        FROM employees
        WHERE salary >= p_min_salary;
    
    emp_record emp_cursor%ROWTYPE;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO emp_record;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_record.employee_id ||
                             ', Name: ' || emp_record.first_name || ' ' || emp_record.last_name ||
                             ', Salary: ' || emp_record.salary);
    END LOOP;
    CLOSE emp_cursor;
END;
/
