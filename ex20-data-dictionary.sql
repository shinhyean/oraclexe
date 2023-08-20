/*
데이터 딕셔너리란?
    데이터 딕셔너리는 데이터베이스 내부의 메타데이터를 관리하는 시스템 테이블과 뷰의 집합입니다.
    이를 통해 데이터베이스 객체와 속성에 대한 정보를 조회하고 모니터링할 수 있습니다.
    주 목적은 모니터링 있다.
    코멘트도 뽑아 볼 수도 있다.
    
    *****기본적으로는 관리자 권한이 부여 되어있는 데에서 실행이 가능한다.*****
    
    USER_: 현재 사용자의 스키마에 대한 정보만 포함하는 뷰입니다.
    ALL_: 현재 사용자가 접근 가능한 모든 스키마의 정보를 포함하는 뷰입니다.
    DBA_: 데이터베이스의 모든 객체에 대한 정보를 포함하는 뷰로, 
          DBA(데이터베이스 관리자) 권한이 있는 사용자만 접근할 수 있습니다.
    
*/


-- user_tables: 현재 사용자의 테이블 정보 조회
SELECT table_name, num_rows
FROM user_tables;

-- user_views: 현재 사용자의 뷰 정보 조회
SELECT view_name, text
FROM user_views;

-- all_tables: 모든 사용자가 접근 가능한 테이블 정보 조회
SELECT owner, table_name, num_rows
FROM all_tables
WHERE owner != 'SYS';

-- all_indexes: 모든 사용자가 접근 가능한 인덱스 정보 조회
SELECT owner, index_name, table_name
FROM all_indexes
WHERE owner != 'SYS';

-- dba_tables: 데이터베이스의 모든 테이블 정보 조회 (DBA 권한 필요)
SELECT owner, table_name, num_rows
FROM dba_tables
WHERE owner != 'SYS';

-- dba_views: 데이터베이스의 모든 뷰 정보 조회 (DBA 권한 필요)
SELECT owner, view_name, text
FROM dba_views
WHERE owner != 'SYS';



/*
성능뷰 (Dynamic Performance View)
    오라클 instance의 작업 및 성능에 대한 모니터링, 감사 등을 위한 뷰입니다. 
*/

-- v$instance: 현재 인스턴스 정보 조회
SELECT instance_name, instance_number, status, host_name
FROM v$instance;

-- v$session: 세션 정보 조회
SELECT sid, serial#, username, status, program
FROM v$session;

-- v$sysstat: 시스템 통계 정보 조회
SELECT name, value
FROM v$sysstat
WHERE name LIKE 'user commits' OR name LIKE 'user rollbacks';

-- v$version: Oracle 버전 정보 조회
SELECT banner
FROM v$version
WHERE banner LIKE 'Oracle%';

-- v$process: 프로세스 정보 조회
SELECT *
FROM v$process;

-- v$lock: 락 정보 조회
SELECT *
FROM v$lock
WHERE block = 1;

-- v$event_name: 대기 중인 이벤트 정보 조회
SELECT event#, name
FROM v$event_name;

-- v$open_cursor: 열려 있는 커서 정보 조회
SELECT user_name, machine, cursor_type, sql_text
FROM v$open_cursor
WHERE user_name IS NOT NULL;

-- v$system_parameter: 시스템 파라미터 정보 조회
SELECT name, value
FROM v$system_parameter
WHERE name LIKE 'buffer_cache%' OR name LIKE 'processes%';

-- v$parameter: 파라미터 정보 조회
SELECT name, value
FROM v$parameter
WHERE name LIKE 'db_block_size' OR name LIKE 'open_cursors';

-- v$option: 오라클 옵션 및 버전 정보 조회
SELECT * FROM v$option;

-- v$sql: SQL 문장 정보 조회
SELECT sql_id, sql_text
FROM v$sql
WHERE parsing_schema_name = 'HR' AND command_type = 3;

-- v$sqlarea: SQL 영역 정보 조회
SELECT sql_id, executions, buffer_gets, disk_reads
FROM v$sqlarea
WHERE buffer_gets > 10000;



SELECT
  a.sid,       -- SID
  a.serial#,   -- 시리얼번호
  a.status,    -- 상태정보
  a.process,   -- 프로세스정보
  a.username,  -- 유저
  a.osuser,    -- 접속자의 OS 사용자 정보
  b.sql_text,  -- sql
  c.program    -- 접속 프로그램
FROM
  v$session a,
  v$sqlarea b,
  v$process c
WHERE
  a.sql_hash_value=b.hash_value
  AND a.sql_address=b.address
  AND a.paddr=c.addr
  AND a.status='ACTIVE';

--유저 세션 KILL
ALTER SYSTEM KILL SESSION 'SID,시리얼번호';

-- 데이터 딕셔너리 예제 모음


-- 1. 테이블 목록 조회
SELECT table_name, tablespace_name, num_rows
FROM user_tables;

-- 2. 컬럼 정보 조회
SELECT column_name, data_type, data_length, nullable, table_name
FROM user_tab_columns
WHERE table_name like '%EMPLOYEES%';

-- 3. 인덱스 정보 조회
SELECT index_name, table_name, uniqueness, status
FROM user_indexes;

-- 4. 제약 조건 정보 조회
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'ORDERS';

-- 5. 뷰 정보 조회
SELECT view_name, text
FROM user_views;

-- 6. 시퀀스 정보 조회
SELECT sequence_name, last_number, increment_by
FROM user_sequences;

-- 7. 트리거 정보 조회
SELECT trigger_name, triggering_event, status
FROM user_triggers;

