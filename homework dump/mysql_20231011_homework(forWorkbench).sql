/* 데이터 사용 : USE 데이터베이스명;   */
USE hrdb2019;
SELECT DATABASE();

/*
	테이블의 구조 확인 : DESC
    형식 : DESC 테이블명;
*/
-- employee 테이블 구조 확인
desc employee;
-- department 테이블 구조 확인
desc department;
-- employee 테이블에 있는 사원id, 사원명, 이메일를 조회
select emp_id, emp_name, email from employee;
-- employee 테이블에 있는 모든 컬럼을 조회
select * from employee;
-- department 테이블의 모든 컬럼을 조회
select * from department;
-- employee 테이블 emp_id 컬럼명을 사원번호 로 변경 후 조회
select emp_id as 사원번호 from employee;
-- employee 테이블의 모든 사원의 연봉, 보너스(연봉10%) 조회
select salary, salary*0.1 as bonus from employee;
-- 현재 날짜를 가져오는 함수에 별칭 사용
select curdate() as today;
-- 사원id가 S0007에 해당하는 사원정보를 모두 조회
select * from employee where emp_id = 'S0007';
-- 사원명이 일지매인 사원의 모든 정보를 조회
select * from employee where emp_name = '일지매';
-- 홍길동 사원의 사원아이디, 성별, 폰번호, 이메일, 연봉 조회
select emp_id, gender, phone, email, salary from employee where emp_name = '홍길동';
-- 총무부에 속한 모든 사원의 정보를 조회
select * from employee where dept_id = 'GEN';
-- 모든 남자사원의 사원명, 입사일, 폰번호, 연봉 조회
select emp_name, hire_date, phone, salary from employee where gender = 'M';
-- NULL은 미지수의 개념으로 이해!! 
-- eng_name이 현재 정의되지 않은 사원들을 모두 조회
select * from employee where eng_name is null;
-- eng_name이 null이 아닌 사원들을 모두 조회
select * from employee where eng_name is not null;
/*
	NULL 값을 다른값으로 대체하는 함수 : ifnull()
    형식 : ifnull(null포함 컬럼명, 변경하는값)
*/    
-- eng_name이 null값을 '홍길동'으로 대체한 후 조회
select ifnull(eng_name, '홍길동') from employee;
-- retire_date가 null인 경우 현재기준 날짜로 대체하여 조회
select ifnull(retire_date, curdate()) from employee;
-- 사원테이블에 존재하는 모든 부서번호를 중복을 배제하고 조회
select distinct dept_id from department;
-- 사원id 기준으로 오름차순 정렬 후 모든 데이터 출력
select * from employee order by emp_id;
-- 입사일이 가장 빠른 순서대로 사원들을 모두 조회
select * from employee order by hire_date;
-- 연봉이 가장 높은 순으로 사원들을 모두 조회
select * from employee order by salary DESC;
-- eng_name이 null인 사원들 중 입사일이 가장 빠른순서대로 조회
select * from employee where eng_name is null order by hire_date;
-- 정보시스템 부서 사원 중 입사일이 가장 빠르고, 급여를 많이 받는
-- 순서로 정렬하여 조회
select * from department;
select * from employee where dept_id = 'SYS' order by hire_date,salary DESC;








