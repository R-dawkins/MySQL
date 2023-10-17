-- 2023-10-11
/*
	cmd로 mysql을 실행할 시
	show databases : database들의 이름 확인
    show tables from database이름 : database의 테이블 이름 확인
    show columns from table이름 : 테이블의 컬럼 이름 확인
    cmd 창 2개 켜놓고 하는게 편할듯
	cmd창에서도 모두 똑같이 명령어 사용 가능
    mysql.exe가 있는 위치에 가서 mysql -uroot (u계정명) -p1234 (p비밀번호)로 실행
	insert 키 = 문자 삽입,수정 토글키 

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

-- 2023-10-12
/*
	특정 데이터를 검색 : where 조건절 + 비교연산자
    형식 : select [컬럼리스트] from [테이블명] where [조건절 + 비교연산자]
*/
-- 연봉이 5000 이상인 사원들만 연봉이 높은 순으로 조회
select * from employee where salary >= 5000 order by salary DESC;

-- 2015년 1월 1일 이후 입사자들을 입사일이 빠른 순서대로 조회 데이터타입이 문자여도 숫자는 비교 연산 가능
-- 조회기준 연봉이 null인 직원의 값은 0으로 정의
select * from employee where hire_date >= '2015-01-01' order by hire_date;
select emp_id, emp_name, gender, hire_date, ifnull(salary,0)as salary from employee;
-- 함수가 columns에 사용되면 무조건 별칭(as)를 달아준다.

-- 입사일이 2016년 1월 1일 이후 이고, 연봉이 6000 이상인 사원들을 조회
-- 최근 입사일 기준으로 정렬
select * from employee where hire_date >= '2016-01-01' && salary >= 6000 order by hire_date DESC;
select * from employee where hire_date >= '2016-01-01' and salary >= 6000 order by hire_date DESC;

select * from employee where hire_date >= '2016-01-01' || salary >= 6000 order by hire_date DESC;
select * from employee where hire_date >= '2016-01-01' or salary >= 6000 order by hire_date DESC;

-- 정보시스템 부서 중 급여가 7000 이상인 사원들만 출력 
select emp_id, emp_name, eng_name, gender, hire_date, dept_id, phone, email, salary, ifnull(retire_date, curdate()) as retire_date from employee where dept_id = 'SYS' and salary >= 7000;

-- 영업부 직원의 사원아이디, 사원명, 성별, 입사일, 이메일, 연봉, 보너스(연봉의 20%) 조회
-- 연봉과 보너스가 null인 사원은 기본값을 50으로 정의
select emp_id, emp_name, gender, hire_date, email, ifnull(salary, 50) as salary, ifnull(salary*0.2, 50) as bonus from employee where dept_id = 'MKT';
-- 보너스가 1000 이상인 직원만 조회
select emp_id, emp_name, gender, hire_date, email, ifnull(salary, 50) as salary, ifnull(salary*0.2, 50) as bonus from employee where salary*0.2 > 1000;

/* 
	범위 조회 : between ~ and
    형식 : where [컬럼명] between [시작] and [종료] - [시작] 이상 [종료] 이하만 가능
*/
-- 연봉이 6000 이상, 7000 미만인 사원들만 조회
select * from employee where salary >= 6000 and salary < 7000;
-- 입사년도가 2015년 (2015-01-01 ~ 2015-12-31)인 사원들만 조회 (hire_date는 데이터 타입은 문자이지만 숫자가 있으므로 조건절에서 사용 가능하다)
select * from employee where hire_date >= '2015-01-01' and hire_date <= '2015-12-31';
-- between ~ and로 대체
select * from employee where salary between 6000 and 6999;
select * from employee where hire_date  between '2015-01-01' and '2015-12-31';

/*
	or 논리연산자와 유사한 in
    형식 : where [컬럼명] in(값1,값2...)
*/
-- 정보시스템 부서와 영업부서의 사원들만 조회
select * from employee where dept_id = 'SYS' or dept_id = 'MKT';
-- in으로 대체
select * from employee where dept_id in('SYS','MKT');

/*
	문자열 검색 : 와일드 문자(%, _) like 연산자와 함께 사용
    형식 : where [컬럼명] like '검색문자 + 와일드 문자'
    %: 0개 이상의 문자를 나타냅니다.
	_: 단일 문자를 나타냅니다.
	[]: 대괄호 내의 모든 문자를 나타냅니다.
	^: 대괄호에 없는 문자를 나타냅니다.
	-: 문자의 범위를 나타냅니다.
    
    *DB연동시 주의사항*
    MySQL workbench에서 실행 해 보고 잘 되는지 확인하고 개발쪽으로 코드 넘기기
*/
-- 사원들 중 김씨 성을 가진 모든 사원 조회
select * from employee where emp_name like '김%';
-- 폰번호가 010으로 시작하는 영업부의 모든 사원 조회
select * from employee where dept_id = 'MKT' and phone like '010%';
-- 이메일주소 두번째 자리에 'a'가 들어가는 사원 조회
select * from employee where email like '_a%';
-- 이메일 아이디가 4자리인 사원 조회
select * from employee where email like '____@%';
-- 사원명에 '삼'자가 들어가는 모든 사원 조회;
select * from employee where emp_name like '%삼%';

