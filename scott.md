## DATABASE 기초 - 오라클편




**1. 오라클 설치 http://www.oracle.com 에서 다운 설치
   설치시 암호가 system 계정의 암호로 설정된다.**

**2. 연습용 계정 만들기**
- 계정은 system 계정으로 들어가서 만든다
- 커멘트 창에서  sqlplus system / oracle


- 사용자 생성하기
```
SQL> CREATE USER 계정 IDENTIFIED BY 비밀번호 :
```

- 권한 주기
```
SQL> GRANT RESOURCE,CONNECT TO scott;
```

- 연습용 테이블 만들기
```
SQL> @C:\oraclexe\app\oracle\product\10.2.0\server\RDBMS\ADMIN\scott.sql
```

![](https://images.velog.io/images/taeho8822/post/b73b476c-04e8-41f3-8a34-9f183cf2c9b4/image.png)



### DQL (Data Query Langeage)

**1.SELECT ==> 테이블 내의 데이터를 조회할 때 사용한다       <<실행순서>>**
```
  [기본형식]
  SELECT 컬럼명1, 컬럼명2.....					.5
  FROM 테이블명					       	        .1
  WHERE 조건절							.2		
  GROUP BY 칼럼명						.3
  HAVING 조건절 (GROUP묶은 다음에 조건 줄 때	)		.4
  ORDER BY 칼럼명[ASC|DESC] => 오름차순 혹은 내림차순		.6
```

**(1) SELECT 사용**

- emp 테이블에서 사원번호, 사원이름, 직업을 출력해보세요.

```
SQL> select empno,ename,job from emp;
```

- emp 테이블에서 사원번호, 급여, 부서번호를 출력해보세요.
	단,급여가 많은 순서대로 출력
```
SQL> select empno,sal,deptno 
from emp 
order by sal desc;
```

- emp 테이블에서 사원번호, 급여, 입사일을 출력해보세요.
	단,급여가 적은 순서대로 출력
```
SQL> select empno,sal,hiredate
from emp
order by sal asc;
```

- emp 테이블에서 직업,급여를 출력해보세요.
단,직업명으로 오름차순,급여로 내림차순 정렬해서
```
SQL> select job,sal
from emp
order by job asc,sal desc;
```

**(2) WHERE 절 사용하기 (조건을 주어서 검색하고자 할 때)**

- emp 테이블에서 급여가 2000 이상인 사원의 사원번호, 사원이름, 급여 출력하기
```
SQL> select empno,ename,sal
from emp
where sal >= 2000;
```
- emp 테이블에서 부서번호가 10번인 사원들의 모든 정보를 출력하세요
```
SQL> select * 
from emp
where deptno = 10;
```
	
- emp 테이블에서 입사일이 '81/02/20'인 사원의 사원번호,이름,입사일을 출력해보세요
```
SQL> select empno,ename,hiredate
from emp
where hiredate = '81/02/20';
```

- emp 테이블에서 직업이 'SALESMAN'인 사람들의 이름,직업,급여를 출력해보세요
	단, 급여가 높은 순서대로
```
SQL> select ename,job,sal
from emp
where job = 'SALESMAN'
order by sal desc;
```

**(3)ALIAS 사용하기 (칼럼에 별칭 붙이기)**
```
SQL> select empno, ename as "no", ename as "na" from emp;
```

- 큰 따옴표 " " 생략 가능
```
SQL> select empno, ename as no, ename as na from emp;
```

- as와 큰 따옴표 " " 는 생략이 가능하다 (공백문자가 있으면 안됨 = > 사원 번호)
```
SQL> select empno no, ename na from emp;
```


**(4)연산자
	1) 산술 연산자 ( +, -, *, / )**

- 부서번호가 10번인 사원들의 급여를 출력하되 10% 인상 된 금액으로 출력
```
SQL> select sal*1,1
from emp
where deptno = 10;
```

- 급여 비교하여 출력
```
select sal,sal*1.1 from emp;
```

- 칼럼명 바꿔서 출력
```
select sal s, sal*1.1 ups from emp;
```


  **2) 비교 연산자 (=, !=, > , < , >= , <= )**

- 급여가 3000이상인 사원들의 모든 정보를 출력하세요
```
SQL> select * from emp
where sal >= 3000;
```

- 부서번호가 30번이 아닌 사람들의 이름과 부서번호를 출력해보세요.
```
SQL> select ename, deptno
from emp
where deptno != 30;
```

**3) 논리 연산자 ( AND(&&), OR(||), NOT(!=) )**
	
- 부서번호가 10번이고 급여가 3000 이상인 사원들의 이름과 급여를 출력하세요
```
SQL> select ename,sal
from emp
where deptno = 10 and sal >= 3000;
```
- 직업이 SALESMAN 이거나 MANAGER인 사원의 사원번호와 부서번호를 출력하세요
```
SQL> select empno,deptno
from emp
where job='SALESMAN' or job='MANAGER';
```

**4) SQL 연산자 (IN,ANY,BETWEEN,LIKE,IN NULL,IS NOT NULL)**

