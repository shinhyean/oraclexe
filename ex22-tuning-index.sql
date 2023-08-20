/*
INDEX UNIQUE SCAN
: 고유 인덱스가 정의된 컬럼이 조건절에서 '='로 비교되는 경우
: 그 외의 경우는 전부 INDEX RANGE SCAN이 발생
*/

SELECT *
FROM products
WHERE prodno = 11000;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));


SELECT /*+ FULL(p) */ *
FROM products p
WHERE prodno = 11000;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));


/*
FULL TABLE SCAN

: 테이블에 할당된 첫 번째 블록부터 HWM 아래의 모든 블록을 읽음
: 1회의 I/O에 대해서 여러 개의 블록을 읽음
: DB_FILE_MULTIBLOCK_READ_COUNT 파라메터로 한 번에 읽어야 할 블록의 개수를 지정

*/
SHOW PARAMETER DB_FILE_MULTIBLOCK_READ_COUNT;

SELECT * FROM orderdetails;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));


/*
INDEX RANGE SCAN
: INDEX UNIQUE SCAN을 제외한 모든 INDEX SCAN은 INDEX RANGE SCAN 이다.
: 고유 인덱스가 정의된 컬럼이 조건절에서 '=' 비교 연산자를 제외한 모든 연산자로 비교되는 경우
: 비고유 인덱스가 정의된 컬럼이 조건절에 기술되는 경우
*/

CREATE INDEX products_price_idx ON products(price);
DROP INDEX products_price_idx;

SELECT *
FROM products
WHERE price BETWEEN 3350 AND 4500;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));


/*
INDEX RANGE SCAN DESCENDING
: INDEX RANGE SCAN에서는 조건절의 범위를 검색 할 때, 기본적으로 최소 경계값부터 검색을 시작하여 최대 경계값에서 검색을 종료
: 만약, 최대 경계값에서 검색을 시작하여 최소 경계값에서 검색을 종료해야하는 경우에 사용
*/
CREATE INDEX products_price_idx ON products(price);

SELECT /*+ INDEX_DESC(products products_price_idx) */ *
FROM products
WHERE price BETWEEN 3350 AND 4500;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));



/*
INDEX RANGE SCAN(MIN/MAX)
    앞서 언급한 최대값 찾기에서 다음과 같이 결합(복합) 인덱스를 정의
*/

DROP INDEX products_idx;
CREATE INDEX products_idx ON products(psize, price);


SELECT /*+ INDEX(products products_idx) */ MAX(price) FROM products
WHERE psize = 'XL';
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST -ROWS'));

/*
INDEX 컬럼 가공
    인덱스가 정의된 컬럼을 가공하면 인덱스를 활용 할 수 없음
*/

CREATE INDEX products_price_idx ON products(price);

SELECT /*+ INDEX(products products_price_idx) */ * 
FROM products
WHERE TRUNC(price) BETWEEN 3350 AND 4500;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));

-- 비교
SELECT /*+ INDEX(products products_price_idx) */ * 
FROM products
WHERE price BETWEEN 3350 AND 4500;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));


/*
INDEX RANGE SCAN 과 FULL TABLE SCAN
    테이블 대부분의 데이터를 찾을때는 FULL TABLE SCAN 방식이 유리하다
*/

SELECT COUNT(*) FROM orders;

CREATE INDEX orders_custno_idx ON orders(custno);

SELECT /*+ FULL(orders) */ MAX(orderdate)
FROM orders
WHERE custno BETWEEN 1 AND 100;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));


SELECT /*+ INDEX(orders orders_custno_idx) */ MAX(orderdate)
FROM orders
WHERE custno BETWEEN 1 AND 100;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));


SELECT /*+ FULL(orders) */ MAX(orderdate)
FROM orders
WHERE custno BETWEEN 1 AND 5000;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));

SELECT /*+ INDEX(orders orders_custno_idx) */ MAX(orderdate)
FROM orders
WHERE custno BETWEEN 1 AND 5000;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));


/*
INDEX FAST FULL SCAN
: INDEX FULL SCAN은 인덱스에 포함되지 않은 컬럼이 SQL에 포함되어 있을 때도 발생하지만
  INDEX FAST FULL SCAN은 인덱스에 포함된 컬럼들만 SQL에 사용되었을 때 발생
: Multi Block I/O에 의해 리프 블록에 접근하므로, 데이터의 출력 순서를 보장하지 않음
*/
CREATE INDEX emp_idx on emp(job, hiredate, deptno);

SELECT /*+ INDEX_FFS(e emp_idx) */ TO_CHAR(hiredate, 'YYYYMM') yyyymm, COUNT(deptno) total
FROM emp e
WHERE job = 'CLERK'
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
order by yyyymm 
;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));

/*
INDEX SKIP SCAN										
    복합 인덱스의 선두 컬럼이 WHERE 절의 조건에 포함되지 않아서, 
    해당 선두 컬럼의 모든 값에 대해 인덱스를 검색										
*/
CREATE INDEX customers_idx ON customers(gender, city, grade, birthdate);

SELECT /*+ NO_INDEX_SS(c customers_idx) */ custno, city, grade, birthdate, phone
FROM customers c
WHERE city = '서울'
AND grade = 'VIP'
AND birthdate BETWEEN TO_DATE('19850101', 'YYYYMMDD') AND TO_DATE('19851231', 'YYYYMMDD');

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));

+-----------------
SELECT /*+ INDEX_SS(c customers_idx) */ custno, city, grade, birthdate, phone
FROM customers c
WHERE city = '서울'
AND grade = 'VIP'
AND birthdate BETWEEN TO_DATE('19850101', 'YYYYMMDD') AND TO_DATE('19851231', 'YYYYMMDD');
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));