/*
	내장 함수 사용 : 숫자함수, 문자함수, 그룹함수, 날짜함수 ...
    형식 : 컬럼리스트나 조건절에 추가
    select, insert 등등에서 사용
*/
-- 함수 테스트 테이블 : Dual 
-- 123, -123의 절대값 출력
select abs(123), abs(-123) from dual;
-- dual이라는 함수 테스트용 테이블 생략가능
select abs(123), abs(-123);
-- 숫자함수
-- 소수점 버리기 : floor()
select floor(123.456), floor(3134.134130513);

-- 소수점 자리 정하기 : trucate(num, 자릿수)
select truncate(123.456, 0);

-- 임의의 숫자 생성 : rand() (0.난수의 형식으로 나타남)
select rand(), floor(rand()*1000) as num1, truncate(rand()*1000,2) as num2;

-- 나머지 연산자 : mod();
select mod(100,1), mod(100,47);
select mod(floor(rand()*1000),2); -- 1이 나오면 홀수 0이 나오면 짝수

-- 문자함수
-- 문자열 결합 : concat()
select concat('my','sq','l');

-- 홍길동(S0001) 식으로 조회
select concat(emp_name,'(',emp_id,')') as emp_name from employee;
-- 홍길동(S0001) 사원만 조회
select concat(emp_name,'(',emp_id,')') as emp_name from employee where concat(emp_name,'(',emp_id,')') = '홍길동(S0001)';

-- 문자열 추출 : SUBSTRING(문자열,위치,원하는길이)
select substring('대한민국',1,2);
select substring('대한민국 홍길동',6,3);

-- 사원아이디, 사원명, 입사년도, 폰번호, 이메일 조회
select emp_id, emp_name, phone, email,
substring(hire_date,1,4) as year,
substring(hire_date,6,2) as mm,
substring(hire_date,9,2) as dd
from employee;
-- 2015년도 입사자들 모두 조회 (substring을 이용하여 일부의 범위만 조회 가능)
select * from employee where substring(hire_date,1,4) = '2015';
-- 1월에 입사한 사원들 조회
select * from employee where substring(hire_date,6,2) = '01';
-- 2018년도에 입사한 정보시스템 부서 사원 조회
select * from employee where substring(hire_date,1,4) = '2018' and dept_id = 'SYS';

-- 오른쪽, 왼쪽 기준 문자열 추출 : left('문자열',자릿수), right('문자열',자릿수)
select left('hello',1), right('hello',1);
-- left는 왼쪽부터 1글자, right는 오른쪽부터 1글자를 가져왔다
-- 2018년도에 입사한 정보시스템 부서 사원 조회
select * from employee where left(hire_date,4) = 2018 and dept_id = 'SYS';
-- 대,소문자 변경 : upper('문자열'), lower('문자열')
select upper('abs'), lower('ABC');
select * from employee where emp_id = 's0001';
/*
	mysql에서는 대소문자를 자동으로 변경해주지만 다른 툴에서는 대소문자를 명확히 구분해야하는 경우가 있다.
*/
-- 검색하는 데이터가 소문자로 전달되는 경우 원하는 데이터 대문자로 이루어진 경우 원하는 데이터를 얻지 못하는 경우가 생길 수 있다
-- 그럴 때 upper와 lower를 사용할 수 있다
select * from employee where dept_id = upper('sys');

-- 공백 삭제 : trim('공백포함 문자열')
select trim('대한민국     만세'); 
select trim('        대한민국   ');
-- 특정 문자 삭제 : trim(leading '삭제할문자' from '삭제될문자...문자열'); trim(trailing '삭제할문자' from '문자열...삭제될문자');
select trim(leading '!' from '!!!!대한민국     ');
select trim(trailing '!' from '대한민국!!!!!!!');

-- 문자열 포맷 format(숫자, 소숫점자릿수)
select format(12345678,0);
-- 사원아이디, 사원명, 입사년도만, 연봉을 3자리로 구분하여 출력\
select emp_id, emp_name, concat(left(hire_date,4),'년') as hire_date, concat(format(salary,0),' 만원') as salary from employee;

-- 날짜 함수 : curdate(년월일반환), sysdate(년월일시분초반환), now(년월일시분초반환)
select curdate(); -- '2023-10-12'
select sysdate(); -- '2023-10-12 15:06:01' 함수기준으로 반환
select now(); -- '2023-10-12 15:06:01' 쿼리기준으로 반환
-- sysdate와 now의 차이
select sysdate(), sleep(2), sysdate(); -- 함수가 실행된 시간을 반환함
-- sleep은 n초의 딜레이를 주는 효과
select now(), sleep(2), now(); -- 쿼리가 실행된 시간을 반환함