**1> IN 연산자 (OR 연산자와 비슷한 역할)**
- 부서번호가 10번이거나 20번인 사원번호와 이름, 부서번호를 출력하세요
```
SQL> select empno,ename,deptno
from emp
where deptno=10 or deptno=20;
```
- IN 연산자를 사용한다면?
```
SQL> select empno,ename,deptno
from emp
where deptno in(10,20)
```


**2> ANY 연산자 (조건을 비교할 때 어느 하나라도 맞으면 true)**
```
SQL> select empno,sal
from emp
where sal > any(1000,2000,3000);
==> 결과적으로는 급여가 1000 이상인 row를 select 하게 된다
```


**3> ALL 연산자 (조건을 비교할 때 조건이 모두 맞으면 true)	**
```
SQL> select empno, sal
from emp
where sal > all(1000,2000,3000)
==> 결과적으로는 급여가 3000 이상인 row를 select 하게 된다
```

**4> BETWEEN A AND B (A와 B 사이의 데이터를 얻어온다)	**
- 급여가 1000과 2000 사이인 사원들의 사원번호, 이름, 급여를 출력하세요
```
SQL> select empno,ename,sal
from emp
where sal >= 1000 and sal <=2000;
```
- BETWEEN A AND B 연산자를 사용한다면?
```
SQL> select empno,ename,sal
from emp
where sal between 1000 and 2000;
```

- 사원이름이 FORD와 SCOTT 사이의 사원들의 사원번호, 이름을 출력하세요
```
SQL> select empno,ename
from emp
where ename between 'FORD' and 'SCOTT';
```


**5> IS NULL     (NULL인 경우 true),
   IS NOT NULL (NULL이 아닌 경우 true) **
>    *null이면 비교자체가 불가하다

- 커미션이 NULL인 사원의 사원이름과 커미션을 출력하세요  
```
SQL> select ename,comm
from emp
where comm is null;
```

- 커미션이 NULL이 아닌 사원의 사원이름과 커미션을 출력해보세요
```
SQL> select ename,comm
from emp
where comm is not null;
```

**<6> EXISTS (데이터가 존재하면 true)**
- 사원이름이 'FORD'인 사원이 존재하면 사원의 이름과 커미션을 출력하기
```
SQL> select ename,comm
from emp
where exists(select ename from emp where ename='FORD');
```
**<7> LIKE 연산자(문자열 비교) 중요!! **

- 사원이름이 'J'로 시작하는 사원의 사원이름과 부서번호를 출력
```
SQL> select ename,deptno
from emp
where ename like 'J%';
```

- 사원이름에 'J'가 포함되는 사원의 사원이름과 부서번호를 출력
```
SQL> select ename,deptno
from emp
where ename like '%J%';
```

- 사원이름의 두 번째 글자가 'A'인 사원의 이름,급여,입사일을 출력하기
```
SQL> select ename,sal,hitedate from emp
where ename like '_A%';
```

- 사원이름이 'ES'로 끝나는 사원의 이름, 급여, 입사일을 출력해보세요
```
SQL> select ename,sal,hiredate
from emp
where ename like '%ES';
```

- 입사년도가 81년인 사원들의 입사일과 사원번호를 출력해보세요
```
SQL> select hiredate,empno
from emp
where hiredate like '81%';
```

**5) 결함 연산자 (||) => 단순히 문자열을 연결해서 하나의 데이터로 리턴한다**
```
SQL> select ename || '의 직업은' || job || '입니다' from emp;

SQL> select (ename || '의 직업은' || job || '입니다')str from emp;

* 수정할 때 : ed -> 메모장 열리면 수정 -> 끝내기 -> /Enter
```

**2. 함수 (FUNCTION)**
- 어떠한 일을 수행하는 기능으로써 주어진 인수를 재료로 처리를 하여 그 결과를 반환하는 일을 수행한다

- 함수의 종류

**1) 단일행 함수**
하나의 row 당 하나의 결과값을 반환하는 함수

**2)복수행 함수**
여러개의 row 당 하나의 결과값을 반환하는 함수


**(1) 단일행 함수**


**1)문자함수**


**<1> CHR(아스키코드)**
```
SQL> select chr(65)from emp;
```

**<2> CONCAT(칼럼명,'붙일문자') => 문자열 연결함수**
```
SQL> SELECT CONCAT(ename,'님')from emp;

SQL> select concat(ename,'님') name from emp;
SQL> ~님
     ~님
     ~님
```
**<3> INITCAP('문자열') => 시작문자를 대문자로 바꿔준다**
```
SQL> select initcap('hello world')from dual;
SQL> Hello World
```

**<4> LOWER('문자열') => 문자열을 소문자로 바꿔준다**
```
SQL> select lower ('HELLO!')from dual;
SQL> hello!
```
**<5> UPPER('문자열') => 문자열을 대문자로 바꿔준다**
```
SQL> select upper ('hello!') from dual;
SQL> HELLO!
```
**<6> LPAD('문자열', 전체 자리수, '남는 자리를 채울 문자') => 왼쪽에 채운다**
```
SQL> select lpad('HI',10,'*')from dual;
SQL> ********HI
```

