/*
������ ��ųʸ���?
    ������ ��ųʸ��� �����ͺ��̽� ������ ��Ÿ�����͸� �����ϴ� �ý��� ���̺�� ���� �����Դϴ�.
    �̸� ���� �����ͺ��̽� ��ü�� �Ӽ��� ���� ������ ��ȸ�ϰ� ����͸��� �� �ֽ��ϴ�.
    
    USER_: ���� ������� ��Ű���� ���� ������ �����ϴ� ���Դϴ�.
    ALL_: ���� ����ڰ� ���� ������ ��� ��Ű���� ������ �����ϴ� ���Դϴ�.
    DBA_: �����ͺ��̽��� ��� ��ü�� ���� ������ �����ϴ� ���, 
          DBA(�����ͺ��̽� ������) ������ �ִ� ����ڸ� ������ �� �ֽ��ϴ�.
    
*/


-- user_tables: ���� ������� ���̺� ���� ��ȸ
SELECT table_name, num_rows
FROM user_tables;

-- user_views: ���� ������� �� ���� ��ȸ
SELECT view_name, text
FROM user_views;

-- all_tables: ��� ����ڰ� ���� ������ ���̺� ���� ��ȸ
SELECT owner, table_name, num_rows
FROM all_tables
WHERE owner != 'SYS';

-- all_indexes: ��� ����ڰ� ���� ������ �ε��� ���� ��ȸ
SELECT owner, index_name, table_name
FROM all_indexes
WHERE owner != 'SYS';

-- dba_tables: �����ͺ��̽��� ��� ���̺� ���� ��ȸ (DBA ���� �ʿ�)
SELECT owner, table_name, num_rows
FROM dba_tables
WHERE owner != 'SYS';

-- dba_views: �����ͺ��̽��� ��� �� ���� ��ȸ (DBA ���� �ʿ�)
SELECT owner, view_name, text
FROM dba_views
WHERE owner != 'SYS';



/*
���ɺ� (Dynamic Performance View)
    ����Ŭ instance�� �۾� �� ���ɿ� ���� ����͸�, ���� ���� ���� ���Դϴ�. 
*/

-- v$instance: ���� �ν��Ͻ� ���� ��ȸ
SELECT instance_name, instance_number, status, host_name
FROM v$instance;

-- v$session: ���� ���� ��ȸ
SELECT sid, serial#, username, status, program
FROM v$session;

-- v$sysstat: �ý��� ��� ���� ��ȸ
SELECT name, value
FROM v$sysstat
WHERE name LIKE 'user commits' OR name LIKE 'user rollbacks';

-- v$version: Oracle ���� ���� ��ȸ
SELECT banner
FROM v$version
WHERE banner LIKE 'Oracle%';

-- v$process: ���μ��� ���� ��ȸ
SELECT spid, osuser, program, terminal
FROM v$process;

-- v$lock: �� ���� ��ȸ
SELECT session_id, type, mode, block, ctime
FROM v$lock
WHERE block = 1;

-- v$event_name: ��� ���� �̺�Ʈ ���� ��ȸ
SELECT event#, name
FROM v$event_name;

-- v$open_cursor: ���� �ִ� Ŀ�� ���� ��ȸ
SELECT user_name, machine, cursor_type, sql_text
FROM v$open_cursor
WHERE user_name IS NOT NULL;

-- v$system_parameter: �ý��� �Ķ���� ���� ��ȸ
SELECT name, value
FROM v$system_parameter
WHERE name LIKE 'buffer_cache%' OR name LIKE 'processes%';

-- v$parameter: �Ķ���� ���� ��ȸ
SELECT name, value
FROM v$parameter
WHERE name LIKE 'db_block_size' OR name LIKE 'open_cursors';

-- v$option: ����Ŭ �ɼ� �� ���� ���� ��ȸ
SELECT * FROM v$option;

