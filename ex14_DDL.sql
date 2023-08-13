/*
파일명 : ex14_DDL.sql
DDL(Data Definition Language) - 데이터 정의어
    데이터베이스 내의 구조 및 객체(테이블, 시퀀스 .. 등)를 생성, 변경, 삭제하기 위해 사용되는 SQL문입니다.
*/

/*
CREATE TABLE 문
    데이터를 저장할 테이블을 생성합니다.
*/

CREATE TABLE dept(
    deptno NUMBER(6),
    dname VARCHAR2(200),
    loc VARCHAR2(200),
    create_date DATE DEFAULT SYSDATE
    );
    
DESC DEPT;

/*
데이터유형
    -- 1. 문자형 데이터 타입
    CHAR(size)
    고정 길이 문자 데이터 타입(최대 2000byte) - 지정된 길이보다 짧은 데이터가 입력될 시 나머지 공간은 공백으로 채워짐
    
    VARCHAR2(size)
    가변 길이 문자 데이터 타입(최대 4000byte) - 지정된 길이보다 짧은 데이터가 입력될 시 나머지 공간은 채우지 않는다.
    
    NCHAR(size)
    고정 길이 문자 유니코드 데이터 타입(최대 2000byte)
    
    NVARCHAR2(size)
    가변 길이 문자 유니코드 데이터 타입(최대 4000byte)
    
    LONG
    가변 길이 문자 데이터 타입(최대 2Gbyte)
    
    CLOB
    대용량 문자 데이터 타입(최대 4Gbyte)
    
    NCLOB
    대용량 문자 유니코드 데이터 타입(최대 4Gbyte)
    
    -- 2. 숫자형 데이터 타입
    BINARY_FLOAT
    부동 소수형 데이터 타입(4byte) - 32bit 부동 소수
    
    BINARY_DOUBLE
    부동 소수형 데이터 타입(4byte) - 64bit 부동 소수
    
    NUMBER(P,S)
    숫자 데이터
    P, S로 표현 가변 길이 숫자 데이터 타입 P: 1 ~ 38, S: -84 ~ 127 P(Precision): 유효자리수, S(Scale):소수점 유효자리
    
    -- 3. 날짜형 데이터 타입
    DATE
    고정 길이 날짜(날짜 및 시간 값)
    
    INTERVAL_YEAR
    날짜(년도, 월)형태의 기간 표현 데이터 타입
    
    INTERVAL_DAY
    날짜 및 시간(요일, 시, 분, 초)형태의 기간 표현 데이터 타입
    
    TIMESTAMP
    밀리초(ms)까지 표현 데이터 타입
    
    TIMESTAMP_WITH TIME ZONE
    날짜 및 시간대 형태의 데이터 타입
    
    TIMESTAMP_WITH LOCAL TIME ZONE
    저장 시 데이터베이스 시간대를 준수, 조회시 조회하는
    클라이언트 시간 표현 데이터 타입
    
    -- 4. 이진 데이터 타입
    RAW(size)
    가변 길이 이진 데이터 타입(최대 2Gbyte)
    
    LONGRAW
    가변 길이 이진 데이터 타입(최대 4Gbyte)
    
    BLOB
    대용량의 바이너리 데이터를 저장하기 위한 데이터 타입(최대 4Gbyte)
    
    BFILE
    파일위치와 메타데이터 저장
    대용량의 바이너리 데이터를 파일형태로 저장하기 위한 데이터 타입(최대 4Gbyte)
*/

-- departments 테이블을 dept에 데이터 복사하기
INSERT INTO dept
SELECT department_id, department_name, location_id, SYSDATE
FROM departments;

SELECT * FROM dept;

/*
CTAS "Create Tavle As Select" 의 약자로
데이터베이스에서 새로운 테이블을 생성하는 기법입니다.
이 기법은 기존 테이블에서 SELECT문을 사용하여 데이터를 조회한 후,
그 결과를 새로운 테이블로 생성하는 방법입니다.
*/

-- 테이블 복사하기 => 제약 조건은 복사가 안된다.
CREATE TABLE dept2 AS SELECT * FROM dept;
DESC dept2;

SELECT * FROM dept2;

-- 테이블 구조만 복사하기 (조건이 항상 거짓이 되는 편법사용)
CREATE TABLE dept3 AS SELECT * FROM dept WHERE 1=2;
DESC dept3;
SELECT * FROM dept3;

/*
ALTER 문
    데이터베이스 개체 구조나 속성을 변경할 때 사용되는 SQL 명령문입니다
    ALTER TABLE 테이블명 ADD(컬럼명1 데이터유형, 컬럼명2 데이터유형);
*/
CREATE TABLE simple(num NUMBER);

SELECT * FROM simple;

-- 컬럼 추가하기
ALTER TABLE simple ADD(name VARCHAR2(3));

-- 컬럼 수정하기
ALTER TABLE simple MODIFY(name VARCHAR2(30));

-- 컬럼 삭제하기
ALTER TABLE simple DROP COLUMN name;

ALTER TABLE simple ADD(addr VARCHAR2(50));
-- 컬럼 삭제하기2
ALTER TABLE simple DROP(addr);

DESC simple;