**<7> RPAD('문자열', 전체 자리수, '남는 자리를 채울 문자') => 오른쪽에 채운다**
```
SQL> select rpad('HELLO','15','^')from dual;
SQL> HELLO^^^^^^^^
```
**<8> LTRIM('문자열','제거할문자')**
```
SQL> select ltrim('ABCD,'A')from dual;
SQL> BCD


SQL> select ltrim(' ABCD,'')from dual;
SQL> ABCD (공백 지우기)

SQL> select ltrim('AAAABBACC,'A')from dual;
SQL> BBACC

SQL> select ltrim('ACACBCD,'AC')from dual;
SQL> 
```
**<9> RTRIM('문자열','제거할문자')**
```
SQL> select rtrim('ACACBCD','CD')from dual;
```

**<10> REPLACE('문자열1','문자열2','문자열3')**
=> 문자열1에 있는 문자열 중 문자열2를 찾아서 문자열3으로 바꿔준다
```
SQL> select replace('hello mimi','mimi','mama')from dual;
SQL> hello mama
```

**<11> SUBSTR('문자열',N1,N2)**
=> 문자열의 N1번째 위치에서 N2개 만큼 문자열 빼오기
```
SQL> select substr('ABCDEFGHIJ',3,5)from dual;
```

ex> emp 테이블에서 ename(사원이름)의 두번째 문자가 'A'인 사원의 이름을 출력한다면?
```
SQL> select ename
from emp
where substr(ename,2,1)='A';


= SQL> select ename 
from emp
where ename like '_A%';
```
**<12> ASCII('문자') => 문자에 해당하는 ASCII 코드 값을 반환한다**
```
SQL> select ascii('A')from dual;
```
**<13> LENGTH('문자열') => 문자열의 길이를 반환한다**
```
SQL> select length('ABCDE')from dual;
SQL> 5
```
ex> EMP 테이블에서 사원이름이 5자 이상인 사원들의 사번과 이름을 출력해보세요
```
SQL> select empno,ename 
from emp
where length(ename) >= 5;
```
**<14> LEAST('문자열1','문자열2','문자열3') => 문자열 중에서 가장 작은 값을 리턴한다**
```
SQL> select least('AB','ABC','D')from dual;
SQL> AB
```
**<15> NVL(컬럼명,값) => 해당 칼럼이 NULL인 경우 정해진 값을 반환한다**
```
SQL> select ename,NVL(comm,O) from emp;
SQL> select ename,NVL(comm,100) C from emp; (100씩 커미션 주기)
```



**2) 숫자 함수**


**<1> ABS(숫자) => 숫자의 절대값을 반환함 (음수를 양수로 반환)**
```
SQL> select abs(-10)from dual;
```
**<2> CEIL(소수점이 있는 수) => 파라미터 값보다 같거나 가장 큰 정수는 반환(올림)**
```
SQL> select ceil(3.1234) from dual;
SQL> select ceil(5.9999) from dual;
```
**<3> floor(소수점이 있는 수) => 파라미터 값보다 같거나 가장 작은 정수 반환(내림)**
```
SQL> select floor(3.2241) from dual;
SQL> select floor(2.888829) from dual;
```
**<4> ROUND(숫자,자리수) => 숫자를 자리수 +1번째 위치에서 반올림한다**
```
SQL> select round(3.22645,2) from dual;
SQL> select round(5.2345,3) from dual;
```
**<5> MOD (숫자1,숫자2) => 숫자1을 숫자2로 나눈 나머지를 리턴한다**
```
SQL> select mod(10,3) from dual;
```

**<6> TRUNC(숫자1,자리수) => 숫자1의 값을 소수점이하 자리수까지만 나타난다. 나머지는 잘라낸다**
```
SQL> select trunc(12.23532576,2) from dual;
SQL> select trunc(34.1234)from dual;
```

**3) 날짜 함수 ( * 중요!! 자주 쓰인다 * )**

**<1> SYSDATE => 현재 시간을 리턴한다**
```
SQL> select sysdate from dual;
```
**<2> ADD_MONTHS (날짜,더해질월)**
```
SQL> select add_months(sysdate,1001)from dual;
```
**<3> LAST_DAY (날짜) => 해당날짜에 해당하는 달의 마지막 날짜를 반환한다**
```
SQL> select last_day(sysdate) from dual;
```

**<4> MONTHS_BETWEEN(날짜1,날짜2) => 두 날짜 사이의 월의 수**
```
SQL> select empno,months_between(sysdate,hiredate)근무개월
from emp;
```

**4) 문자 변환 함수 ( * 중요!!! * )**
-TO_CHAR
```
SQL> select to_char(sysdate,'YYYY-MM-DD')from dual;

SQL> select to_char(sysdate,'YY"년"MM"월"DD"일"')from daul;

SQL> select to_char(sysdate,'HH:MI:SS')from dual;

SQL> select to_char(sysdate,'AM HH:MI:SS')from dual;

SQL> select to_char(sysdate,'PM HH:MI:SS')from dual;

SQL> select to_char(sysdate,'HH24:MI:SS') from dual;

SQL> select to_char(sysdate,'YY"년"MM"월"DD"일"HH24"시"MI"분"SS"초"'+) from dual;
```

