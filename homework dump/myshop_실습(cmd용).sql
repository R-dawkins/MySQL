/*
	실습 데이터베이스 연결 : myshop2019
	실습 내용 - 기본적인 데이터 조회 
*/
-- Q01) customer 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
-- Q02) employee 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
-- Q03) product 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
-- Q04) order_header 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
-- Q05) order_detail 테이블 모든 행과 열을 조회하고 어떤 열들이 있는지, 데이터 형식은 어떻게 되는지 살펴보세요.
-- Q06) 모든 고객의 아이디, 이름, 지역, 성별, 이메일, 전화번호를 조회하세요.
-- Q07) 모든 직원의 이름, 사원번호, 성별, 입사일, 전화번호를 조회하세요.
select employee_name, employee_id, gender, hire_date, phone from employee;
-- Q08) 이름이 '홍길동'인 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name,customer_id,gender,city,phone,point from customer where customer_name = '홍길동';
-- Q09) 여자 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name,customer_id,gender,city,phone,point from customer where gender = 'F';
-- Q10) '울산' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name,customer_id,gender,city,phone,point from customer where city = '울산';
-- Q11) 포인트가 500,000 이상인 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name,customer_id,gender,city,phone,point from customer where point >= 500000;
-- Q12) 이름에 공백이 들어간 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name,customer_id,gender,city,phone,point from customer where customer_name like '% %';
-- Q13) 전화번호가 010으로 시작하지 않는 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name,customer_id,gender,city,phone,point from customer where phone not like '010%';
-- Q14) 포인트가 500,000 이상 '서울' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name,customer_id,gender,city,phone,point from customer where city = '서울' and point >= 500000;
-- Q15) 포인트가 500,000 이상인 '서울' 이외 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_name,customer_id,gender,city,phone,point from customer where city != '서울' and point >= 500000;
-- Q16) 포인트가 400,000 이상인 '서울' 지역 남자 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_id,customer_name,gender,city,phone,point from customer where city = '서울' and point >= 400000 and gender ='M';
-- Q17) '강릉' 또는 '원주' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_id,customer_name,gender,city,phone,point from customer where city in('강릉','원주');
-- Q18) '서울' 또는 '부산' 또는 '제주' 또는 '인천' 지역 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_id,customer_name,gender,city,phone,point from customer where city in('서울','부산','제주','인천');
-- Q19) 포인트가 400,000 이상, 500,000 이하인 고객의 이름, 아이디, 성별, 지역, 전화번호, 포인트를 조회하세요.
select customer_id,customer_name,gender,city,phone,point from customer where point between 400000 and 500000;
-- Q20) 1990년에 출생한 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
select customer_id,customer_name,gender,city,phone,birth_date,point from customer where left(birth_date,4) = '1990';
-- Q21) 1990년에 출생한 여자 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
select customer_id,customer_name,gender,city,phone,birth_date,point from customer where left(birth_date,4) = '1990' and gender ='F';
-- Q22) 1990년에 출생한 '대구' 또는 '경주' 지역 남자 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
select customer_id,customer_name,gender,city,phone,birth_date,point from customer where left(birth_date,4) = '1990' and city in('대구','경주') and gender = 'M';
-- Q23) 1990년에 출생한 남자 고객의 이름, 아이디, 성별, 지역, 전화번호, 생일, 포인트를 조회하세요.
select customer_id,customer_name,gender,city,phone,birth_date,point from customer where left(birth_date,4) = '1990' and gender ='M';
--      단, 홍길동(gildong) 형태로 이름과 아이디를 묶어서 조회하세요.
select concat(customer_name,'(',customer_id,')'),gender,city,phone,birth_date,point from customer where left(birth_date,4) = '1990' and gender ='M';
-- Q24) 근무중인 직원의 이름, 사원번호, 성별, 전화번호, 입사일를 조회하세요.
select employee_name,employee_id,gender,phone,hire_date from employee where retire_date is null;
-- Q25) 근무중인 남자 직원의 이름, 사원번호, 성별, 전화번호, 입사일를 조회하세요.
select employee_name,employee_id,gender,phone,hire_date,retire_date from employee where retire_date is null and gender = 'M';
-- Q26) 퇴사한 직원의 이름, 사원번호, 성별, 전화번호, 입사일, 퇴사일를 조회하세요.
select employee_name,employee_id,gender,phone,hire_date from employee where retire_date is not null;
-- Q28) 2019-01-01 ~ 2019-01-07 기간 주문의 주문번호, 고객아이디, 사원번호, 주문일시, 소계, 배송비, 전체금액을 조회하세요.
--      단, 고객아이디를 기준으로 오름차순 정렬해서 조회하세요.
    select order_id,customer_id,employee_id,order_date,sub_total,delivery_fee,total_due from order_header where order_date between cast(20190101 as date) and cast(20190107 as date) order by customer_id;
-- Q29) 2019-01-01 ~ 2019-01-07 기간 주문의 주문번호, 고객아이디, 사원번호, 주문일시, 소계, 배송비, 전체금액을 조회하세요.
--      단, 전체금액을 기준으로 내림차순 정렬해서 조회하세요.
	select order_id,customer_id,employee_id,order_date,sub_total,delivery_fee,total_due from order_header where order_date between cast(20190101 as date) and cast(20190107 as date) order by total_due desc;
-- Q30) 2019-01-01 ~ 2019-01-07 기간 주문의 주문번호, 고객아이디, 사원번호, 주문일시, 소계, 배송비, 전체금액을 조회하세요.
--      단, 사원번호를 기준으로 오름차순, 같은 사원번호는 주문일시를 기준으로 내림차순 정렬해서 조회하세요.
	select order_id,customer_id,employee_id,order_date,sub_total,delivery_fee,total_due from order_header where order_date between cast(20190101 as date) and cast(20190107 as date) order by employee_id,order_date desc;
