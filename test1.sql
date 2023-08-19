CREATE TABLE test1 AS
SELECT employee_id empno, last_name name, salary, department_id depno
FROM employees;

select * from test1;

CREATE OR REPLACE PROCEDURE update_emp_salary_proc1(eno IN NUMBER) -- eno IN NUMBER (�÷�����)
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


EXEC update_emp_salary_proc1(60); -- depno �÷��� ���� eno�� ���� �״����� ���� ���� ���ν����� ���� BEGIN ����


DROP TABLE test1;
DROP PROCEDURE update_emp_salary_proc1; -- ���ν��� ����