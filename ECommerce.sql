create database Ecommerce ;
use Ecommerce ;

--Customers
create table Customers (
	customer_id  int primary key identity(1,1),
	[name] varchar(20) not null,
	email varchar(20) unique not null,
	[password] varchar(20) not null
	)
select * from Customers ;

--Products
create table Products (
	product_id int primary key identity(1,1),
	[name] varchar(20) not null, 
	price decimal(10,2) not null,
	[description] varchar(20), 
	stockQuantity int
	)
select * from Products ;

--Cart
create table Cart (
	cart_id int primary key identity(1,1) ,
	customer_id int foreign key references Customers(customer_id) ,
	product_id int foreign key references Products(product_id) ,
	quantity int
	)
select * from Cart ;

--Orders
create table Orders (
    order_id int primary key identity(1,1),
    customer_id int foreign key references Customers(customer_id) ,
    order_date date,
    total_price decimal(10, 2) NOT NULL,
    shipping_address varchar(60) NOT NULL,
	)
select * from Orders ;

--Order_items
create table Order_items(
	order_item_id int primary key identity(1,1) ,
	order_id int foreign key references Orders(order_id) ,
	product_id int foreign key references Products(product_id) ,
	quantity int
	)
select * from Order_items ;

--Products table
INSERT INTO Products ([name], [description], price, stockQuantity)  VALUES 
    ('Laptop', 'High-performance laptop', 1500.00, 1),
    ('Smartphone', 'Latest smartphone', 800.00, 10),
    ('Tablet', 'Portable tablet', 600.00, 15),
    ('Headphones', 'Noise-canceling', 300.00, 20),
    ('TV', '4K Smart TV', 150.00, 30),
    ('Coffee Maker', 'Automatic coffee maker', 900.00, 5),
    ('Refrigerator', 'Energy-efficient', 700.00, 10),
    ('Microwave Oven', 'Countertop microwave', 80.00, 15),
    ('Blender', 'High-speed blender', 70.00, 20),
    ('Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

alter table Products 
alter column [description] varchar(50) ;

select * from Products ;

--Customers table
INSERT INTO Customers (firstName, lastName, email, address) VALUES
    ('John', 'Doe', 'johndoe@example.com', '123 Main St, City'),
    ('Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town'),
    ('Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
    ('Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'),
    ('David', 'Lee', 'david@example.com', '234 Cedar St, District'),
    ('Laura', 'Hall', 'laura@example.com', '567 Birch St, County'),
    ('Michael', 'Davis', 'michael@example.com', '890 Maple St, State'),
    ('Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country'),
    ('William', 'Taylor', 'william@example.com', '432 Spruce St, Province'),
    ('Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory');

select * from Customers ;

alter table Customers
drop column [name] ;

alter table Customers
add firstName varchar(20), lastName varchar(20);

alter table Customers
drop column [password] ;

alter table Customers
add [address] varchar(60) ;

alter table Customers
alter column email varchar(60) ;


--Orders table
INSERT INTO Orders (customer_id, order_date, total_price) VALUES
    (1, '2023-01-05', 1200.00),
    (2, '2023-02-10', 900.00),
    (3, '2023-03-15', 300.00),
    (4, '2023-04-20', 150.00),
    (5, '2023-05-25', 1800.00),
    (6, '2023-06-30', 400.00),
    (7, '2023-07-05', 700.00),
    (8, '2023-08-10', 160.00),
    (9, '2023-09-15', 140.00),
    (10, '2023-10-20', 1400.00);

alter table Orders
alter column shipping_address varchar(60) null ;

select * from Orders ;

--OrderItem table
INSERT INTO Order_items (order_id, product_id, quantity, item_amount)
VALUES
    (1, 1, 2, 1600.00),
    (1, 3, 1, 300.00),
    (2, 2, 3, 1800.00),
    (3, 5, 2, 1800.00),
    (4, 4, 4, 600.00),
    (4, 6, 1, 50.00),
    (5, 1, 1, 800.00),
    (5, 2, 2, 1200.00),
    (6, 10, 2, 240.00),
    (6, 9, 3, 210.00);

select * from Order_items ;

alter table Order_items
add item_amount decimal(10,2);

--Cart table
INSERT INTO Cart (customer_id, product_id, quantity) VALUES
    (1, 1, 2),
    (1, 3, 1),
    (2, 2, 3),
    (3, 4, 4),
    (3, 5, 2),
    (4, 6, 1),
    (5, 1, 1),
    (6, 10, 2),
    (6, 9, 3),
    (7, 7, 2);

select * from Cart ;

--1. Update refrigerator product price to 800. 

Update Products
set price=800.00 where name='Refrigerator' ;

select * from Products ;

--2. Remove all cart items for a specific customer. 

delete from Cart where customer_id=5 ;

select * from Cart ;

--3. Retrieve Products Priced Below $100. 

select name from Products where price<100 ;

--4. Find Products with Stock Quantity Greater Than 5.

select name from Products where stockQuantity>5 ;

--5. Retrieve Orders with Total Amount Between $500 and $1000. 

select * from Orders where total_price between 500 and 1000 ;

--6. Find Products which name end with letter ‘r’. 

select * from Products where name like '%r' ;

--7. Retrieve Cart Items for Customer 5. 

select * from Cart where customer_id=5 ;

--8. Find Customers Who Placed Orders in 2023. 

select * from Customers c
left join Orders o on c.customer_id=o.customer_id 
where order_date between '2023-01-01' and '2023-12-31' ;

--9. Determine the Minimum Stock Quantity for Each Product Category. 

select * from Products
select p.product_id, p.name, min(p.stockQuantity) as min_stock_quantity
from Products p
group by p.product_id, p.name;

--10. Calculate the Total Amount Spent by Each Customer. 

select * from Orders

select c.customer_id, c.firstName, c.lastName, sum(o.total_price) as Total_Amount from Customers c 
left join Orders o on c.customer_id=o.customer_id 
group by c.customer_id, c.firstName, c.lastName;



--11. Find the Average Order Amount for Each Customer. 

select c.customer_id, c.firstName, c.lastName, avg(o.total_price) as Average_Amount from Customers c
left join Orders o on c.customer_id = o.customer_id
group by c.customer_id, c.firstName, c.lastName;

--12. Count the Number of Orders Placed by Each Customer. 

select c.firstName, c.lastName, count(o.order_id) as order_count
from Customers c
join Orders o on c.customer_id = o.customer_id
group by c.firstName, c.lastName;

--13. Find the Maximum Order Amount for Each Customer. 

select c.firstName, c.lastName, max(o.total_price) as Max_Order_Amount
from Customers c
join Orders o on c.customer_id = o.customer_id
group by c.firstName, c.lastName;

--14. Get Customers Who Placed Orders Totaling Over $1000. 

select c.firstName, c.lastName, sum(o.total_price) as total_spent
from Customers c
join Orders o on c.customer_id = o.customer_id
group by c.firstName, c.lastName
having sum(o.total_price) > 1000;

--15. Subquery to Find Products Not in the Cart.

select p.product_id, p.name
from Products p
where p.product_id not in (
    select distinct c.product_id
    from Cart c
);

--16. Subquery to Find Customers Who Haven't Placed Orders. 

select c.customer_id, c.firstName, c.lastName
from Customers c
where c.customer_id not in (
    select o.customer_id
    from Orders o
);

--17. Subquery to Calculate the Percentage of Total Revenue for a Product. 


--18. Subquery to Find Products with Low Stock. 
select p.product_id, p.name, p.stockQuantity
from Products p
where p.stockQuantity <= 
    (select min(stockQuantity) from Products where stockQuantity <= 5);

--19. Subquery to Find Customers Who Placed High-Value Orders. 

select firstName, lastName
from Customers c
where exists (
    select 1
    from Orders o
    where o.customer_id = c.customer_id
      and o.total_price > 1000
);
