/*
	dwiiter 테이블 생성
    - id, name, date, content
*/
-- 현재 AutoCommit 값 확인
SELECT @@AUTOCOMMIT;

-- autocommit 설정
SET AUTOCOMMIT = 1;
 
-- autocommit 해제
-- edit의 preferences의 sql execution에서 workbench 실행 시 autocommit 옵션 체크박스를 해제해야한다 아니면 다음에 키면 똑같이 autocommit이 켜져있게된다.
SET AUTOCOMMIT = 0;

create table dwitter(
	id varchar(20) primary key,
    name varchar(20) not null,
    date date,
    content varchar(200)
);
select * from information_schema.tables where table_name = 'dwitter';
select * from dwitter;
desc dwitter;

select id,name,left(date,10) as date, content from dwitter;

