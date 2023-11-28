-- What days and times do we tend to be busiest?
select  extract(dow from date) day_num,
		case when extract(hour from time)  between 8 and 12 then 'Morning'
			 when extract(hour from time)  between 12 and 16 then 'Afternoon'
			 when extract(hour from time)  between 16 and 20 then 'Evening'
			 when extract(hour from time)  between 20 and 24 then 'Night'
			 else 'unknown' end as timing,
		count(distinct order_id) order_count
from orders
group by day_num, timing
order by order_count desc;

-- Which hour is the most busiest?

select extract(hour from time) as hours,
		count(distinct order_id) order_count
from orders
group by hours
order by order_count desc;

-- Which month is the most and least busiest?

(select 'Least Busiest Month' ,
 		extract(month from date) month_num,
		count(distinct order_id) order_count
from orders
group by month_num
order by order_count asc
limit 1)

union all

(select 'Most Busiest Month' ,
 		extract(month from date) month_num,
		count(distinct order_id) order_count
from orders
group by month_num
order by order_count desc
limit 1);



-- How many pizzas are we making during peak periods?

-- Peak hours

WITH peak_hour AS (
    SELECT
        date,
        EXTRACT(HOUR FROM time) AS hour,
        SUM(quantity) AS quantity,
        row_number() OVER (partition by date ORDER BY COUNT(DISTINCT orders.order_id) DESC) AS row_num
    FROM
        orders
		join order_details on orders.order_id = order_details.order_id 
    GROUP BY
        date, EXTRACT(HOUR FROM time)
)
SELECT
    max(quantity) max_pizzas_peak_hour,
	round(avg(quantity)) avg_pizzas_peak_hour
FROM
    peak_hour
WHERE
    row_num = 1;
	
-- Peak Month
with peak_month_orders as (
select extract(month from date) month_num,
		extract(day from date) day_num,
		sum(quantity) quantity,
		row_number()over(partition by extract(month from date) order by count(distinct orders.order_id) desc) rn
from orders
join order_details on orders.order_id = order_details.order_id
group by month_num, day_num
)

select  
		max(quantity) max_pizzas_peak_month,
		round(avg(quantity)) avg_pizzas_peak_month
from peak_month_orders
where rn = 1;


-- How well are we utilizing our seating capacity? (15 Tables and 60 seats)

/*  Assumptions: 
	party size is depedent on quantity and pizza size (rounding down)
	for size S: 1 person , M: 1.5 person, L:2 person, XL: 2.5 person, XXL: 3 person
	1 person dine for 1 hour 
	Restaurant currently have 15 tables, seating 4 people each. 
	Groups ddon't share the table i.e group of 5 will take up 2 tables.
	*/
	
with party_size as 
(select orders.order_id, date,time, 
				 floor(sum(case when size = 'S' then quantity * 1
					  when size = 'M' then quantity * 1.5
					  when size = 'L' then quantity * 2
					  when size = 'XL' then quantity * 2.5
					  when size = 'XXL' then quantity * 3
					  end)) party_size
from orders 
join order_details on orders.order_id = order_details.order_id
join pizzas on pizzas.pizza_id = order_details.pizza_id
group by orders.order_id, date,time
order by orders.order_id, date,time
),

table_num as
(select order_id,date,time, party_size, case when party_size <4 then 1
				when party_size <8 then 2
				when party_size <12 then 3
				when party_size <16 then 4
				when party_size <20 then 5
				when party_size <24 then 6
				when party_size <28 then 7
				when party_size <32 then 8
				when party_size <36 then 9
				when party_size <40 then 10
				when party_size <44 then 11
				end table_num	
from party_size
),

table_num_after_hour as
(select order_id,date , (time + interval '1 hour'):: time as time, -(party_size),  -(case when party_size <4 then 1
				when party_size <8 then 2
				when party_size <12 then 3
				when party_size <16 then 4
				when party_size <20 then 5
				when party_size <24 then 6
				when party_size <28 then 7
				when party_size <32 then 8
				when party_size <36 then 9
				when party_size <40 then 10
				when party_size <44 then 11
				end) table_num
from party_size
),

combine_table_count as
(select * from table_num 
union all 
select * from table_num_after_hour
order by date asc,time asc
),

seating_arrangement as
(select *, 
		sum(party_size)over(partition by date order by time) running_cust_num,
		sum(table_num)over(partition by date order by time) running_table_num	
from combine_table_count
)
select * , case when running_table_num > 15 then 'Yes'
			else 'No' end table_exceeding
from seating_arrangement;