-- v$sql: SQL ���� ���� ��ȸ
SELECT sql_id, sql_text
FROM v$sql
WHERE parsing_schema_name = 'HR' AND command_type = 3;

-- v$sqlarea: SQL ���� ���� ��ȸ
SELECT sql_id, executions, buffer_gets, disk_reads
FROM v$sqlarea
WHERE buffer_gets > 10000;



SELECT
  a.sid,       -- SID
  a.serial#,   -- �ø����ȣ
  a.status,    -- ��������
  a.process,   -- ���μ�������
  a.username,  -- ����
  a.osuser,    -- �������� OS ����� ����
  b.sql_text,  -- sql
  c.program    -- ���� ���α׷�
FROM
  v$session a,
  v$sqlarea b,
  v$process c
WHERE
  a.sql_hash_value=b.hash_value
  AND a.sql_address=b.address
  AND a.paddr=c.addr
  AND a.status='ACTIVE';


--���� ���� KILL
ALTER SYSTEM KILL SESSION 'SID,�ø����ȣ';

-- ������ ��ųʸ� ���� ����


-- 1. ���̺� ��� ��ȸ
SELECT table_name, tablespace_name, num_rows
FROM user_tables;

-- 2. �÷� ���� ��ȸ
SELECT column_name, data_type, data_length, nullable, table_name
FROM user_tab_columns
WHERE table_name like '%EMPLOYEES%';

-- 3. �ε��� ���� ��ȸ
SELECT index_name, table_name, uniqueness, status
FROM user_indexes;

-- 4. ���� ���� ���� ��ȸ
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'ORDERS';

-- 5. �� ���� ��ȸ
SELECT view_name, text
FROM user_views;

-- 6. ������ ���� ��ȸ
SELECT sequence_name, last_number, increment_by
FROM user_sequences;

-- 7. Ʈ���� ���� ��ȸ
SELECT trigger_name, triggering_event, status
FROM user_triggers;

-- 8. ���� ���� ��ȸ
SELECT sid, serial#, username, status
FROM v$session;

-- 9. ����� ���� ��ȸ
SELECT username, privilege
FROM user_sys_privs;

-- 10. �����ͺ��̽� ���� ���� ��ȸ
SELECT banner
FROM v$version;

-- 11. ���̺� ��� ���� ��ȸ
SELECT table_name, num_rows, blocks
FROM user_tables;

-- 12. ���̺� �ε��� ���� ��ȸ
SELECT table_name, COUNT(index_name) AS num_indexes
FROM user_indexes
GROUP BY table_name;

-- 13. ���̺� ���ڵ� ���� ��� ���� ��ȸ
SELECT table_name, num_rows, avg_row_len
FROM user_tables;

-- 14. ���̺� ���� ���� ���� ��ȸ
SELECT table_name, COUNT(constraint_name) AS num_constraints
FROM user_constraints
GROUP BY table_name;

-- 15. Ư�� �÷��� �����ϴ� ���̺� ��ȸ
SELECT table_name
FROM user_tab_columns
WHERE column_name = 'EMPLOYEE_ID';

-- 16. Ư�� �ε����� ����ϴ� ���̺� ��ȸ
SELECT table_name
FROM user_indexes
WHERE index_name = 'EMPLOYEE_ID_IDX';

-- 17. ����ڰ� ������ ��ü ��ȸ
SELECT object_name, object_type
FROM user_objects;

-- 18. Ư�� ���̺��� �ε��� ��� ��ȸ
SELECT index_name
FROM user_indexes
WHERE table_name = 'PRODUCTS';

-- 19. ���̺� Ʈ���� ���� ��ȸ
SELECT table_name, COUNT(trigger_name) AS num_triggers
FROM user_triggers
GROUP BY table_name;

-- 20. �����ͺ��̽����� ��� ������ �� ��ȸ
SELECT view_name
FROM all_views;

-- 21. ��� ������ ��� ���̺� ��ȸ
SELECT table_name, owner
FROM all_tables;