-- 형변환 함수 : cast(변환하고자하는 데이터 as 변환데이터타입),
-- 				 convert(변환하고자하는 데이터 as 변환데이터타입)
-- mysql에서는 자동으로 변환이 된다
select cast(20231012 as char); -- 숫자를 문자로
select cast(20231012 as date); -- 숫자를 날짜로
select cast('20231012' as date); -- 문자를 날짜로

-- 123456789 숫자를 문자로 변환 후 3자리 숫자로 구분
select format(cast(123456789 as char),0);
select format(123456789, 0);

-- 현재 날짜를 가져와서 (년,월,일) 문자로 변경, 다시 날짜타입(datetime)으로 바꾸기 datetime은 년월일시분초 time은 시분초
select cast(cast(curdate() as char) as datetime);

-- 현재 날짜를 가져와서 (년,월,일,시,분,초) 문자로 변경, 다시 날짜타입(datetime)으로 바꾸기 datetime은 년월일시분초 time은 시분초
select cast(cast(now() as char) as datetime);

-- employee 테이블의 입사일이 저장될 때 사용 된 함수는 무엇일까?
select emp_name, hire_date from employee;
select emp_name, cast(hire_date as datetime) from employee;

-- 입력폼에서 '20150101' 문자열 타입으로 전송되어진 경우, 해당일의 입사자를 모두 조회
select * from employee where hire_date = cast('20150101' as date);
select * from employee where hire_date = '20150101';
select * from employee where hire_date = 20150101;
-- mysql에서는 타입을 변경하지 않아도 모두 조회가 된다 mysql이 자동으로 변환하여 조회함

-- 2023-10-13

/*
	1. 그룹(집계) 함수 : count(), sum(), avg(), max(), min()...
    2. Group by - 그룹함수가 적용되기 전 그룹화하는 작업의 기준
    3. Having - 그룹함수에 적용하는 조건절 (where 조건절은 그룹함수에 적용하지못함)
*/


-- 1. 그룹함수 : 형식 - 컬럼리스트가 위치하는 곳에 함수 호출
-- count()
select count(*) from employee; -- 20
select count(salary) from employee; -- 19 (그룹함수는 null을 제외하고 실행되기 때문)
select count(ifnull(salary,500)) from employee;
select emp_name, salary from employee where salary is null;
select count(emp_id) from employee; -- 전체데이터 기준 : *, 기본키컬럼(pk)

-- sum(숫자데이터 컬럼) 
-- 총급여를 3자리로 구분하고 '만원' 단위를 추가해서 조회 해보시오
select concat(format(sum(salary),0),'만원') '총급여' from employee; -- as는 생략가능

-- avg(숫자데이터 컬럼)
-- 평균 급여를 3자리로 구분하고 '만원' 단위를 추가 단, 소수점이 있는 경우 모두 절삭
-- format은 반올림 floor는 버림(내림)인듯
select concat(format(floor(avg(salary)),0),'만원') '평균 급여' from employee;
select avg(salary) from employee;

-- 총급여와 평균급여 출력
select concat(format(sum(salary),0),'만원') '총급여' ,concat(format(floor(avg(salary)),0),'만원') '평균 급여' from employee;

-- 총연봉, 평균연봉, 최대연봉, 최저연봉
select concat(format(sum(salary),0),'만원') '총급여' 
,concat(format(floor(avg(salary)),0),'만원') '평균 급여'
,concat(format(max(salary),0),'만원') '최대 연봉'
,concat(format(min(salary),0),'만원') '최저 연봉' 
from employee;

-- 가장 빠른 입사일, 가장 최근 입사일
select min(hire_date),max(hire_date) from employee;

-- 부서별 총연봉, 평균연봉, 최대연봉, 최저연봉
-- 그룹화 하는 것에 사용된 컬럼만 그룹함수와 함께 사용 가능하다
-- group by에 추가 되지 않은 일반 컬럼은 그룹함수와 함께 사용할 수 없다
select dept_id, sum(salary),avg(salary),max(salary),min(salary) from employee group by dept_id; -- 정상
select emp_id, sum(salary),avg(salary),max(salary),min(salary) from employee group by dept_id; -- 오류
select dept_id, sum(salary),avg(salary),max(salary),min(salary) from employee group by dept_id; -- group by 컬럼 기준으로 내부 정렬이 진행됨

select emp_id, sum(salary), avg(salary) from employee group by emp_id; -- 기본키의 group by는 개별적인 데이터 기준으로 그룹핑 되기 때문에 의미가 없다

