use sakila;

-- 1. Drop column picture from staff.
alter table staff
drop column picture;
select * from staff;

-- 2. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from customer;
select * from staff;
select * from customer where first_name like "TAMMY";

insert into staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update)
values (3, "Tammy", "Sanders", 79, "TAMMY.SANDERS@sakilacustomer.org", 2, 1, "Tammy", "", "2006-02-15 03:57:16");
  
	-- this seems to be an easier way but not working (try to explore later)
		insert into staff (first_name,last_name,address_id,email) 
		select first_name,last_name,address_id,email 
		from customer where first_name like "TAMMY";

-- 3. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
select * from film;
select * from rental;
select * from inventory;
select * from rental order by rental_id desc;


insert into rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
values (
16050, 
now(), 
(select inventory_id from inventory where inventory_id = 2), -- not possible to refer to the film_id and store because there is more than one inventory_id using both conditions
(select customer_id from customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER'), 
now()+5, 
(select staff_id from staff where first_name = 'Mike' and last_name = 'Hillyer'), 
"2006-02-15 21:30:53");

-- 4. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted.

-- Check if there are any non-active users
select * from customer where active = 0;

-- Create a table backup table as suggested
create table deleted_users(
customer_id int unique not null,
email text default null,
date int default null,
constraint primary key(customer_id) -- this is optional but a good practice
);

select * from deleted_users;

-- Insert the non active users in the table backup table
insert into deleted_users (customer_id, email)
select customer_id, email 
from customer 
where active = 0;