**5) 숫자 변환 함수**
- to_number('숫자에 대응되는 문자');
```
SQL> select to_number('999')+1 from dual;
```

**6) 날짜 변환 함수**
- to_date('날짜에 대응되는 문자');
```
SQL> select to_date('2012-12-12')frem dual;
```

**(6) 복수행(그룹) 함수  * 중요 **


**1) COUNT(칼럼명) => 해당 칼럼이 존재하는 row의 갯수를 반환
단, 저장된 데이터가 NULL인 칼럼은 세지 않는다. **
```
SQL> select count(ename)from emp;

SQL> select count(comm)from emp;

SQL> select count(*) from emp;     => 모든 행(row)의 갯수를 얻어온다
```

**2)SUM(칼럼명) => 해당 칼럼의 값을 모두 더한 값을 러턴한다.**
```
SQL> select sum(sal)from emp;
```
**3) AVG(칼럼명) => 해당 칼럼의 모든 값을 더한 후, row의 갯수로 나눈 평균값을 리턴한다. 단 NULL은 제외된다.**
```
SQL> select AVG(sal) from emp;

SQL> select AVG(comm) from emp;
```

ex) comm이 null인 사원도 평균에 포함시켜서 출력을 하려면?
hint : NVL()함수를 이용한다
```
SQL> select avg(nvl(comm,0)) from emp;
```
**4) MAX(칼럼명) => 최대값을 리턴한다**
```
SQL> select max(sal)from emp;
```
**5) MIN(칼럼명) => 최소값을 리턴한다**
```
SQL> select min(sal)from emp;
```
 
#### GROUP BY 기준필드 => 기준필드를 기준으로 그룹으로 묶는다

- 부서별 급여의 총합을 출력
```
SQL> select deptno, sum(sal) 
from emp
group by deptno;
```
- 부서별 급여의 평균값을 출력
```
SQL> select deptno, avg(sal)
from emp
group by deptno;
```
- 부서별 급여의 평균값을 반올림해서 소수첫째 자리 까지만 구해보세요
```
SQL> select deptno,round(avg(sal),1) 
from emp
group by deptno;
```

- 직업별 최대 급여를 구해보세요
```
SQL> select job,max(sal)
from emp
group by job;
```

- 급여가 1000인 이상인 사원들의 부서별 평균 급여의 반올림 값을 
부서번호로 내림 차순해서 출력해보세요
```
SQL> select deptno,round(avg(sal))
from emp
where sal >=1000
group by deptno	
order by deptno desc;
```
- 급여가 2000 이상인 사원들의 부서별 평균 급여의 반올림 값을 
평균급여의 반올림값으로 오름차순해서 출력해보세요
```
SQL> select deptno,round(avg(sal))
from emp
where sal >= 2000
group by deptno
order by round(avg(sum)) asc;
```
- 각 부서별 같은 업무를 하는 사람의 인원수를 구하여
부서번호,직업, 인원수를 출력해보세요
```
SQL> select deptno,job,count(*)
from emp
group by deptno,job;
```
- 급여가 1000인 이상인 사원들의 부서별 평균 급여를 출력해보세요
단, 부서별 평균 급여가 2000이상인 부서만 출력하세요
```
SQL> select deptno, avg(sal)
from emp
where sal >= 1000
group by deptno
having avg(sal) >= 2000;
```

**3.JOIN**
- 하나의 테이블로 원하는 칼럼정보를 참조 할 수 없는 경우, 관련된 테이블을 논리적으로 결합하여 원하는 칼럼정보를 참조하는 방법을 JOIN 이라고 한다
 
[ 형식 ]
SELECT 칼럼명1, 칼럼명2.....
FROM 테이블명1, 테이블명2.....
WHERE JOIN 조건 AND 다른 조건.....


- emp 테이블의 사원이름, 부서번호, 부서명을 출력해보세요
```
SQL> select ename,emp.deptno,dname
from emp,dept
where emp.deptno = dept.deptno
```

- 급여가 3000에서 5000 사이의 사원이름과 부서명을 출력해보세요
```
SQL> select ename,dname
from emp,dept
where emp.deptno = dept.deptno
and sal between 3000 and 5000;
```

- 부서명이 ACCOUNTING인 사원의 이름,입사일,부서번호,부서명을 출력해보세요
```
SQL> select ename,hiredate,emp.deptno,dname
from emp,dept
where emp.deptno = dept.deptno
and dname = 'ACCOUNTING';

SQL> select e.ename,e.hiredate,e.deptno,d.dname
from emp e,dept d
where e.deptno = d.deptno
and dname = 'ACCOUNTING';
```

- 커미션이 null이 아닌 사원의 이름, 입사일, 부서명을 출력해보세요
```
SQL> select e.ename,e.hiredate,d.dname
from emp e,dept d
where e.deptno = d.deptno 
and e.comm is not null;
```