-- 입사년도별 
select left(hire_date,4), sum(salary), avg(salary), max(salary), min(salary) from employee group by left(hire_date,4);
select hire_date, sum(salary), avg(salary), max(salary), min(salary) from employee group by hire_date; -- 의미없는 그룹화
select left(hire_date,4), sum(salary), avg(salary), max(salary), min(salary) from employee group by hire_date; -- 입사년도로 그룹화되지않는다, 입사년월일로 그룹화됨
select left(hire_date,4),dept_id, sum(salary), avg(salary), max(salary), min(salary) from employee group by left(hire_date,4),dept_id;
-- 입사월별 사원수, 총연봉, 평균연봉, 최대연봉, 최저연봉
select * from employee;
select substring(hire_date,6,2) as 입사월 , dept_id
, count(*) as 인원수
, sum(salary), avg(salary)
, max(salary), min(salary) 
from employee group by substring(hire_date,6,2) ,dept_id
order by substring(hire_date,6,2) desc;

-- 부서별 사원수가 2명인 부서만 출력
select dept_id, count(*) as 사원수 from employee group by dept_id having 사원수 = 2;
/*
	조건절에서의 별칭 사용
    SQL 구문 실행 순서 : FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
    alias (as)의 경우 GROUP BY부터 인식이 가능하기 때문에 HAVING 조건구문을 이용하면 별칭 인식이 가능하다
*/

-- 입사년도별 평균급여가 5000 이상인 해당년도만 출력
select left(hire_date,4) as year, floor(avg(salary)) as 평균급여 from employee group by year having 평균급여 >= 5000;

-- 부서별 최고급여가 6000 이상 7000 미만인 부서 출력
select dept_id as 부서명, max(salary) as 최고급여 from employee group by 부서명 having 최고급여 between 6000 and 6999;

-- rollup 함수를 사용하여 총합계, 소계를 출력
-- 형식 : group by 컬럼 with rollup
-- 부서별 급여총합계를 출력
select dept_id, format(sum(salary),0) from employee group by dept_id with rollup;

-- 입사년도별, 각 부서의 사원수와 총 연봉을 출력
-- 단, 급여가 없는 부서는 그룹핑하지 않는다.
select left(hire_date,4) as 년도, dept_id, count(*), format(sum(salary),0) from employee where salary is not null group by 년도,dept_id with rollup;
-- 그룹화 하기 전에 where절로 null인 데이터를 제외하고 그룹화를 하면 메모리가 절약된다

-- 부서별, 사원수 (성별구분)를 조회
select dept_id, gender, count(*) from employee group by dept_id,gender with rollup;

-- 부서별 총연봉
select if(grouping(dept_id),'총합계',ifnull(dept_id,'-')) as 부서명, sum(salary) from employee where salary is not null group by dept_id with rollup;
-- if(grouping(dept_id),'총합계',ifnull(dept_id,'-')) ifnull(dept_id,'-')의 '-'는 소계에 붙는 이름
-- select절에서 if문 사용은 고려해봐야한다(권장되지 않는다). 

/*
	테이블 합치기 : UNION(DISTINCT), UNION ALL
    형식 :  select 쿼리 
			union / union all
            select 쿼리
      
	테이블이 실제로 합쳐지지는 않고 쿼리 실행시에만 하나의 테이블로 출력됨
    하나로 합쳐지는 컬럼명과 수, 데이터타입이 동일해야 함
    UNION(DISTINCT)시 중복되는데이터는 추가되지않고 무시됨
	UNION ALL 시 중복되는 데이터도 추가됨 (중복되는 데이터를 필터링하려고 하지 않기 때문에 필터링과정이 있는 UNION(DISTINCT)보다 메모리 효율성이 높음
    메모리 효율성, 성능에 좋진 않음
    실시간 사용에는 별로
*/
select emp_id,emp_name,dept_id,hire_date, concat('id : ', dept_id) did from employee where dept_id = 'SYS'
union
select emp_id,emp_name,dept_id,hire_date, concat('id : ', dept_id) did from employee where dept_id = 'MKT'
union
select emp_id,emp_name,dept_id,hire_date, concat('id : ', dept_id) did from employee where dept_id = 'ACC';

-- union all
select emp_id,emp_name,dept_id,hire_date, concat('id : ', dept_id) did from employee where dept_id = 'SYS'
union all
select emp_id,emp_name,dept_id,hire_date, concat('id : ', dept_id) did from employee where dept_id = 'MKT'
union all
select emp_id,emp_name,dept_id,hire_date, concat('id : ', dept_id) did from employee where dept_id = 'ACC'
union all
select emp_id,emp_name,dept_id,hire_date, concat('id : ', dept_id) did from employee where dept_id = 'ACC';

-- 서브쿼리(스칼라 서브쿼리/인라인뷰/서브쿼리) 맛보기
-- select 컬럼리스트 from 테이블명 where 조건절
-- select (스칼라 서브쿼리) from (인라인뷰) where (서브쿼리)

-- employee 테이블에 홍길동 사원이 속한 부서의 id를 이용하여 department 테이블에 해당 부서 id에 해당하는 부서명을 조회
select * from department
	where dept_id = (select dept_id from employee where emp_name = '홍길동');

/*
	두 개 이상의 테이블에 대한 쿼리
    -조인(Join)과, 서브쿼리(SubQuery)
*/

