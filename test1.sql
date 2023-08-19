CREATE TABLE test1 AS
SELECT employee_id empno, last_name name, salary, department_id depno
FROM employees;

select * from test1;

CREATE OR REPLACE PROCEDURE update_emp_salary_proc1(eno IN NUMBER) -- eno IN NUMBER (컬럼선언)
    IS
    BEGIN
        UPDATE test1 SET salary = salary* 1.1
        WHERE depno = eno;
        COMMIT;
    END;
/

/*
9000
6000
4800
4800
4200
*/
select * from test1
WHERE depno = 60;


EXEC update_emp_salary_proc1(60); -- depno 컬럼의 값을 eno에 저장 그다음에 내가 만든 프로시저로 가서 BEGIN 실행


DROP TABLE test1;
DROP PROCEDURE update_emp_salary_proc1; -- 프로시저 삭제