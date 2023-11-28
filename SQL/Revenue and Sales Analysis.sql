-- Total Revenue in Year 2015

select sum(price * quantity) total_sale
from order_details join pizzas 
on order_details.pizza_id = pizzas.pizza_id

-- Total Orders in Year 2015

select count(distinct order_id) unique_orders
from orders;

-- Total Quantity of pizzas sold in Year 2015

select sum(quantity) total_pizzas_sold
from order_details;

--Best and worst selling pizza in Year 2015

with pizza_quantity as (
select 	order_details.pizza_id as pizza_id,
		sum(quantity) total_quantity_sold
from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id
group by order_details.pizza_id
order by total_quantity_sold desc
)
select 
	max(case when total_quantity_sold = (select max(total_quantity_sold) from pizza_quantity) then pizza_id end) as best_selling_pizza,
	max(case when total_quantity_sold = (select min(total_quantity_sold) from pizza_quantity) then pizza_id end) as worst_selling_pizza
from  pizza_quantity;

-- which pizzas should be prioritize for promotion? (pizzas with highest revenue and unit solds)

with pizza_sales as (
select order_details.pizza_id, sum(price * quantity) total_revenue, sum(quantity) unit_sold
from order_details 
join pizzas on order_details.pizza_id = pizzas.pizza_id
group by order_details.pizza_id
order by total_revenue desc
)
select pizza_id, total_revenue, unit_sold
from pizza_sales
limit 5;

-- monthly trend : categories by unit sold.

select extract(month from date) month_num, category, sum(quantity) unit_sold
from orders
join order_details on orders.order_id = order_details.order_id
join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by month_num, category;


-- Is purchase behavior and sales influenced by pizza price?

select price, count(distinct order_id) order_count, sum(price * quantity) total_revenue
from order_details
join pizzas on pizzas.pizza_id = order_details.pizza_id
group by price
order by price


-- Average price per each category vs quantity sold relation?
select category, avg(price) avg_price, sum(quantity) unit_sold
from order_details 
join pizzas on pizzas.pizza_id = order_details.pizza_id
join pizza_types on pizza_types.pizza_type_id = pizzas.pizza_type_id
group by category
order by unit_sold, avg_price desc;