/**
	그룹함수
**/
/** customer 테이블 사용 **/
-- Q01) 고객의 포인트 합을 조회하세요.
select sum(point) from customer;
-- Q02) '서울' 지역 고객의 포인트 합을 조회하세요.
select sum(point) from customer where city ='서울';
-- Q03) '서울' 지역 고객의 수를 조회하세요.
select count(*) from customer where city = '서울';
-- Q04) '서울' 지역 고객의 포인트 합과 평균을 조회하세요.
select sum(point),avg(point) from customer where city ='서울';
-- Q05) '서울' 지역 고객의 포인트 합, 평균, 최댓값, 최솟값을 조회하세요.
select sum(point),avg(point),max(point),min(point) from customer where city ='서울';
-- Q06) 남녀별 고객의 수를 조회하세요.
select gender ,count(*) from customer group by gender;
-- Q07) 지역별 고객의 수를 조회하세요.
--      단, 지역 이름을 기준으로 오름차순 정렬해서 조회하세요.
select city, count(*) from customer group by city order by city;
 
-- Q08) 지역별 고객의 수를 조회하세요.
--      단, 고객의 수가 10명 이상인 행만 지역 이름을 기준으로 오름차순 정렬해서 조회하세요.
select city, count(*) from customer group by city having count(*) > 10 order by city;
    
-- Q09) 남녀별 포인트 합을 조회하세요.
select gender, sum(point) from customer group by gender;    
-- Q10) 지역별 포인트 합을 조회하세요.
--      단, 지역 이름을 기준으로 오름차순 정렬해서 조회하세요.
    select city, sum(point) from customer group by city order by city;
-- Q11) 지역별 포인트 합을 조회하세요.
--      단, 포인트 합이 1,000,000 이상인 행만 포인트 합을 기준으로 내림차순 정렬해서 조회하세요.
	select city, sum(point) from customer group by city having sum(point) >= 1000000 order by sum(point)desc;
      
-- Q12) 지역별 포인트 합을 조회하세요.
--      단, 포인트 합을 기준으로 내림차순 정렬해서 조회하세요.
   select city, sum(point) from customer group by city order by sum(potin) desc;

-- Q13) 지역별 고객의 수, 포인트 합을 조회하세요.
--      단, 지역 이름을 기준으로 오름차순 정렬해서 조회하세요.
	select city, count(*), sum(point) from customer group by city order by city;

-- Q14) 지역별 포인트 합, 포인트 평균을 조회하세요.
--      단, 포인트가 NULL이 아닌 고객을 대상으로 하며, 지역 이름을 기준으로 오름차순 정렬해서 조회하세요.
	select city, sum(point), avg(point) from customer where point is not null group by city order by city;
-- Q15) '서울', '부산', '대구' 지역 고객의 지역별, 남녀별 포인트 합과 평균을 조회하세요.
--      단, 지역 이름을 기준으로 오름차순, 같은 지역은 성별을 기준으로 오름차순 정렬해서 조회하세요.
	select city, gender, sum(point), avg(point) from customer where city in('서울','부산','대구') group by city,gender order by city,gender;

/** order_header 테이블 사용 **/
    
-- Q16) 2019년 1월 주문에 대하여 고객아이디별 전체금액 합을 조회하세요.
select customer_id, sum(total_due) from order_header where order_date like '2019-01%' group by customer_id;

-- Q17) 주문연도별 전체금액 합계를 조회하세요.
select left(order_date,4) as year, sum(total_due) from order_header group by year;
-- Q18) 2019.01 ~ 2019.06 기간 주문에 대하여 주문연도별, 주문월별 전체금액 합을 조회하세요.
select left(order_date,4) as year, substring(order_date,6,2) as mm,sum(total_due) from order_header where substring(order_date,1,7) between '2019-01' and '2019-06' group by year,mm;
-- ver 1
select left(order_date,4) as year, sum(total_due) from order_header where substring(order_date,1,7) between '2019-01' and '2019-06' group by year
union
select substring(order_date,6,2) as mm,sum(total_due) from order_header where substring(order_date,1,7) between '2019-01' and '2019-06' group by mm;
-- ver union
-- Q19) 2019.01 ~ 2019.06 기간 주문에 대하여 주문연도별, 주문월별 전체금액 합과 평균을 조회하세요.
select left(order_date,4) as year, substring(order_date,6,2) as mm,sum(total_due),avg(total_due) from order_header where substring(order_date,1,7) between '2019-01' and '2019-06' group by year,mm;
-- ver 1
select left(order_date,4) as year, sum(total_due),avg(total_due) from order_header where substring(order_date,1,7) between '2019-01' and '2019-06' group by year
union
select substring(order_date,6,2) as mm,sum(total_due),avg(total_due) from order_header where substring(order_date,1,7) between '2019-01' and '2019-06' group by mm;
-- ver union
-- Q20) 주문연도별, 주문월별 전체금액 합과 평균을 조회하고, rollup 함수를 이용하여 소계와 총계를 출력해주세요.
select left(order_date,4) as year, substring(order_date,6,2) as mm,sum(total_due),avg(total_due) from order_header where substring(order_date,1,7) between '2019-01' and '2019-06' group by year,mm with rollup;
-- ver 1
select left(order_date,4) as year, sum(total_due),avg(total_due) from order_header where substring(order_date,1,7) between '2019-01' and '2019-06' group by year with rollup
union
select substring(order_date,6,2) as mm,sum(total_due),avg(total_due) from order_header where substring(order_date,1,7) between '2019-01' and '2019-06' group by mm with rollup;
-- ver union