- 각 사원의 이름과 매니저 이름을 출력하세요
```
SQL> select e1.ename,e2.ename
from emp e1,emp e2
where e1.mgr = e2.empno; 
```

**3) OUTER JOIN 조인**
- 한 쪽 테이블에는 해당하는 데이터가 존재하는데 다른 테이들에는 데이터가 존재하지 않을 때에도 모든 데이터를 추출하도록 하는 JOIN 방법

- 사원번호, 부서번호, 부서명을 출력해보세요
단, 사원이 근무하지 않는 부서 정보도 같이 출력해보세요
```
SQL> select e.empno,d.deptno,d.dname
from emp e, dept d
where e.deptno(+) = d.deptno;
```


[ QUIZ ] 


**1. emp 테이블과 dept 테이블을 조인하여 부서번호,부서명,이름,급여를 출력해보세요**
```
SQL> select d.deptno,d.dname,e.ename,e.sal
from emp e,dept d;
```
**2. 사원의 이름이 'ALLEN'인 사원의 부서명을 출력해보세요**
```
SQL> select e.ename,d.dname
from emp e,dept d
where e.deptno = d.deptno
and e.ename='ALLEN';
```

**3. 모든 사원의 이름, 부서번호, 부서명, 급여를 출력해보세요
단,emp테이블에 없는 부서도 출력해보세요**
```
SQL> select e.ename,d.deptno,d.dname,e.sal
from emp e,dept d
where e.deptno(+) = d.deptno;
```

**4. 다음과 같이 모든 사원의 매니저를 출력해보세요**
 
SMITH 의 매니저는 FORD 입니다
??? 의 매니저는 ??? 입니다
.
.
.
.

```
SQL> select e1.emp||'의 매니저는 '||e2.emp||'입니다'
from emp e1,emp e2
where e1.mgr = e2.empno;
```

**4. 서브 쿼리(Sub-Query)**
- 하나의 SQL 문장 절에 포함된 또 다른 SELECT 문장으로
  두 번 질의를 해야 얻을 수 있는 결과를 한 번의 질의로 해결이 가능하게 하는 쿼리

- 용어 Main-Query 또는 Outer-Query
       Sub-Query 또는 Inner-Query 두 쌍이 같은 의미이다

- 특징 - 괄호를 반드시 묶어야 한다
       - 서브쿼리는 메인쿼리의 다음 부분에 위치할 수 있다

       1) SELECT / DELETE / UPDATE 문의 FROM 절과 WHERE 절
       2) INSERT 문의 INTO 절
       3) UPDATE 문의 SET 절

- 종류
**<1> 단일행 서브쿼리**
 - 서브쿼리의 실행결과가 하나의 칼럼과 하나의 행안을 리턴해주는 쿼리
   (하나의 데이터만 리턴해주는 쿼리)

 - 사원번호가 7900번인 사원과 같은 직업을 갖는 사원의 사번과 이름을 출력해보세요
```
SQL> select job from emp where empno = 7900;


실행결과
job
----
CLERK

 
SQL> select empno,ename from emp where job = 'CLERK';
```
- 합치면?
```
SQL> select empno,ename
from emp
where job = (select job from emp where empno = 7900);
```

- 사원들의 평균 급여보다 급여를 많이 받는 사원들의 사원번호,이름,급여를 출력해보세요
```
SQL> select empno,ename,sal
from emp
where sal > (select avg(sal) from emp) ;
```

- 사원번호가 7369인 사원과 같은 부서인 사원들의 부서번호, 이름, 급여를 출력해보세요
```
SQL> select deptno, ename, sal
from emp
where deptno = (select deptno from emp where empno = 7369);
```

- 사원번호가 7900인 사원과 같은 부서이고, 사원번호가 7369번인 사원보다 많은 급여를 받는 
 사원의 이름,부서번호,급여를 출력해보세요	 
```
SQL> select ename,deptno,sal
from emp
where deptno = (select deptno from emp where empno = 7900)
and sal > (select sal from emp where empno = 7369);
```

- 각 부서의 최소 급여가 부서번호가 30번인 부서의 최소 급여보다 
많은 급여를 받는 부서의 부서번호, 최소 급여를 출력해보세요
```
SQL> select deptno,min(sal)
from emp
group by deptno
having min(sal) > (select min(sal) from emp where deptno = 30);
```

**<2> 다중행 서브쿼리**


-쿼리의 실행 결과가 여러 개의 칼럼이거나 여러 행을 리턴해주는 쿼리
-반드시 다중행 연산자와 함께 써야 한다
- IN : 하나라도 일치하면
- ANY : 하나이상 일치하면 (비교연산자와 함께 사용)
- ALL : 모두 다 만족하면
- EXISTS : 하나라도 존재한다면

**** <1> IN 연산자 (OR 연산자와 비슷한 역할)	**
 - 부서번호가 10번이거나 20번인 사원번호와 이름, 부서번호를 출력하세요