-- 22. ��� �÷� ���� ��ȸ
SELECT table_name, column_name, data_type, data_length
FROM all_tab_columns;

-- 23. Ư�� ���� ���ǿ� ���� �÷� ��ȸ
SELECT constraint_name, column_name
FROM all_cons_columns
WHERE table_name = 'ORDERS';

-- 24. ���̺� �ε��� �� �÷� ���� ��ȸ
SELECT uic.table_name, uic.index_name, uic.column_name, utc.data_type
FROM user_ind_columns uic
JOIN user_tab_columns utc ON uic.table_name = utc.table_name AND uic.column_name = utc.column_name;

-- 25. Ư�� ������ ������ �ش� �������� ����ϴ� ���̺� ��ȸ
SELECT sequence_name, table_name
FROM all_dependencies
WHERE referenced_type = 'SEQUENCE' AND referenced_name = 'ORDER_SEQ';

-- 26. Ư�� ���̺��� �����ϴ� �ܷ�Ű ���� ���� ��ȸ
SELECT constraint_name, r_owner, r_constraint_name
FROM all_constraints
WHERE r_constraint_name IN (
    SELECT constraint_name
    FROM all_constraints
    WHERE table_name = 'ORDERS'
);

-- 27. ����ڰ� ������ ��� �� ��ȸ
SELECT view_name
FROM all_views;

-- 28. ����� ���Ѱ� �� ��ȸ
SELECT grantee, granted_role
FROM dba_role_privs;

-- 29. �����ͺ��̽��� �ε��� Ÿ�� ���� ��ȸ
SELECT index_name, index_type
FROM all_indexes;

-- 30. ����ں� ���� ������ ���� IP �ּ� ��ȸ
SELECT username, machine
FROM v$session;

-- 31. ��� ���̺��� ��� ���� ��ȸ
SELECT table_name, num_rows, blocks
FROM all_tables;

-- 32. ����� ���Ѻ� ��ü �� ��ȸ
SELECT grantee, COUNT(object_name) AS num_objects
FROM all_objects
GROUP BY grantee;

-- 33. ���̺� �÷� ���� �ε��� �� ��ȸ
SELECT table_name, COUNT(column_name) AS num_columns, COUNT(index_name) AS num_indexes
FROM all_tab_columns
LEFT JOIN all_ind_columns ON all_tab_columns.table_name = all_ind_columns.table_name AND all_tab_columns.column_name = all_ind_columns.column_name
GROUP BY table_name;

-- 34. �����ͺ��̽��� ���׸�Ʈ ���� ��ȸ
SELECT segment_name, segment_type, tablespace_name
FROM dba_segments;

-- 35. ���̺� ��� ������ Ʈ���� �� ��ȸ
SELECT table_name, COUNT(trigger_name) AS num_triggers
FROM all_triggers
GROUP BY table_name;

-- 36. �����ͺ��̽��� ��� ������ ���� ��ȸ
SELECT sequence_name, last_number, increment_by
FROM all_sequences;

-- 37. Ư�� ���̺�� ���õ� ���� ���� ���� ��ȸ
SELECT constraint_name, constraint_type
FROM all_constraints
WHERE table_name = 'EMPLOYEES';

-- 38. �����ͺ��̽����� ��� ������ ��� ���̺� �����̽� ��ȸ
SELECT tablespace_name
FROM dba_tablespaces;

-- 39. ����ں� �ó�� �� ��ȸ
SELECT owner, COUNT(synonym_name) AS num_synonyms
FROM all_synonyms
GROUP BY owner;

-- 40. �����ͺ��̽��� ��� ������ ���� ���� ��ȸ
SELECT file_name, tablespace_name, bytes/1024/1024 AS size_mb
FROM dba_data_files;


-- 41. ���̺��� �÷� �ڸ�Ʈ ��ȸ
SELECT table_name, column_name, comments
FROM user_col_comments
WHERE table_name = 'EMPLOYEES';