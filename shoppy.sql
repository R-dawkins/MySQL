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
select count(pass) as cnt, pass from shoppy_member where id='1';
select count(pass), ANY_VALUE(pass) pass from shoppy_member where id='1';

-- 장바구니 테이블 : shoppy_cart
-- 어떤 회원이 어떤 상품(사이즈 포함)을 장바구니에 몇 개 추가했는지의 상태 정보 저장
-- 회원테이블 - 회원아이디(pk)
-- 상품테이블 - 상품아이디(pk)
-- 장바구니테이블 - 수량, 사이즈, 장바구니등록날짜
-- 보통 쇼핑몰은 테이블로 장바구니 사용
-- 쿠키 사용 장바구니도 가능하긴함
-- 컬럼 리스트 : cid(PK,장바구니id),qty(수량),size(사이즈),id(FK,varchar(20),FK는 데이터타입 같게 해야함,회원아이디),pid(FK,INT,상품아이디),cdate(장바구니등록날짜)
create table shoppy_cart(
	cid int auto_increment primary key,
    qty int not null,
    size varchar(2),
    id varchar(20) not null,
    pid int not null,
    cdate datetime
);
desc shoppy_cart;
insert shoppy_cart(qty,pid,size,id,cdate) values(1,1,1,1,sysdate());
select * from shoppy_cart;

select row_number() over(order by sc.cdate) as rno, sc.size, sc.cid ,sp.pid, sp.image, sp.name, sp.price, sc.qty, sp.price*sc.qty as lprice, cnt
	from shoppy_cart sc,shoppy_products sp,shoppy_member sm,(select count(*) as cnt from shoppy_cart where id = 'test') cart
	where sc.pid = sp.pid and sc.id = sm.id and sc.id = 'test' limit 0,3;
    -- 인라인뷰로 count(*)를 조회한 cart 테이블  추가

select * from (select row_number() over(order by sc.cdate) as rno, sc.size, sc.cid ,sp.pid, sp.image, sp.name, sp.price, sc.qty, sp.price*sc.qty as lprice, cnt
	from shoppy_cart sc,shoppy_products sp,shoppy_member sm,(select count(*) as cnt from shoppy_cart where id = 'test') cart
	where sc.pid = sp.pid and sc.id = sm.id and sc.id = 'test') cart_list;
-- rno를 사용하기 위해 쿼리 전체를 인라인 뷰로 만드는 방법인데 효율적이지 않아보임

    
    
update shoppy_cart set qty=2 where cid = 3;

create table shoppy_order(
	oid int auto_increment primary key,
    id varchar(20) not null,
    pid int not null,
    size varchar(10) not null,
    qty int not null,
	total_price int not null,
    odate datetime
);
-- 주문테이블 : 주문id(pk), 회원아이디, 상품아이디, 주문날짜, 옵션(사이즈), 수량, 총 주문금액 (결제금액)
-- oid,id,pid,size,qty,total_price,odate
-- 상품 아이디마다 map으로 insert하면 가능할듯
desc shoppy_order;
select * from shoppy_order;
delete from shoppy_order;

select row_number() over(order by sc.cdate) as rno, sc.size, sc.cid ,sp.pid, sp.image, sp.name, sp.price, sc.qty, sp.price*sc.qty as lprice from shoppy_order so,shoppy_products sp,shoppy_member sm where sc.pid = sp.pid and sc.id = sm.id and sc.id = 'test';