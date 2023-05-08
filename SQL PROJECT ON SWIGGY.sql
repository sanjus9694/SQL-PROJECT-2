## Which delivery partners have the highest number of orders?
select count(o.partner_id) AS "Number of orders", d.partner_name from delivery_partner d inner join orders o
on d.partner_id= o.partner_id
group by d.partner_name
order by count(o.partner_id) desc;

## How many unique types of food are available in the food table?
select distinct(type) from food;

## What are the menu items and prices for a specific restaurant?
select m.price, f.f_name from menu m inner join restaurant r
on m.r_id= r.r_id
inner join food f
on m.f_id= f.f_id;

## Retrieve the details of orders with delivery rating greater than 4 and restaurant rating greater than 3.
select order_id from orders
where delivery_rating >4 and restaurant_rating>3;

## Calculate the total amount earned from all orders within a specific date range.
select sum(amount) from orders
where date between "10-5-2022" AND "11-6-2022";

## Retrieve the order details for a specific order ID.
SELECT r.r_name, o.date, sum(amount) FROM ORDERS O INNER JOIN ORDER_DETAILS D
ON O.ORDER_ID= D.ORDER_ID
INNER JOIN restaurant r
on o.r_id= r.r_id
group by r.r_name, o.date;

## Retrieve the names and emails of users who have not placed any orders.
select name, email from user where user_id not in(select user_id from orders);

## Retrieve the food items that are not included in any menu.
select f_id, f_name from food where f_id not in (select f_id from menu);

## Retrieve the partner names and their corresponding restaurant names for orders with a specific delivery time.
select r.r_name, p.partner_name, o.order_id from orders o inner join delivery_partner p
on o.partner_id = p.partner_id
inner join restaurant r
on o.r_id = r.r_id
where delivery_time in(60,33);

## Find the average delivery rating for each partner.
select d.partner_name, o.partner_id, avg(delivery_rating) AS "Average delivery rating" from orders o  inner join delivery_partner d
on o.partner_id = d.partner_id
group by d.partner_name, o.partner_id;

## Retrieve the order details, including food names and prices, for a specific user ID.
select f_name, m.price from food o inner join menu m
on o.f_id= m.f_id
inner join order_details d
on o.f_id= d.f_id
inner join orders
on d.order_id= orders.order_id
where orders.user_id in (1,2,3);

## Find the total number of orders and the total amount earned for each restaurant.
select count(o.r_id), sum(amount), r.r_name from orders o inner join restaurant r
on o.r_id= r.r_id
group by r.r_name;

## Retrieve the order details, including food names and user names, for a specific restaurant ID.
select f.f_name, u.name from restaurant r inner join menu m
on r.r_id = m.r_id
inner join orders o
on r.r_id= o.r_id
inner join user u
on u.user_id = o.user_id
inner join food f
on f.f_id= m.f_id
where r.r_id in (1);

## Find the most frequently ordered food item.
select count(d.order_id) AS "Number of orders", f.f_name from order_details d inner join food f
on d.f_id= f.f_id
group by f.f_name
order by count(d.order_id) desc;

## Retrieve the orders that were delivered by a specific delivery partner and have a delivery rating greater than 3.
select d.partner_name, o.order_id from delivery_partner d inner join orders o
on d.partner_id = o.partner_id
where delivery_rating>3;

## Retrieve the partner names and their corresponding restaurant names for orders with a specific restaurant rating.
select d.partner_name, r.r_name from delivery_partner d inner join orders o
on d.partner_id= o.partner_id
inner join user u
on u.user_id = o.user_id
inner join restaurant r
on r.r_id= o.r_id
where restaurant_rating>2;

## Find the total amount earned from orders placed by a specific user.
select sum(amount), o.user_id, u.name from orders o inner join user u
on o.user_id = u.user_id
group by o.user_id, u.name;

## Retrieve the food items that have been ordered at least once and their corresponding order counts.
select count(d.f_id), f.f_name from order_Details d inner join food f
on d.f_id = f. f_id
group by f.f_name
order by count(d.f_id);

##the top 5 restaurants with the highest average restaurant ratings, along with their respective cuisine types
select round(avg(o.restaurant_rating),2) AS "Highest average ratings", r.cuisine AS "Cuisine type", r.r_name AS "restaurant name" from orders o inner join restaurant r
on o.r_id = r.r_id
group by r.cuisine, r.cuisine, r.r_name
order by round(avg(o.restaurant_rating),2) desc;

## Retrieve the partner_id, partner_name, and the total count of orders made by each delivery partner:
SELECT COUNT(o.order_id) OVER (PARTITION BY d.partner_id) AS order_count, d.partner_id, d.partner_name FROM delivery_partner d INNER JOIN orders o ON d.partner_id = o.partner_id;

## Find the top 3 restaurants with the highest total order amount:
select max(o.amount) AS "MAX AMT", rank() over(order by o.amount DESC) AS "RANK", r.r_name AS "RESTAURANT NAME" from orders o inner join restaurant r
on o.r_id = r.r_id
group  by o.r_id, r.r_name, o.amount
limit 3;





