-- DROP 문 : 객체를 삭제할 때 사용되는 SQL명령문 입니다.
-- 테이블 삭제
DROP TABLE simple;

/*
제약 조건(Constraint)
    테이블의 해당컬럼에 원하지 않는 데이터를 입력/수정/삭제 되는 것을 방지하기
    위해 테이블 생성 또는 변경시 설정하는 조겁입니다.(저장된 데이터의 신뢰성 높이기 위함)
    
    NOT NULL
        NULL 로 입력이 되어스는 안되는 컬럼에 부여하는
        조건으로 컬럼 레벨에서만 부여할 수 있는 제약조겁입니다.
        
    UNIQUE KEY(유일키)
        저장된 값이 중복되지 않고 오직 유일하게 유지되어야 할 때
        사용하는 제약 조건입니다.(NULL이 혀용된다.)
        
    Primary Key(대표키, 기본키)
        NOT NULL 조건과 UNIQUE KEY를 합친 조건입니다.
        
    CHECK 
        조건에 맞는 데이터만 입력되도록 조건을 부여하는 제약조건입니다.
        
    Foreign Key(외래키, 참조기)
        부모 테이블의 Primary Key름 참조하는 컬럼에 붙이는 제약조건입니다.
*/

/*
-- DEFAULT에 null도 들어가는지 실험하기(성공 null도 들어감)
CREATE TABLE test(
    testno NUMBER(2) CONSTRAINT test_testno_pk PRIMARY KEY,
    dname VARCHAR2(15) DEFAULT NULL,
    loc CHAR(1) CONSTRAINT test_loc_ck CHECK(loc IN('1','2'))
    );
    
DESC test; 

SELECT * FROM test;

INSERT INTO test(testno, loc)
VALUES (1, '1');
*/

CREATE TABLE dept4(
    deptno NUMBER(2) CONSTRAINT dept4_deptno_pk PRIMARY KEY, -- CONSTRAINT 이름 PRIMARY KEY
    dname VARCHAR2(15) DEFAULT '영업부', -- DEFAULT '영업부' : insert 할때 아무것도 집어넣지 않았을때(null도 포함) '영업부'라고 값이 들어간다
    loc CHAR(1) CONSTRAINT dept4_loc_ck CHECK(loc IN('1','2')) -- CHECK(loc IN('1','2') : 1또는 2만 넣을수 있게한다
    );
    
SELECT * FROM dept4;

INSERT INTO dept4(deptno, dname, loc)
VALUES (1, null, '1');

-- ORA-00001: 무결성 제약 조건(HR.DEPT4_DEPTNO_PK)에 위배됩니다
INSERT INTO dept4(deptno, loc)
VALUES (1, '1');

INSERT INTO dept4(deptno, loc)
VALUES (2, '1');

-- ORA-02290: 체크 제약조건(HR.DEPT4_LOC_CK)이 위배되었습니다
INSERT INTO dept4(deptno, loc)
VALUES (3, '3');

-- 외래키를 만들기 위해서는 부모테이블 필요
-- 부모테이블 생성
CREATE TABLE dept5(
    deptno NUMBER(2) PRIMARY KEY, -- CONSTRAINT 이름 <- 생략가능
    dname VARCHAR2(15) NOT NULL
    );

-- 부모테이블 dept5를 참조하는 자식테이블
DROP TABLE emp;
CREATE TABLE emp(
    empno number(4) PRIMARY KEY,
    ename VARCHAR2(15) NOT null,
    deptno NUMBER(2),
CONSTRAINT emp_dept5_fk FOREIGN KEY(deptno)
    REFERENCES dept5(deptno)
    );

SELECT * FROM dept5;

INSERT INTO dept5(deptno, dname) VALUES (1, '개발부');
INSERT INTO dept5(deptno, dname) VALUES (2, '기획부');
INSERT INTO dept5(deptno, dname) VALUES (3, '디자인');
COMMIT;

SELECT * FROM emp;
INSERT INTO emp(empno, ename, deptno) VALUES (1, '안준호', 1);
INSERT INTO emp(empno, ename, deptno) VALUES (2, '조석봉', 3);
COMMIT;

/*
-- 자식 레코드가 없으면 삭제된다.
-- DELETE FROM emp WHERE empno = 1;
-- DELETE FROM dept5 WHERE deptno = 1;

*/
DELETE FROM emp WHERE empno = 2;
ROLLBACK;

-- ORA-02292: 무결성 제약조건(HR.EMP_DEPT5_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
DELETE FROM dept5 WHERE deptno = 1;

-- 제약 조건 보기
SELECT * FROM user_constraints
WHERE constraint_name = 'EMP_DEPT5_FK';

-- 제약 조건 보기
SELECT * FROM user_constraints
WHERE table_name = 'EMP';

-- 제약 조건은 수정 불가능, 삭제만 가능합니다.
ALTER TABLE emp DROP CONSTRAINT EMP_DEPT5_FK;

-- 제약조건 추가하기
ALTER TABLE emp ADD (
    CONSTRAINT emp_dept5_fk FOREIGN KEY(deptno) REFERENCES dept5(deptno));
    
SELECT * FROM user_constraints
WHERE constraint_name = 'SYS_C008366';