```
SQL> select empno,ename,deptno
from emp
where deptno=10 or deptno=20;
```
IN 연산자를 사용한다면?
```
SQL> select empno,ename,deptno
from emp
where deptno in(10,20)
```

**<2> ANY 연산자 (조건을 비교할 때 어느 하나라도 맞으면 true)**
```
SQL> select empno,sal
from emp
where sal > any(1000,2000,3000);
==> 결과적으로는 급여가 1000 이상인 row를 select 하게 된다
```

**<3> ALL 연산자 (조건을 비교할 때 조건이 모두 맞으면 true)	**
```
SQL> select empno, sal
from emp
where sal > all(1000,2000,3000)
==> 결과적으로는 급여가 3000 이상인 row를 select 하게 된다
```
**<4> EXISTS (데이터가 존재하면 true)**
 - 사원이름이 'FORD'인 사원이 존재하면 사원의 이름과 커미션을 출력하기



-부서 번호가 10번인 사원들과 급여과 같은 급여를 받는 사원의 이름과 급여를 출력
단, 10번 부서는 제외
```
SQL> select ename,sal,deptno
from emp
where sal in(select sal from emp where deptno=10)
and deptno != 10;
```

- 부서번호가 10번인 사원들이 받는 급여보다 많은 급여를 받는 사원들의 이름과 급여를 출력해보세요
```
SQL> select ename,sal
from emp
where sal > any(select sal from emp where deptno=10);
```

- 부서번호가 10번인 사원들이 모든 사원들이 받는 급여보다 
많은 급여를 받는 사원의 이름과 급여를 출력해보세요
(한 명이라도 10번 부서의 사원보다 급여가 적으면 안된다)
```
SQL> select ename,sal
from emp
where sal > all (select sal from emp where deptno=10);
```

**<3> 다중 칼럼 서브쿼리**
- 서브쿼리의 실행 결과가 여러개의 칼럼을 리턴할 때 사용

- 부서번호가 30번인 사원들의 급여와 커미션이 같은 사원의 이름과 커미션을 출력해보세요
```
SQL> select ename,comm,deptno
from emp
where (sal,comm) in (select sal,comm from emp where deptno=30);
```

**<4> 상호 관련 서브쿼리 *****
- 메인 쿼리 절에서 사용된 테이블이 서브 쿼리절에 다시 재사용되는 경우의 서브 쿼리이다

- 사원 테이블에서 적어도 한 명의 사원으로부터 보고를 받을 수 있는 
  사원의 사원번호, 이름, 직업, 입사일을 출력해보세요

```
SQL> select empno,ename,job,hiredate
from emp e1
where exists (select * from emp e2 where e2.mgr=e1.empno);

SQL> select empno,ename,job,hiredate
from emp
where empno in (select mgr from emp group by mgr);

SQL> select empno,ename,job,hiredate
from emp
where empno in (select distinct(mgr)from emp);

SQL> select e1.empno,e1.ename,e1.job,e1.hiredate
from emp e1,emp e2
where e1.empno = e2.mgr;
```

**[2] DML (Data Manipulation Language)**
- 테이블 내의 데이터를 입력,수정,삭제

**1)INSERT : 테이블에 데이터를 저장할 때 사용**

**(1) 형식**
	INSERT INTO 테이블명 (칼럼명1,칼럼명2.....)
	VALUES(값1,값2.....)
**(2) 입력시 제약 사항**
 - 한 번에 하나의 행만 입력할 수 있다
 - INSERT 절에 명시되는 칼럼의 갯수와 VALUES 절의 갯수는 일치해야 한다
 - 모든 칼럼의 내용을 다 저장할 때는 칼럼명은 생략 가능하다
 - commit을 반드시 입력해야 한다

 ex)EMP 테이블에 아래와 같은 사원을 추가해보세요
 EMPNO : 8000
 ENAME : 이현진
 JOB : 방장
 MGR : 7900
 HIREDATE : 오늘
 SAL : 18
 COMM : 100
 DEPTNO : 40
 delete from emp2
 where(ename='');

 
- 연습용 테이블 만들기
```
SQL> create table member (num number primary key,name varchar2(30),addr varchar(50));
(primary : null,중복 허용하지 않음. ID 값을 입력할 수 있는 키)

SQL> insert into member values(1,'김구리','노량진');
SQL> insert into member values(2,'홍길동','우리집');
SQL> insert into member values(3,'나야나','동대문');
```


**2) update 문 :  데이터를 수정할 때 사용하는 문장**

**(1) 형식**
 update 테이블명 set 칼럼명1 = 수정값, 칼럼명2 = 수정값
 where 조건절

ex) member 테이블의 내용 중 num 칼럼이 3인 회원의 주소를 인천으로 수정하세요
```
SQL> update member set addr = '인천' where num = 3;
SQL> update member set name = '김태호' where num = 1;
```
ex) member 테이블의 내용 중 num 칼럼이 2인 회원의 이름과 주소를 '철수','강남'으로 바꿔보세요
```
SQL> update member set name='철수',addr = '강남' where num = 2;
```
**3) delete 문 :  데이터를 삭제할 때 사용하는 문장**

