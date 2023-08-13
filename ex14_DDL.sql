/*
���ϸ� : ex14_DDL.sql
DDL(Data Definition Language) - ������ ���Ǿ�
    �����ͺ��̽� ���� ���� �� ��ü(���̺�, ������ .. ��)�� ����, ����, �����ϱ� ���� ���Ǵ� SQL���Դϴ�.
*/

/*
CREATE TABLE ��
    �����͸� ������ ���̺��� �����մϴ�.
*/

CREATE TABLE dept(
    deptno NUMBER(6),
    dname VARCHAR2(200),
    loc VARCHAR2(200),
    create_date DATE DEFAULT SYSDATE
    );
    
DESC DEPT;

/*
����������
    -- 1. ������ ������ Ÿ��
    CHAR(size)
    ���� ���� ���� ������ Ÿ��(�ִ� 2000byte) - ������ ���̺��� ª�� �����Ͱ� �Էµ� �� ������ ������ �������� ä����
    
    VARCHAR2(size)
    ���� ���� ���� ������ Ÿ��(�ִ� 4000byte) - ������ ���̺��� ª�� �����Ͱ� �Էµ� �� ������ ������ ä���� �ʴ´�.
    
    NCHAR(size)
    ���� ���� ���� �����ڵ� ������ Ÿ��(�ִ� 2000byte)
    
    NVARCHAR2(size)
    ���� ���� ���� �����ڵ� ������ Ÿ��(�ִ� 4000byte)
    
    LONG
    ���� ���� ���� ������ Ÿ��(�ִ� 2Gbyte)
    
    CLOB
    ��뷮 ���� ������ Ÿ��(�ִ� 4Gbyte)
    
    NCLOB
    ��뷮 ���� �����ڵ� ������ Ÿ��(�ִ� 4Gbyte)
    
    -- 2. ������ ������ Ÿ��
    BINARY_FLOAT
    �ε� �Ҽ��� ������ Ÿ��(4byte) - 32bit �ε� �Ҽ�
    
    BINARY_DOUBLE
    �ε� �Ҽ��� ������ Ÿ��(4byte) - 64bit �ε� �Ҽ�
    
    NUMBER(P,S)
    ���� ������
    P, S�� ǥ�� ���� ���� ���� ������ Ÿ�� P: 1 ~ 38, S: -84 ~ 127 P(Precision): ��ȿ�ڸ���, S(Scale):�Ҽ��� ��ȿ�ڸ�
    
    -- 3. ��¥�� ������ Ÿ��
    DATE
    ���� ���� ��¥(��¥ �� �ð� ��)
    
    INTERVAL_YEAR
    ��¥(�⵵, ��)������ �Ⱓ ǥ�� ������ Ÿ��
    
    INTERVAL_DAY
    ��¥ �� �ð�(����, ��, ��, ��)������ �Ⱓ ǥ�� ������ Ÿ��
    
    TIMESTAMP
    �и���(ms)���� ǥ�� ������ Ÿ��
    
    TIMESTAMP_WITH TIME ZONE
    ��¥ �� �ð��� ������ ������ Ÿ��
    
    TIMESTAMP_WITH LOCAL TIME ZONE
    ���� �� �����ͺ��̽� �ð��븦 �ؼ�, ��ȸ�� ��ȸ�ϴ�
    Ŭ���̾�Ʈ �ð� ǥ�� ������ Ÿ��
    
    -- 4. ���� ������ Ÿ��
    RAW(size)
    ���� ���� ���� ������ Ÿ��(�ִ� 2Gbyte)
    
    LONGRAW
    ���� ���� ���� ������ Ÿ��(�ִ� 4Gbyte)
    
    BLOB
    ��뷮�� ���̳ʸ� �����͸� �����ϱ� ���� ������ Ÿ��(�ִ� 4Gbyte)
    
    BFILE
    ������ġ�� ��Ÿ������ ����
    ��뷮�� ���̳ʸ� �����͸� �������·� �����ϱ� ���� ������ Ÿ��(�ִ� 4Gbyte)
*/

-- departments ���̺��� dept�� ������ �����ϱ�
INSERT INTO dept
SELECT department_id, department_name, location_id, SYSDATE
FROM departments;

SELECT * FROM dept;

/*
CTAS "Create Tavle As Select" �� ���ڷ�
�����ͺ��̽����� ���ο� ���̺��� �����ϴ� ����Դϴ�.
�� ����� ���� ���̺��� SELECT���� ����Ͽ� �����͸� ��ȸ�� ��,
�� ����� ���ο� ���̺�� �����ϴ� ����Դϴ�.
*/

-- ���̺� �����ϱ� => ���� ������ ���簡 �ȵȴ�.
CREATE TABLE dept2 AS SELECT * FROM dept;
DESC dept2;

SELECT * FROM dept2;

-- ���̺� ������ �����ϱ� (������ �׻� ������ �Ǵ� ������)
CREATE TABLE dept3 AS SELECT * FROM dept WHERE 1=2;
DESC dept3;
SELECT * FROM dept3;

/*
ALTER ��
    �����ͺ��̽� ��ü ������ �Ӽ��� ������ �� ���Ǵ� SQL ��ɹ��Դϴ�
    ALTER TABLE ���̺�� ADD(�÷���1 ����������, �÷���2 ����������);
*/
CREATE TABLE simple(num NUMBER);

SELECT * FROM simple;

-- �÷� �߰��ϱ�
ALTER TABLE simple ADD(name VARCHAR2(3));

