/*
	cmd로 mysql을 실행할 시
	show databases : database들의 이름 확인
    show tables from database이름 : database의 테이블 이름 확인
    show columns from table이름 : 테이블의 컬럼 이름 확인
    cmd 창 2개 켜놓고 하는게 편할듯
	cmd창에서도 모두 똑같이 명령어 사용 가능
    mysql.exe가 있는 위치에 가서 mysql -uroot (u계정명) -p1234 (p비밀번호)로 실행

*/

USE hrdb2019;
SELECT database();
/*
	테이블의 구조 확인 : DESC
    형식: DESC 테이블명;
    Schemas가 없을 시 구조 확인하려고 사용
*/
desc employee; -- 사원은 반드시 하나의 부서에 소속된다.
desc department;
desc unit;
desc vacation;
-- Primary key(PRI)를 가진 데이터가 부모 (모든 primary key를 가진 데이터가 자식을 가지는 건 아니다)
/*
	단순 조회 (R: select)
    형식 : select [컬럼리스트] from [테이블명];
*/
-- employee 테이블에 있는 사원 id, 사원명, 이메일을 조회해주세요 (id는 보통 pk)
select emp_id, emp_name, email from employee;
-- insert 할 때 실린더 휠이 멈춘 가장 가까운 비어있는 메모리에 넣는다 그래서 위치가 뒤죽박죽이다 그래서 order by로 정렬한다

-- employee 테이블에 있는 모든 컬럼을 조회  
select * from employee;
-- department 테이블의 모든 컬럼을 조회
select * from department;
-- 실무에선 * 사용을 권장하지 않는다
-- employee 테이블의 사원 emp_id 컬럼명을 사원번호로 변경 후 조회
select emp_id as '사원 번호' from employee;
-- 띄어쓰기 주의 '' 따옴표로 묶어주면 띄어쓰기 가능
-- employee 테이블의 모든 사원의 급여,보너스(연봉의 10%) 조회 / 함수로 만든 Column에도 별칭 부여 가능
select salary, salary*0.1 as bonus from employee;

-- 현재 날짜를 가져오는 함수에 별칭 부여 모든 Columns엔 별칭 부여 가능
select CURDATE() as today ;
 
/*
	조건별 조회 
    형식:select	[컬럼리스트]
		from	[테이블명]
		where	[조건절]; 비교연산자 사용 가능/문자가 포함되어있으면 ''따옴표로 묶어줘야한다.
*/
-- 사원 id가 S0007에 해당하는 사원정보를 모두 조회
select * from employee where emp_id ='S0007';
-- 사원명이 일지매인 사원의 모든 정보를 조회
select * from employee where emp_name = '일지매';
-- 홍길동 사원의 사원아이디,성별,폰번호,이메일,연봉 조회
select emp_id,gender,phone,email,salary
from employee 
where emp_name = '홍길동';

-- 총무부에 속한 모든 사원의 정보를 조회
select * from department;
select * from employee where dept_id = 'GEN';

-- 모든 남자사원의 사원명, 입사일, 폰번호, 연봉 조회
select emp_name,hire_date,phone,salary from employee where gender = 'M';

-- NULL:미지수 , 정의되지 않은 데이터
-- eng_name이 현재 정의되지 않은 사원 조회
-- eng_name이 없다고 표현하지 않음 데이터가 나중에 들어갈 수 있기 때문에
-- eng_name = null이 제대로 작동하지 않는 이유 
select *
from employee
where eng_name is null;

-- eng_name이 null이 아닌 사원들을 모두 조회
select *
from employee
where eng_name is not null;


/*
	NULL 값을 다른값으로 대체하는 함수 : ifnull()
    형식 : ifnull(null포함 컬럼명, 변경하는값)
    select ifnull(null값이 포함되어 있는 columns, 원하는 값) from Tables;
*/
-- eng_name이 null인 사원들의 null값을 'honggildong'으로 대체한 후 조회

select ifnull(eng_name, 'honggildong') from employee;
-- 실제로 테이블 안의 값이 바뀌진 않고 select (조회)했을 때만 바뀌어 보인다)
select ifnull(retire_date, curdate()) from employee;
select ifnull(retire_date, curdate()) as retire_date from employee;
-- 컬럼명이 ifnull(retire_date, curdate())로 변하기 때문에 컬럼명을 as로 변경해준다 실제 개발할 때 써야하는 이름이기 때문

/*
	중복된 데이터를 배제하고 조회 : distinct
    형식 : select distinct 컬럼리스트 from 테이블명
*/
-- 사원테이블에 존재하는 모든 부서번호를 조회
select * from employee;
select dept_id from employee;
select distinct dept_id from employee;

-- ctrl + L = 한줄 삭제
/*
	데이터 정렬 : order by
    형식 : select 컬럼리스트
		  from	 테이블명
		  where	 조건절
          order by 컬럼명 ASC / DESC (ASC가 Default)
*/
-- 사원 id 기준으로 오름차순 정렬 후 모든 데이터 출력
select * 
from employee 
order by emp_id;

-- 입사일이 가장 빠른 순서대로 사원들을 모두 조회
select *
from employee
order by hire_date;

-- 연봉이 가장 높은 순으로 사원들을 모두 조회
select *
from employee
order by salary DESC;

-- eng_name이 null인 사원들 중 입사일이 가장 빠른순서대로 조회
select *
from employee
where eng_name is null
order by hire_date;

-- 정보시스템 부서 사원 중 입사일이 가장 빠르고, 급여를 많이 받는 순서로 정렬하여 조회
select * from department;
select * from employee where dept_id = 'SYS' order by hire_date,salary DESC;