(1) 형식
delete from 테이블명 where 조건절

ex) member 테이블에서 주소가 '강남'인 회원의 정보를 삭제해보세요
```
SQL> delete from member where addr='강남'; 
```


**[3] TCL (Transaction Control Language)**
- DML 문이 실행되어 DBMS에 저장되거나 되돌리기 위래 실행되어야 하는 SQL문

**1) 트랜젝션**
- 분리되어서는 안되는 논리적 작업단위

ex) 자신의 통장에서 타인에게 송금한다고 가정을 한다면...?

<-트랜젝션의 시작->
-내 통장에서 금액이 빠져나간다
-수취인 통장에 돈이 입금된다
<-트랜젝션의 끝->


**(1)트랜젝션의 시작**
- DBMS에 처음 접속 하였을 때
- DML 작업을 한 후 COMMIT 혹은 ROLLBACK을 실행했을 때

**(2)끝**
- COMMIT이나 ROLLBACK이 실행되는 순간
- DB가 정상/비정상 종료될 때
- 작업(세션을 종료할 때)

**(3)TCL의 종류**
- COMMIT : SQL문의 결과를 영구적으로 DB에 반영
- ROLLBACK : SQL문의 실행결과를 취소할 때
- SAVEPOINT : 트랜젝션의 한지점에 표시하는 임시 저장점

```
ex)
SQL> insert into member values(4,'AAA','BBB');
SQL> savepoint mypoint;
SQL> insert into member values(5,'bbb','BBB');
SQL> insert into member values(6,'ccc','BBB');
SQL> rollback to mypoint;
SQL> commit;
```
	
**[4] DDL(Data Definition Language)**
- 데이터 베이스 내의 객체(테이블,시퀀스...) 등을 생성하고 변경하고 삭제하기 위해서 사용되는 SQL문

**1) DDL의 종류**

```
ex) 일반적인 테이블 생성

SQL> create table test(num number,name varchar2(20)); -테이블생성
```
- 참고 - 
```
SQL> DESC test; --테이블 구조 보기
```
```
ex) 테이블 복사하기
SQL> create table dept2(deptno number(2),dname varchar2(14),loc varchar2(13));

ex) dept테이블을 dept2에 복사하기
SQL> insert into dept2 select * from dept;


ex) 테이블 복사하기2 (CTAS 기법) => 제약조건은 복사가 안된다
SQL> create table dept3 as select*from dept;

ex) 테이블의 구조만 복사하려면 (조건이 항상 거짓이 되는 편법사용)
SQL> create table dapt4 as select*from dept where 1=2;
```

**2) ALTER : 객체를 변경할 때**
```
SQL> desc simple;

ex) 
SQL> create table simple(num NUMBER);    --테이블 생성

SQL> alter table simple add(name varchar2(3)); 
SQL> alter table simple modify(name varchar2(30));
SQL> alter table simple drop column name;

SQL> alter table simple add(addr varchar2(50)); 
SQL> alter table simple modify(addr varchar2(100));
SQL> alter table simple drop(addr);
```

**3) DROP :  객체를 삭제할 때**
```
SQL> drop table dept2;
SQL> drop table dept3;
SQL> drop table dept4;
SQL> drop table simple;
```

**[5] 제약조건(Constraint)**
- 테이블의 해당칼럼에 원하지 않는 데이터를 입력/수정/삭제 되는 것을 방지하기
위해 테이블 생성 또는 변경시 설정하는 조건이다(저장된 테이터의 신뢰성을 높이기 위해)

**1) 종류**

**(1)NOT NULL : NULL로 입력이 되어서는 안되는 칼럼에 부여하는 조건으로 칼럼 레벨에서만 부여할 수 있는 제약조건이다**

**(2)UNIQUE KEY(유일키) : 저장된 값이 중복되지 않고 오직 유일하게 유지되어야 할 때 사용하는 제약조건이다
(NULL은 허용된다)**

**(3)PRIMARY KEY(대표키) : NOT NULL조건과 UNIQUE KEY를 합친 조건이다 (테이블 하나당 하나는 있어야 한다)**

**(4)CHECK : 조건에 맞는 데이터만 입력되도록 조건을 부여하는 제약조건**

**(5)FOREIGN KEY(외래키) : 부모 테이블의 PRIMARY KEY를 참조하는 칼럼에 붙이는 제약조건이다
(emp 테이블의 deptno칼럼)**


**2) 제약조건(예제)**
```
SQL> create table dept2
(dept number(2) constraint dept2_deptno_pk primary key,
dname varchar2(15) default'영업부',
loc char(1) constraint dept2_loc_ck check(loc in('1','2')));

SQL> insert into dept2 values(10,'회계부','1');
SQL> insert into dept2 (deptno,loc) values(20,'2');

*** CONSTRAINT와 제약 조건명은 생략이 가능하다(칼럼 레벨일 때)
SQL> create table dept3
(dept number(2) primary key,
dname varchar2(15) default'영업부',
loc char(1) check(loc in('1','2')));

SQL> insert into dept3 values(10,'회계','5');
=> 안 된다

*** 외래키를 만들기 위해서는 부모테이블을 먼저 만들어야한다
ex1) 부모테이블 만들기
SQL> create table dept2(
deptno number(2) primary key,
dname varchar2(15) not null);

ex1-1) 부모테이블 참조하는 자식테이블 만들기
SQL> create table emp2(
empno number(4) primary key,
ename varchar2(15) not null,
deptno number(2) references dept2(deptno) );

=> 부모테이블을 마음대로 지울 수 없다. (참조하는 값이 있기 때문에)
```