-- 8. 세션 정보 조회
SELECT sid, serial#, username, status
FROM v$session;

-- 9. 사용자 권한 조회
SELECT username, privilege
FROM user_sys_privs;

-- 10. 데이터베이스 버전 정보 조회
SELECT banner
FROM v$version;

-- 11. 테이블 통계 정보 조회
SELECT table_name, num_rows, blocks
FROM user_tables;

-- 12. 테이블별 인덱스 개수 조회
SELECT table_name, COUNT(index_name) AS num_indexes
FROM user_indexes
GROUP BY table_name;

-- 13. 테이블별 레코드 수와 평균 길이 조회
SELECT table_name, num_rows, avg_row_len
FROM user_tables;

-- 14. 테이블별 제약 조건 개수 조회
SELECT table_name, COUNT(constraint_name) AS num_constraints
FROM user_constraints
GROUP BY table_name;

-- 15. 특정 컬럼을 포함하는 테이블 조회
SELECT table_name
FROM user_tab_columns
WHERE column_name = 'EMPLOYEE_ID';

-- 16. 특정 인덱스를 사용하는 테이블 조회
SELECT table_name
FROM user_indexes
WHERE index_name = 'EMPLOYEE_ID_IDX';

-- 17. 사용자가 소유한 객체 조회
SELECT object_name, object_type
FROM user_objects;

-- 18. 특정 테이블의 인덱스 목록 조회
SELECT index_name
FROM user_indexes
WHERE table_name = 'PRODUCTS';

-- 19. 테이블별 트리거 개수 조회
SELECT table_name, COUNT(trigger_name) AS num_triggers
FROM user_triggers
GROUP BY table_name;

-- 20. 데이터베이스에서 사용 가능한 뷰 조회
SELECT view_name
FROM all_views;

-- 21. 사용 가능한 모든 테이블 조회
SELECT table_name, owner
FROM all_tables;

-- 22. 모든 컬럼 정보 조회
SELECT table_name, column_name, data_type, data_length
FROM all_tab_columns;

-- 23. 특정 제약 조건에 대한 컬럼 조회
SELECT constraint_name, column_name
FROM all_cons_columns
WHERE table_name = 'ORDERS';

-- 24. 테이블별 인덱스 및 컬럼 정보 조회
SELECT uic.table_name, uic.index_name, uic.column_name, utc.data_type
FROM user_ind_columns uic
JOIN user_tab_columns utc ON uic.table_name = utc.table_name AND uic.column_name = utc.column_name;

-- 25. 특정 시퀀스 정보와 해당 시퀀스를 사용하는 테이블 조회
SELECT sequence_name, table_name
FROM all_dependencies
WHERE referenced_type = 'SEQUENCE' AND referenced_name = 'ORDER_SEQ';

-- 26. 특정 테이블을 참조하는 외래키 제약 조건 조회
SELECT constraint_name, r_owner, r_constraint_name
FROM all_constraints
WHERE r_constraint_name IN (
    SELECT constraint_name
    FROM all_constraints
    WHERE table_name = 'ORDERS'
);

-- 27. 사용자가 소유한 모든 뷰 조회
SELECT view_name
FROM all_views;

-- 28. 사용자 권한과 롤 조회
SELECT grantee, granted_role
FROM dba_role_privs;

-- 29. 데이터베이스의 인덱스 타입 정보 조회
SELECT index_name, index_type
FROM all_indexes;

-- 30. 사용자별 세션 정보와 접속 IP 주소 조회
SELECT username, machine
FROM v$session;

-- 31. 모든 테이블의 통계 정보 조회
SELECT table_name, num_rows, blocks
FROM all_tables;

-- 32. 사용자 권한별 객체 수 조회
SELECT grantee, COUNT(object_name) AS num_objects
FROM all_objects
GROUP BY grantee;

-- 33. 테이블별 컬럼 수와 인덱스 수 조회
SELECT table_name, COUNT(column_name) AS num_columns, COUNT(index_name) AS num_indexes
FROM all_tab_columns
LEFT JOIN all_ind_columns ON all_tab_columns.table_name = all_ind_columns.table_name AND all_tab_columns.column_name = all_ind_columns.column_name
GROUP BY table_name;

-- 34. 데이터베이스의 세그먼트 정보 조회
SELECT segment_name, segment_type, tablespace_name
FROM dba_segments;

-- 35. 테이블별 사용 가능한 트리거 수 조회
SELECT table_name, COUNT(trigger_name) AS num_triggers
FROM all_triggers
GROUP BY table_name;

-- 36. 데이터베이스의 모든 시퀀스 정보 조회
SELECT sequence_name, last_number, increment_by
FROM all_sequences;

-- 37. 특정 테이블과 관련된 제약 조건 정보 조회
SELECT constraint_name, constraint_type
FROM all_constraints
WHERE table_name = 'EMPLOYEES';

-- 38. 데이터베이스에서 사용 가능한 모든 테이블 스페이스 조회
SELECT tablespace_name
FROM dba_tablespaces;

-- 39. 사용자별 시노님 수 조회
SELECT owner, COUNT(synonym_name) AS num_synonyms
FROM all_synonyms
GROUP BY owner;

-- 40. 데이터베이스의 모든 데이터 파일 정보 조회
SELECT file_name, tablespace_name, bytes/1024/1024 AS size_mb
FROM dba_data_files;


-- 41. 테이블의 컬럼 코멘트 조회
SELECT table_name, column_name, comments
FROM user_col_comments
WHERE table_name = 'EMPLOYEES';