-- 워크벤치 툴에서 데이터베이스 기준 ERD 생성
-- DATABASE > REVERSE ENGINEER.. > 과정 진행 후 원하는 database선택 > next...finish

/*
	조인(Join)
		ANSI-SQL		ORACLE
    1. CROSS JOIN <-(합집합 : *)-> CARTESIAN JOIN (실시간 서비스시에는 잘 쓰지 않는다 성능이 중요하기 때문,잘못 사용하면 서버가 마비될 수 있다. 관계성이 없는 테이블끼리 사용) 
    2. INNER JOIN <-(교집합)-> EQUI JOIN (자주 사용하니 매우 중요, 관계성이 있는 테이블끼리 사용 )
    3. OUTER JOIN <-(교집합 + 교집합에서 제외된 데이터)-> OUTER JOIN (누락데이터 없게 )
    4. SELF  JOIN <--> SELF JOIN (요즘엔 잘 쓰이지 않고 Subquery로 처리되는것이 효율적이고 일반적임)
*/

-- A 주머니 - 빨간색구슬, 노란색구슬
-- B 주머니 - 파란색구슬, 보라색구슬
-- A,B에 담긴 전체 구슬 --> 빨,노,파,보 구슬 : 4개(2*2) ---> -- Cross join
-- B에 빨간색 구슬이 추가되었을 때 A,B에 담긴 구슬 중 같은 색깔의 구슬 : 빨간색 >> Inner join
-- A,B에 담긴 구슬 중 같은 색깔 구슬은 1개만 꺼내고 다른 색깔도 함께 꺼냄 --> 빨간색(1), 노란색, 파란색, 보라색 >>Outer join
-- A,B에 담긴 구슬 중 같은 색깔 구슬은 1개만 꺼내고 다른 색깔도 함께 꺼냄 그러나 B주머니에서만 --> 빨간색(1), 파란색, 보라색 >>Outer join

-- hrdb2019 데이터 베이스의 모든 테이블 조회
-- 형식 : select [컬럼리스트] from information_schema.tables where table_schema = '데이터베이스명'
show tables from hrdb2019;

select * from information_schema.tables where table_schema = 'hrdb2019';
desc department;
desc employee;
desc unit;
desc vacation;

-- department(dept_id:PK) <---참조--- employee(dept_id:FK)
-- 이에서 도출되는 명제 : 사원은 하나이상의 부서에 반드시 포함된다.

-- 한 학생은 하나의 과목을 반드시 수강해야한다 
-- 과목(sub_id:PK) <------ 학생(sub_id:FK).

-- 한 명의 고객은 하나 이상의 상품을 주문할 수 있다.
-- 고객() <---- 주문() ----> 상품()

-- unit(unit_id:PK) <----- department(unit_id:FK)
-- Vacation(vacation_id:PK) <----- X
-- Employee(emp_id:PK) <---- Vacation(emp_id:FK)
-- ERD(Entity Relationship Diagram) 데이터베이스의 테이블 간의 구조를 그림으로 그려내어 그 관계를 도출한 다이어그램

-- 정보시스템 부서에 속한 홍길동 사원이 사용한 휴가일수 조회
-- department <---- employee <---- vacation

-- 1. CROSS JOIN : 테이블*테이블*테이블...
-- 형식 : select * from 테이블명 join 테이블명
-- employee 테이블과 department 테이블을 cross Join(cross join은 cross를 생략가능하다)
select count(*) from employee join department; -- 20 * 7 
select * from department cross join employee; -- 7 * 20
select count(*) from employee; -- 20
select count(*) from department; -- 7

-- department 부서와 vacation 부서를 조인하시오
select count(*) from department; -- 7
select count(*) from vacation; -- 102
select count(*) from department join vacation; -- 714
select count(*) from department, vacation; -- 714 (oracle을 벤치마킹했기 때문에 oracle에서 사용하는 형식을 일부 공유하는 것이 있다)

-- department 부서와 vaction 부서, employee를 조인
select count(*) from department as d join vacation as v join employee as e; -- 14280
select count(*) from department d,vacation v,employee e; -- 14280

select count(*)
from (select * from department join vacation) as a
join 
	 (select * from department join vacation) as b;
     
-- excution plan 실행 계획 
-- 각각의 테이블을 스캔하여 곱해서 쿼리블록완성
-- 쿼리탭의 번개모양+돋보기모양 버튼 클릭
-- query cost : 쿼리를 실행하는데 쓰인 비용(시간등의 여러 복합적요소) 비용이 낮을수록 효율적이라고 할 수 있다.

-- 2. Inner join : 테이블간의 기본키와 참조관계가 정의된 경우 사용 (ERD를 확인하면 관계파악이 쉽다)
-- 형식(ANSI-SQL) : select * from 테이블명1 Inner join 테이블명2 on 테이블1.기본키(참조키) = 테이블2.참조키(기본키);  테이블1.기본키 -> 테이블2.참조키 or 참조키 -> 기본키
-- 형식(오라클) : SELECT * FROM 테이블1, 테이블2 WHERE 테이블1.기본키 = 테이블2.참조키; 
select * from department inner join employee on department.dept_id = employee.dept_id; -- ANSI-SQL
SELECT count(*) FROM department d, employee e WHERE d.dept_id = e.dept_id; -- ORACLE

