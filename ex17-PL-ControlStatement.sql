/*
프로시저 제어문
*/

-- 1. 반복문

SET serveroutput ON;
-- FOR LOOP
/*
FOR index in [REVERSE] 시작값 .. END값 LOOP
    STATEMENT 1
    STATEMENT 2
    ...
END LOOP;

*/
BEGIN
	FOR I IN 1..4 LOOP
	  	IF MOD(I, 2) = 0 THEN 
			dbms_output.put_line( I || '는 짝수!!');
		ELSE
			dbms_output.put_line( I || '는 홀수!!');
		END IF;
	END LOOP;
END;
/


-- 간단한 FOR 문안에 SELECT 문이 오는 예제
SET serveroutput ON;
BEGIN
	FOR NUM_LIST IN 
    (
        SELECT 1 AS NUM FROM DUAL
        UNION ALL
        SELECT 2 AS NUM FROM DUAL
        UNION ALL
        SELECT 3 AS NUM FROM DUAL
        UNION ALL
        SELECT 4 AS NUM FROM DUAL
    )
    LOOP
	  	if mod(NUM_LIST.NUM, 2) = 0 then 
			dbms_output.put_line( NUM_LIST.NUM || '는 짝수!!');
		else
			dbms_output.put_line( NUM_LIST.NUM || '는 홀수!!');
		end if;
	END LOOP;
END;
/

-- LOOP문
/*

LOOP 
    PL/SQL STATEMENT 1
       다른 LOOP를 포함하여 중첩으로 사용 가능
    EXIT [WHEN CONDITION]
END LOOP;

*/


SET serveroutput ON;

DECLARE
    v_num NUMBER := 6; -- 시작숫자
    v_tot_num NUMBER := 0; -- 총 loop수 반환 변수
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('현재 숫자 : ' || v_num);
        v_num := v_num + 1;
        v_tot_num := v_tot_num + 1;
        EXIT WHEN v_num > 6;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(v_tot_num || '번의 LOOP');

END;
/


-- WHILE LOOP문
SET serveroutput ON;

DECLARE
    v_num NUMBER := 6; -- 시작숫자
    v_tot_num NUMBER := 0; -- 총 loop수 반환 변수
BEGIN
    WHILE v_num < 11 LOOP
        DBMS_OUTPUT.PUT_LINE('현재 숫자 : ' || v_num);
        v_num := v_num + 1;
        v_tot_num := v_tot_num + 1;
        
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(v_tot_num || '번의 LOOP');

END;
/


-- 2. 제어문

-- IF문
/*
IF 조건1 THEN
    처리문1
ELSE IF 조건2 THEN
    처리문2
    ...
ELSE
    처리문
END IF;

*/

DECLARE
    v_score NUMBER := 79;
BEGIN
  IF v_score >= 90 THEN
    DBMS_OUTPUT.PUT_LINE('점수 : ' || v_score || ', 등급 : A');
  ELSIF v_score >= 80 THEN
    DBMS_OUTPUT.PUT_LINE('점수 : ' || v_score || ', 등급 : B');
  ELSIF v_score >= 70 THEN
    DBMS_OUTPUT.PUT_LINE('점수 : ' || v_score || ', 등급 : C');
  ELSIF v_score >= 60 THEN
    DBMS_OUTPUT.PUT_LINE('점수 : ' || v_score || ', 등급 : D');
  ELSE
    DBMS_OUTPUT.PUT_LINE('점수 : ' || v_score || ', 등급 : F');
  END IF;
END;
/


-- CASE문
/*

CASE WHEN 조건1 THEN
    처리문1
WHEN 조건2 THEN
    처리문2
    ...
ELSE
    처리문
END CASE;

*/

DECLARE
    v_grade     CHAR(1) := 'C';
    v_appraisal VARCHAR2(20) ;
BEGIN
  v_appraisal := CASE v_grade
  					WHEN 'A' THEN 'Excellent'
  					WHEN 'B' THEN 'Very Good'
					WHEN 'C' THEN 'Good'
					ELSE 'No such grade'
  				 END;
  DBMS_OUTPUT.PUT_LINE ('Grade : '|| v_grade) ;
  DBMS_OUTPUT.PUT_LINE ('Appraisal: '|| v_appraisal);
END;
/


CREATE OR REPLACE PROCEDURE update_salaries(p_percentage IN NUMBER) IS
BEGIN
    FOR emp_rec IN (SELECT employee_id, salary FROM employees) LOOP
        IF emp_rec.salary > 5000 THEN
            UPDATE employees
            SET salary = salary + (salary * (p_percentage / 100))
            WHERE employee_id = emp_rec.employee_id;
        END IF;
    END LOOP;
    COMMIT;
END;
/
--100	26400
SELECT employee_id, salary FROM employees
WHERE salary > 5000;

execute update_salaries(10);



