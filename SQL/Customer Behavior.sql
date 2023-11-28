
-- Average order quantity a customer orders?
with order_quantity_cte as (
select order_id, sum(quantity) pizza_order_count,
		case when sum(quantity) > 2 then '2+'
		else '1-2' end order_quantity
from order_details
group by order_id
order by order_id
)
select order_quantity, count(*) total_count
from order_quantity_cte
group by order_quantity

-- Average price a customer spends on an order (average order value).

with order_value as (
select order_details.order_id, sum(quantity * price) total_price
from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id
group by order_details.order_id
order by order_details.order_id 
)
select round(avg(total_price),2) avg_price
from order_value

-- Which pizza size is most ordered?

select size, sum(quantity) order_count
from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id
group by size
order by order_count desc;

-- Does price of pizza size affect purchase behavior?

select price, count(distinct order_id)
from order_details 
join pizzas on order_details.pizza_id = pizzas.pizza_id
group by price