-- 사원id, 사원명,부서id,부서명, 부서생성 날짜 조회 공통되는 컬럼인 dept_id의 소속을 명확하게 해주어야 한다.
select e.emp_id,e.emp_name,d.dept_name,d.start_date,d.dept_id from employee e inner join department d on e.dept_id = d.dept_id order by emp_id;
-- ANSI-SQL department의 dept_id를 조회
SELECT EMP_ID,EMP_NAME,DEPT_NAME,START_DATE,E.DEPT_ID FROM DEPARTMENT D, EMPLOYEE E WHERE D.DEPT_ID = E.DEPT_ID order by emp_id;
-- ORACLE  employee의 dept_id를 조회

-- 홍길동 사원의 부서의 이름과 부서id, 입사일, 연봉을 조회
select emp_name,e.dept_id,dept_name,hire_date,salary from employee e inner join department d on e.dept_id = d.dept_id and emp_name = '홍길동';
-- execute plan(실행계획)에서 보면 employee에서 emp_name이 홍길동인 데이터부터 찾고 그다음에 홍길동의 e.dept_id와 같은 department의 d.dept_id를 찾아서 조인
-- 1 - employee에서 emp_name이 홍길동인 데이터 탐색
-- 2 - 홍길동의 dept_id와 department의 dept_id 조인

-- 영업부에 속해 있는 사원들의 사원명, 입사일, 연봉을 조회
select emp_name,dept_name,d.dept_id,hire_date,salary from department d inner join employee e on d.dept_id = e.dept_id and d.dept_id = 'MKT';
select d.dept_id, d.dept_name, e.emp_name, e.hire_date, e.salary from employee e inner join department d on e.dept_id = d.dept_id and d.dept_name = '영업';

-- 인사과에 속한 모든 사원의 정보를 조회
select * from employee e inner join department d on e.dept_id = d.dept_id and d.dept_name = '인사';

-- 조건에 해당하는 테이블의 가장 작은 데이터셋을 만들어 조인을 한다 (데이터 효율)

-- 인사과에 속한 사원들 중에 휴가를 사용한 사원들 모두 조회
select * from department d inner join employee e inner join vacation v
on d.dept_id = e.dept_id -- 2
and e.emp_id = v.emp_id -- 3
and d.dept_name = '인사'; -- 1
/*
	execute plan(실행계획) 순서
	first - d.dept_name = '인사'
    second - d.dept_id = e.dept_id
    third - e.emp_id = v.emp_id
    forth - select *
*/

-- 인사과에 속한 사원들 중에 휴가를 사용한 사원들 별로 휴가사용횟수 출력 (서브쿼리)
select emp_name, count(*) from (select * from department d inner join employee e inner join vacation v
on d.dept_id = e.dept_id
and e.emp_id = v.emp_id
and d.dept_name = '인사') group by emp_name;

-- 휴가 사용 이유가 '두통'인 사원들 중에 영업부서인 사원의 사원명, 부서명, 폰번호 휴가사용 이유 조회
-- 영업 부서가 속한 본부를 추가로 조회
select e.emp_name,d.dept_name,e.phone,v.reason,u.unit_name 
from department d inner join employee e 
inner join vacation v inner join unit u
on d.dept_id = e.dept_id
and e.emp_id = v.emp_id
and d.unit_id = u.unit_id
and v.reason = '두통'
and d.dept_name = '영업'; -- 자체적으로 두통을 먼저 찾을지 영업을 먼저 찾을지 계산하여 데이터셋이 더 작은 영업을 먼저 찾음

select e1.emp_name, e1.phone,d.dept_name,u.unit_name,v.reason
from
employee e1 inner join department d on e1.dept_id = d.dept_id,
employee e2 inner join vacation v on e2.emp_id = v.emp_id,
department d1 inner join unit u on u.unit_id = d1.unit_id
where v.reason = '두통' and d.dept_name = '영업';
-- sequal-sql

select e.emp_name, e.phone,d.dept_name,u.unit_name,v.reason
from
employee e inner join department d on e.dept_id = d.dept_id
		   inner join vacation v on e.emp_id = v.emp_id
		   inner join unit u on u.unit_id = d.unit_id
           
where v.reason = '두통' and d.dept_name = '영업';


-- 2014년부터 2015년까지 입사한 사원들 중에서 퇴사하지 않은 사원들의 사원아이디,사원명,부서이름,입사일,소속 본부
select e.emp_id,e.emp_name,d.dept_name,e.hire_date,e.retire_date,u.unit_name
from employee e inner join department d inner join unit u on e.dept_id = d.dept_id and u.unit_id = d.unit_id
where left(hire_date,4) between '2014' and '2015' and retire_date is null; -- ansi-sql

