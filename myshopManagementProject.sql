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