-- �÷� �����ϱ�
ALTER TABLE simple MODIFY(name VARCHAR2(30));

-- �÷� �����ϱ�
ALTER TABLE simple DROP COLUMN name;

ALTER TABLE simple ADD(addr VARCHAR2(50));
-- �÷� �����ϱ�2
ALTER TABLE simple DROP(addr);

DESC simple;

-- DROP �� : ��ü�� ������ �� ���Ǵ� SQL��ɹ� �Դϴ�.
-- ���̺� ����
DROP TABLE simple;

/*
���� ����(Constraint)
    ���̺��� �ش��÷��� ������ �ʴ� �����͸� �Է�/����/���� �Ǵ� ���� �����ϱ�
    ���� ���̺� ���� �Ǵ� ����� �����ϴ� �����Դϴ�.(����� �������� �ŷڼ� ���̱� ����)
    
    NOT NULL
        NULL �� �Է��� �Ǿ�� �ȵǴ� �÷��� �ο��ϴ�
        �������� �÷� ���������� �ο��� �� �ִ� ���������Դϴ�.
        
    UNIQUE KEY(����Ű)
        ����� ���� �ߺ����� �ʰ� ���� �����ϰ� �����Ǿ�� �� ��
        ����ϴ� ���� �����Դϴ�.(NULL�� ����ȴ�.)
        
    Primary Key(��ǥŰ, �⺻Ű)
        NOT NULL ���ǰ� UNIQUE KEY�� ��ģ �����Դϴ�.
        
    CHECK 
        ���ǿ� �´� �����͸� �Էµǵ��� ������ �ο��ϴ� ���������Դϴ�.
        
    Foreign Key(�ܷ�Ű, ������)
        �θ� ���̺��� Primary Key�� �����ϴ� �÷��� ���̴� ���������Դϴ�.
*/

/*
-- DEFAULT�� null�� ������ �����ϱ�(���� null�� ��)
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
    deptno NUMBER(2) CONSTRAINT dept4_deptno_pk PRIMARY KEY, -- CONSTRAINT �̸� PRIMARY KEY
    dname VARCHAR2(15) DEFAULT '������', -- DEFAULT '������' : insert �Ҷ� �ƹ��͵� ������� �ʾ�����(null�� ����) '������'��� ���� ����
    loc CHAR(1) CONSTRAINT dept4_loc_ck CHECK(loc IN('1','2')) -- CHECK(loc IN('1','2') : 1�Ǵ� 2�� ������ �ְ��Ѵ�
    );
    
SELECT * FROM dept4;

INSERT INTO dept4(deptno, dname, loc)
VALUES (1, null, '1');

-- ORA-00001: ���Ἲ ���� ����(HR.DEPT4_DEPTNO_PK)�� ����˴ϴ�
INSERT INTO dept4(deptno, loc)
VALUES (1, '1');

INSERT INTO dept4(deptno, loc)
VALUES (2, '1');

-- ORA-02290: üũ ��������(HR.DEPT4_LOC_CK)�� ����Ǿ����ϴ�
INSERT INTO dept4(deptno, loc)
VALUES (3, '3');

-- �ܷ�Ű�� ����� ���ؼ��� �θ����̺� �ʿ�
-- �θ����̺� ����
CREATE TABLE dept5(
    deptno NUMBER(2) PRIMARY KEY, -- CONSTRAINT �̸� <- ��������
    dname VARCHAR2(15) NOT NULL
    );

-- �θ����̺� dept5�� �����ϴ� �ڽ����̺�
DROP TABLE emp;
CREATE TABLE emp(
    empno number(4) PRIMARY KEY,
    ename VARCHAR2(15) NOT null,
    deptno NUMBER(2),
CONSTRAINT emp_dept5_fk FOREIGN KEY(deptno)
    REFERENCES dept5(deptno)
    );

SELECT * FROM dept5;

INSERT INTO dept5(deptno, dname) VALUES (1, '���ߺ�');
INSERT INTO dept5(deptno, dname) VALUES (2, '��ȹ��');
INSERT INTO dept5(deptno, dname) VALUES (3, '������');
COMMIT;

SELECT * FROM emp;
INSERT INTO emp(empno, ename, deptno) VALUES (1, '����ȣ', 1);
INSERT INTO emp(empno, ename, deptno) VALUES (2, '������', 3);
COMMIT;

/*
-- �ڽ� ���ڵ尡 ������ �����ȴ�.
-- DELETE FROM emp WHERE empno = 1;
-- DELETE FROM dept5 WHERE deptno = 1;

*/
DELETE FROM emp WHERE empno = 2;
ROLLBACK;

-- ORA-02292: ���Ἲ ��������(HR.EMP_DEPT5_FK)�� ����Ǿ����ϴ�- �ڽ� ���ڵ尡 �߰ߵǾ����ϴ�
DELETE FROM dept5 WHERE deptno = 1;

-- ���� ���� ����
SELECT * FROM user_constraints
WHERE constraint_name = 'EMP_DEPT5_FK';

-- ���� ���� ����
SELECT * FROM user_constraints
WHERE table_name = 'EMP';

-- ���� ������ ���� �Ұ���, ������ �����մϴ�.
ALTER TABLE emp DROP CONSTRAINT EMP_DEPT5_FK;

-- �������� �߰��ϱ�
ALTER TABLE emp ADD (
    CONSTRAINT emp_dept5_fk FOREIGN KEY(deptno) REFERENCES dept5(deptno));
    
SELECT * FROM user_constraints
WHERE constraint_name = 'SYS_C008366';