select e.emp_id,e.emp_name,d.dept_name,e.hire_date,e.retire_date,u.unit_name
from employee e,department d,unit u
where e.dept_id = d.dept_id and u.unit_id = d.unit_id and left(hire_date,4) between '2014' and '2015' and retire_date is null; -- oracle

-- 3. OUTER JOIN : 교집합(INNER JOIN) + INNER JOIN에서 제외된 데이터를 함께 출력
/*  형식 : SELECT [컬럼리스트] 
	FROM TABLE1 INNER JOIN TABLE2 ON JOINCOLUMN = JOINCOLUMN
    LEFT OUTER JOIN / RIGHT OUTER JOIN ON JOINCOLUMN = JOINCOLUMN
    INNER JOIN 기준으로 LEFT, RIGHT가 나뉜다
    현재 LEFT는 TABLE1 RIGHT는 TABLE2이다
    E.EMP_ID = V.EMP_ID(+) => 오라클 형식
    SELECT [컬럼리스트] FROM TABLE1 LEFT/RIGHT OUTER JOIN TABLE2 ON JOINCOLUMN = JOINCOLUMN => 발전한 요즘 형식
    *** OUTER JOIN을 사용시에는 반드시 누락되는 데이터가 없도록 확인
    OUTER JOIN은 INNER JOIN + 제외된 데이터(JOINCOLUMN이 NULL인 데이터)
*/
-- 모든 부서의 정보와 소속 본부명을 함께 조회
SELECT * FROM DEPARTMENT D RIGHT OUTER JOIN UNIT U ON D.UNIT_ID = U.UNIT_ID; -- 전략기획이 출력되지않음 데이터 누락
SELECT * FROM UNIT U RIGHT OUTER JOIN DEPARTMENT D ON D.UNIT_ID = U.UNIT_ID; -- 전략기획이 출력됨
SELECT * FROM DEPARTMENT D LEFT OUTER JOIN UNIT U ON D.UNIT_ID = U.UNIT_ID;

/* 
	SELECT DEPT_ID, DEPT_NAME, UNIT_NAME
	FROM DEPARTMENT D, UNIT U
	WHERE D.UNIT_ID(+) = U.UNIT_ID;
    ORACLE 방식 
*/

-- 2017년도부터 2018년도까지 입사한 사원들의 사원명, 입사일, 연봉, 부서명 모두 조회 단, 퇴사한 사원들도 모두 조회
-- 소속 본부를 모두 조회
select emp_name,hire_date,salary,dept_name,retire_date,e.dept_id from employee e right outer join department d on e.dept_id = d.dept_id where left(hire_date,4) between '2017' and '2018';

select emp_name,hire_date,salary,dept_name,retire_date,e.dept_id,u.unit_name 
from employee e 
inner join department d on e.dept_id = d.dept_id 
left outer join unit u on u.unit_id = d.unit_id	/* innerjoin을 한 결과를 가지고 outer join을 하는 것 */
where left(hire_date,4) between '2017' and '2018';

/*
	select emp_name,hire_date,salary,dept_name,retire_date,e.dept_id,u.unit_name 
	from employee e, department d,unit u 
	where e.dept_id = d.dept_id 
	and u.unit_id(+) = d.unit_id	 null을 가지게 되는 테이블에 (+) : oracle형식 
	and left(hire_date,4) between '2017' and '2018';
*/

/* 
	서브쿼리 : 메인쿼리(조회하는 컬럼리스트)에 서브쿼리를 추가하여 실행하는 형식
	select 컬럼리스트 	  from 테이블명 	where 조건절
		(스칼라 서브쿼리)     (인라인뷰) 		(서브쿼리)
        (오라클에서는 지원x) 
*/

-- 홍길동 사원이 속한 부서의 이름을 출력
select dept_name from employee e inner join department d on e.dept_id = d.dept_id where emp_name = '홍길동'; -- innerjoin
select dept_name from department where dept_id = (select dept_id from employee where emp_name = '홍길동'); -- 서브쿼리 (row가 하나인 서브쿼리는 단일행서브쿼리라고 한다 여러개면 다중행)

-- 홍길동 사원이 사용한 휴가 내역을 조회
select vacation_id,reason,emp_id from vacation where emp_id = (select emp_id from employee where emp_name = '홍길동');

-- 제3본부에 속해있는 부서들을 조회
select * from department where unit_id = (select unit_id from unit where unit_name = '제3본부');

-- 제3본부에 속해있는 모든 사원들을 조회
-- 단일행 서브쿼리 : 서브쿼리를 실행한 결과가 1행만 출력되는 경우
-- 다중행 서브쿼리 : 서브쿼리를 실행한 결과가 2행 이상 출력되는 경우
select * from employee where dept_id in(select dept_id from department where unit_id = (select unit_id from unit where unit_name = '제3본부'));

-- 가장 먼저 입사한 사원의 정보를 출력
select * from employee where hire_date = (select min(hire_date) from employee);

