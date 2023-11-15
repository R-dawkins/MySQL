use hrdb2019;
select database();
select * from information_schema.tables where table_schema = 'hrdb2019';
-- shoppy_products : 상품테이블
-- pid,name,image,price,discription,pdate
create table shoppy_products(
	pid int auto_increment primary key,
    name varchar(20) not null,
    price int,
    discription varchar(100),
    image varchar(300),
    pdate date
);
select * from shoppy_products;
-- 시분초까지 필요하다면 datetime, sysdate이용하여 insert
-- 날짜만 필요하다면 date타입, curdate() 이용
insert shoppy_products(image,name,price,discription,pdate) values(
"/images/7.webp",
"발렌티노 자켓",
209000,
"발렌티노 - 자켓",curdate());

select * from information_schema.tables where table_schema = 'hrdb2019';
-- 회원테이블 : shoppy_member
-- 컬럼리스트 : id, name, pass 암호화, phone, mdate(시분초 포함)
create table shoppy_member(
	id varchar(20) primary key,
    name varchar (30) not null,
    pass varchar(100) not null,
    phone varchar(20),
    mdate datetime
);
desc shoppy_member;
select * from shoppy_member;