**3) 제약조건 알아보기**
- 제약 조건 이름 검색하기
```
SQL> select constraint_name from user_constraints;
```
- 제약조건은 수정 불가능, 삭제만 가능하다
```
SQL> alter table dept2 drop constraint 제약조건명;
```
- 제약조건 추가하기
```
SQL> alter table dept2 add(constraint 제약조건명 primary key(deptno));
```


**[6] 시퀀스 (Sequence)**
- 연속적인 숫자 값을 자동으로 증감 시켜서 값을 리턴하는 객체
(프라이머리 키 값으로 주로 사용)
```
SQL> create sequence my_seq ;

SQL> select my_seq.nextval from dual;

SQL> drop sequence my_seq; (commit 없이 바로 지워진다)

SQL> select my_seq.currval from dual 현재 출력된 값이 나온다
```

**[ 형식 ] **
```
SQL> create sequence 시퀀스명
increment by 한 번에 증감할 양(default: +1)
start with 시작 값 (default:0)

SQL> insert into member values(member_seq.nextval,'김태호','노량진');
SQL> insert into member values(member_seq.nextval,'홍길동','인천');
SQL> insert into member values(member_seq.nextval,'나야나','수원');
```

**1) 함수**
**(1) NEXTVAL : 다음 값을 얻어온다**
```
SQL> select my_seq.nextval from dual;
```
**(2) CURRVAL : 현재 값을 얻어온다**
```
SQL> select my_seq.cuRRVAL from dual;
```
- 시퀀스 삭제
```
SQL> drop sequence 시퀀스명;
```
- 사용하고 있는 시퀀스명 조회하기
```
SQL> select sequence_name from user_sequences;
```
 
**[7] ROWID와 ROWNUM**
- 오라클에서 테이블을 생성하면 기본적으로 제공되는 칼럼
- ROWID : ROW 고유의 아이디 (ROW를 수정해도 변하지 않음)
- ROWNUM : 행의 INDEX (ROW 삭제시 변경될 수 있다)
```
ex)
SQL> select rowid,rownum from member;

ex)
SQL> select rowid,rownum,name from member;

ex) ROW의 갯수를 알고 싶다면?
SQL> select count(*) from member; 
SQL> select max(rownum) from member; 
SQL> select count(rownum) from member; 
```

**[8] 계정관리하기**

**1)생성**
-관리자 권한이 있는 관리자 계정으로 접속
```
SQL> comn system / master;
```

**-계정 생성하기**
```
SQL> create user 아이디 identified by 비밀번호 :
```
- 권한 주기
```
SQL> grant resource,connect to 생성한 아이디;
```
- 생성된 계정으로 접속하기
```
SQL> comn 아이디 / 비밀번호;
```

**2) 삭제**
- 계정 삭제 권한이 있는 관리자 계정으로 접속
```
SQL> drop user 아이디 ;         -- 생성된 객체가 있으면 삭제가 안된다
SQL> drop user 아이디 cascade;  -- 무시하고 삭제 가능
```

**3) 비밀번호 수정**
```
- alter user 아이디 identified by 수정할 비밀번호
```

**[9] 스칼라 타임 (오라클 데이터형)**
- char : 고정 길이의 문자, 최대 2000 byte
- varchar2 : 가변길이의 문자, 최대 4000 byte
- number : 숫자값을 -38 자리수부터 +38 자리수를 저장가능
	 ex) number(10) 정수 10자리
	 ex) number(10,2) 전체 자리수, s는 소수점 이하 자리수
	 ex) number(p, s) p는 전체 자리수, s는 소수점 이하 자리수

- clob : 문자 데이터 최대 4GB 까지 저장 가능하다
	 JDBC 에서 읽어올 때, getString()으로 읽어올 수 없다
	 getclob()으로 읽어와야 한다

- date : 날짜(시간) 저장 JDBC에서 getDate() 로 불러 올 수 있지만
	 to_char 함수를 이용해서 문자열로 바꿔서 읽어와야 한다
	 문자열로 바꾸엇다면 getString() 으로 읽어올 수 있다

- blob : 2진 데이터, 즉 바이너리 데이터를 저장할 때 사용한다

**[[ 커멘드(DOS) 창에서 명령어 사용하기 ]]**
```
dos> lsnrctl stop : 오라클 리스너 정지하기
dos> lsnrctl start :  오라클 리스너 시작하기
dos> isnrctl status : 현재 리스터 상태보기
dos> tnsping dbname : 숫자(확인횟수) : 접속할 DB와의 통신상태 확인
```