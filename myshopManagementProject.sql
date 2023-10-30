-- myshop2019 Management
use myshop2019;
select database();

select * from customer;

select row_number() over(order by customer_name) rownum,customer_id,customer_name,gender,phone,email,city,birth_date,register_date,point from customer_view limit 100;

create view customer_view
as
select row_number() over(order by customer_name) rownum,customer_id,customer_name,gender,phone,email,city,birth_date,register_date,point from customer limit 100;

select * from customer_view;

select * from employee;

create view employee_view
as
select row_number() over(order by employee_id) rownum,employee_id,employee_name,gender,phone,email,hire_date,retire_date from employee;

select * from employee_view;

select * from product p, sub_category s,category c where p.sub_category_id = s.sub_category_id and c.category_id = s.category_id;

create view product_view
as
select row_number() over(order by sub_category_id) rownum,p.product_id,p.product_name,s.sub_category_id,s.sub_category_name,c.category_id,c.category_name from product p, sub_category s,category c where p.sub_category_id = s.sub_category_id and c.category_id = s.category_id;

select row_number() over(order by sub_category_id) rownum,product_id,product_name,sub_category_id,sub_category_name,category_id,category_name from product_view;

select * from order_header limit 100;

create view order_header_view
as
select left(order_date,4) order_date,sum(sub_total) sub_total,sum(delivery_fee) delivery_fee,sum(total_due) total_due from order_header group by left(order_date,4)
union
select left(order_date,4) order_date,sum(sub_total) sub_total,sum(delivery_fee) delivery_fee,sum(total_due) total_due from order_header2017 group by left(order_date,4)
union
select left(order_date,4) order_date,sum(sub_total) sub_total,sum(delivery_fee) delivery_fee,sum(total_due) total_due from order_header2016 group by left(order_date,4);

select * from order_header_view;

select order_date from order_header_view;
select sub_total from order_header_view;
select order_date,format(sub_total,0),delivery_fee,total_due from order_header_view;
select * from information_schema.views where table_schema ='myshop2019';
select * from information_schema.tables where table_schema = 'myshop2019';
select * from order_header;
select row_number() over(order by customer_name) rownum,customer_id,customer_name,gender,phone,email,city,left(birth_date,10) birth_date,left(register_date,10) register_date,point from customer_view;

delete from customer where customer_id='gmhwang2';
select * from customer where customer_id='gmhwang2';
-- gmhwang2	 황고만	M	010-6673-6485	gominhwang2@daun.net	오산	1986-03-17	2017-09-18	17400
select * from order_header;
select * from order_detail;
select * from order_header h,order_detail d where h.order_id = d.order_id;
select left(order_date,4) order_date,d.order_id,product_id,order_qty,unit_price,discount,line_total from order_header h,order_detail d where h.order_id = d.order_id group by  left(order_date,4),order_id,product_id,order_qty,unit_price,discount,line_total;

select * from order_header h,order_detail d where h.order_id = d.order_id;
-- product,category,sub_category,order_header,order_detail,customer
create view myshop_view
as
select c.customer_id,customer_name,employee_name, e.gender employee_gender,c.gender customer_gender, e.phone employee_phone,c.phone customer_phone, e.email employee_email,c.email customer_email, city, birth_date, register_date, point, h.order_id, e.employee_id, order_date, sub_total, delivery_fee, total_due, drder_detail_id, order_qty, unit_price, discount, line_total, p.product_id, product_name, sc.sub_category_id, sub_category_name, ca.category_id, category_name from customer c,order_header h, order_detail d,product p, sub_category sc, category ca, employee e
where c.customer_id = h.customer_id and h.order_id = d.order_id and d.product_id = p.product_id and p.sub_category_id = sc.sub_category_id and sc.category_id = ca.category_id and h.employee_id = e.employee_id;
-- 판매관리 => 상품이 기준
-- 주문관리 => order_id기준
select * from order_header;
drop view myshop_view;
select * from myshop_view;
select distinct order_date,order_id,customer_name,employee_name,sub_total,delivery_fee,total_due from myshop_view order by order_date;
select row_number() over(order by product_name) rownum,product_name, format(sum(order_qty),0) order_qty,format(unit_price,0) unit_price,format(sum(discount),0) discount,format(sum(line_total),0) line_total,format(sum(sub_total),0) sub_total,format(sum(delivery_fee),0) delivery_fee,format(sum(total_due),0) total_due from myshop_view group by product_name,unit_price;
-- customer_id,customer_name, gender, phone, email, city, birth_date, register_date, point, order_id, employee_id, order_date, sub_total, delivery_fee, total_due, drder_detail_id, order_qty, unit_price, discount, line_total, product_id, product_name, sub_category_id, sub_category_name, category_id, category_name
select * from employee;

create table employee_copy
as
select * from employee;
select * from employee_copy;
select * from employee_copy;
insert employee_copy(employee_id,employee_name,gender,phone,email,hire_date,retire_date) values(null,'홍길순','F','010-1234-6794','hong@d-friend.co.kr',curdate(),null);
desc employee_copy;
delete from employee_copy where employee_id='D0008';
create table employee_idnumber(
	employee_id int auto_increment primary key
);
show triggers;
show procedure status;
drop table employee_idnumber;
delimiter $$ 
    create trigger tg_employee_copy_insert
    before insert on employee_copy
    for each row
    begin
		insert into employee_idnumber values (null);
        set new.employee_id = concat('D', lpad(last_insert_id(),4,'0'));
	end$$
delimiter ;
select * from information_schema.views where table_schema = 'myshop2019';
select * from myshop_view;

create view cus_view
as
select customer_name,format(sum(sub_total),0) cus_sub_total,format(sum(delivery_fee),0) cus_delivery_fee,format(sum(total_due),0) cus_total_due from myshop_view group by customer_name;

create view age_view
as
select left(birth_date,4) age,format(sum(sub_total),0) age_sub_total,format(sum(delivery_fee),0) age_delivery_fee,format(sum(total_due),0) age_total_due from myshop_view group by age;

create view cat_view
as
select category_name,format(sum(sub_total),0) sub_total,format(sum(delivery_fee),0) delivery_fee,format(sum(total_due),0) total_due from myshop_view group by category_name;
create view pro_view
as
select product_name,format(sum(sub_total),0) sub_total,format(sum(delivery_fee),0) delivery_fee,format(sum(total_due),0) total_due  from myshop_view group by product_name;

select * from cus_view join age_view;
select * from cat_view;
select * from pro_view;
select * from employee_copy;
select product_name,sub_total,delivery_fee,total_due from pro_view;

update employee_copy set employee_name = '홍길동' where employee_id = 'D0009';
commit;