-- 휴가를 간 적이 있는 정보시스템 부서의 사원들을 출력

select * from employee 
where emp_id 
in(select distinct emp_id from vacation where emp_id in(select emp_id from employee where dept_id = (select dept_id from department where dept_name = '정보시스템'))); -- 비효율적인 쿼리

-- 휴가를 간 적이 없는 정보시스템 부서의 사원들을 출력
select * from employee
where dept_id = (select dept_id from department where dept_name ='정보시스템')
and emp_id not in (select distinct emp_id from vacation);

-- 사원별 휴가사용 일수를 그룹핑하여, 사원아이디, 사원명, 입사일, 연봉, 휴가사용일수 조회
-- 휴가 사용일수를 구하는 인라인 뷰와 사원 테이블을 조인
select * from employee e left outer join (select emp_id,sum(duration) as duration from vacation group by emp_id) v on e.emp_id = v.emp_id; -- outer join (휴가를 쓰지 않은 사람들 포함)
select * from employee e inner join (select emp_id,sum(duration) as duration from vacation group by emp_id) v on e.emp_id = v.emp_id; -- inner join (휴가를 쓰지 않은 사람들은 포함되지않음)

-- 휴가 사용일수와 사원정보, 모든 사원, 휴가 사용일수가 없는 사원은 0으로
select e.emp_id,e.emp_name,e.hire_date,ifnull(e.salary,0) as salary,ifnull(v.duration,0) as duration
from employee e left outer join (select emp_id,sum(duration) as duration from vacation group by emp_id) v 
on e.emp_id = v.emp_id;

select count(*) from (select e.emp_id,e.emp_name,e.hire_date,e.salary,v.duration 
from employee e inner join (select emp_id,sum(duration) as duration from vacation group by emp_id) v 
on e.emp_id = v.emp_id) vp; -- count 그룹함수를 사용하려고 할 때 

-- myshop2019
use myshop2019;
select database();
select count(*) from category;
select count(*) from sub_category;
select count(*) from product;

select c.category_id, c.category_name, s.sub_category_id,s.sub_category_name,p.product_id,p.product_name from category c
inner join sub_category s
inner join product p
on c.category_id = s.category_id and s.sub_category_id = p.sub_category_id;
-- ansi-sql

select * from category c,sub_category s, product p
where c.category_id = s.category_id and s.sub_category_id = p.sub_category_id;
-- oracle

select c.category_id, c.category_name, s.sub_category_id,s.sub_category_name,p.product_id,p.product_name from category c
inner join sub_category s on c.category_id = s.category_id
inner join product p on s.sub_category_id = p.sub_category_id;
-- sequal-sql

select count(*)
from category c
inner join sub_category s
inner join product p
on c.category_id = s.category_id and s.sub_category_id = p.sub_category_id;

-- 카테고리별 상품명 조회

select c.category_id, c.category_name, p.product_id,p.product_name,s.sub_category_id from category c
inner join sub_category s on c.category_id = s.category_id
inner join product p on s.sub_category_id = p.sub_category_id;
-- 데이터 용량이 제한되어 있기 때문에 반복되는 데이터를 최대한 제거하려고 데이터를 분리한 것이다 (정규화 과정 <> 반정규화=역정규화도 있음 정규화의 반대)
-- 과도한 정규화도 시스템에 과부하를 줄 수 있다 그럴 때 반정규화(역정규화) 작업이 필요하다

-- 2018년 기준 상품별 주문건수 조회 - 주문날짜order_date, 상품명product_name, 총주문건수
select left(order_date,4),g.product_name,sum(order_qty) from (select h.order_date,p.product_name,order_qty as order_qty
from order_header h
inner join order_detail d
inner join product p
on h.order_id = d.order_id
and d.product_id = p.product_id and left(order_date,4) = '2018') g group by product_name, left(order_date,4);

select row_number() over(order by order_date) as number, order_date,product_name,order_qty from (select left(order_date,4) order_date,g.product_name,sum(order_qty) order_qty from (select h.order_date,p.product_name,order_qty as order_qty
from order_header h
inner join order_detail d
inner join product p
on h.order_id = d.order_id
and d.product_id = p.product_id and left(order_date,4) = '2018') g group by product_name, left(order_date,4)) g;

select row_number()  over(order by product_name) as number,left(order_date,4),product_name,sum(order_qty) from (select oh.order_date,p.product_name,od.order_qty
from order_detail od, order_header oh, product p
where od.order_id = oh.order_id
and od.product_id = p.product_id
and left(order_date,4) = '2018') g group by left(order_date,4),product_name;
-- 그룹핑 할 데이터가 유니크한지 확인을 해야한다 유니크하면 그룹핑이 되지 않는다

-- 행번호 생성 함수
-- 형식 : select row_number() over(order by 기준으로삼을컬럼명), 컬럼리스트,...
select row_number()  over(order by customer_id) as number, customer_name from customer;

-- 고객별 주문건수 출력 : 고객아이디, 고객명, 주문건수