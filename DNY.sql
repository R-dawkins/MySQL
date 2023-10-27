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
drop table dwitter;
create table dwitter(
	id varchar(20) primary key,
    password varchar(100) not null,
    name varchar(20) not null,
    date date,
    content varchar(200)
);
select * from information_schema.tables where table_name = 'dwitter';
select * from dwitter;
desc dwitter;

insert dwitter(id,password,name,date,content) values('1','1','1',curdate(),'1');
delete from dwitter;
select id,name,left(date,10) as date, content from dwitter;
/*
	news, news_reply 테이블 생성
    news : nid, url, title, content, rdate
*/
create table news(
	nid int auto_increment primary key,
    url varchar(200) not null,
    title varchar(200) not null,
    content varchar(500),
    rdate date
);

select * from news;
select * from information_schema.tables where table_name='news';
desc news;
delete from news;
select sysdate();
-- 참조하는 (pk)테이블을 접속할때만 fk테이블을 액세스한다면 자체 기본키(pk)가 필요 없을 수 있다.
-- 참조관계에서 fk를 가지는 테이블이 그 테이블만 따로 액세스가 필요할 때 자체 pk가 필요
-- 그러나 웬만해선 자체 pk를 넣어주는게 좋다
create table news_reply(
	rid int auto_increment primary key,
	nid int not null,
    redate datetime,
    content varchar(200) not null,
    constraint news_reply_nid_fk foreign key(nid) references news(nid) on delete cascade
);
select * from news_reply;
select * from information_schema.tables where table_name = 'news_reply';
desc news_reply;
-- 테이블만들고 뒤늦게 제약조건 추가 시 alter table add constraint
alter table news_reply
	add constraint news_reply_nid_fk foreign key(nid)
		references news(nid) on delete cascade;
select * from information_schema.table_constraints where table_name like 'news%';
delete from news_reply where rid = 9;
select * from news;

create table books(
	bid int auto_increment primary key,
    category varchar(30) not null,
    url varchar(200) not null,
    bname varchar(100),
    author varchar(30),
    translator varchar(30),
    publisher varchar(30),
    pday varchar(10),
    price varchar(10)
);
alter table books
	add constraint books_category_fk foreign key(category)
    references book_category(category) on delete cascade on update cascade;
alter table books
	modify translator varchar(30) default '없음';
alter table books alter column translator set default '없음';
alter table books
	modify bname varchar(100) not null;
alter table books
	modify price int;
create table book_category(
	category varchar(30) primary key,
    category_name varchar(30)
);
drop table books;
select * from books;
select * from book_category;
desc books;
desc book_category;
insert book_category(category,category_name) values('BestSeller','국내도서 종합 베스트');
insert book_category(category,category_name) values('RealTimeBestSeller','국내도서 실시간 베스트');
insert book_category(category,category_name) values('DayBestSeller','국내도서 일별 베스트');
insert book_category(category,category_name) values('MonthWeekBestSeller','국내도서 월간 베스트');
insert book_category(category,category_name) values('HotPriceBestSeller','국내도서 특가 베스트');
insert book_category(category,category_name) values('SteadySeller','국내도서 스테디 셀러');

select url,bname,author,translator,publisher,pday,price from books where category='BestSeller';
select category_name,url,bname,author,translator,publisher,pday,price from books b inner join book_category c on b.category = c.category where b.category='BestSeller';
select category_name,url,bname,author,translator,publisher,pday,price from books b inner join book_category c on b.category = c.category where b.category='DayBestSeller';
delete from books where price = 'test';

select category_name,url,bname,author,translator,publisher,pday,price from books b inner join book_category c on b.category = c.category;

create view books_view
as
select bid, c.category, url, bname, author, translator, publisher, pday, price, category_name from books b inner join book_category c on b.category = c.category;
select * from books_view;
select bid, category_name,url,bname,author,translator,publisher,pday,format(price,0) price from books b inner join book_category c on b.category = c.category where b.category='DayBestSeller';

create table yes_member(
	id varchar(20) primary key,
    name varchar(20) not null,
    password varchar(100) not null
);
select * from yes_member;

insert yes_member(id,name,password) values('1','2','333');
delete from yes_member;