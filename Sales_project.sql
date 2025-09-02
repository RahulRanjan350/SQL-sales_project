create table sales_project (transactions_id int primary key,
							sale_date date,
							sale_time time,
							customer_id int,
							gender varchar(20),
							age int,
							category varchar(20),
							quantiy int,
							price_per_unit numeric(10,2),
							cogs numeric(10,2),	total_sale int
);

select * from sales_project;

copy sales_project
from 'D:\CSV File\Retail_Sales_Analysis_utf.csv'
delimiter ','
csv header;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
select * from sales_project where sale_date='2022-11-05';
 
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and
--the quantity sold is more than 2 in the month of Nov-2022
SELECT TO_CHAR(sale_date, 'Mon-YYYY') AS formatted_date
FROM sales_project;

select * from sales_project
where category='Clothing' 
and quantiy >2
and TO_CHAR(sale_date, 'Mon-YYYY')='Nov-2022';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
select category, sum(total_sale) as category_wise_total_sale from sales_project group by category;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age)) as avg_age 
from sales_project 
where category='Beauty'; 

SELECT AVG(age) AS avg_age
FROM sales_project
WHERE category = 'Beauty';

SELECT category, AVG(age) AS avg_age
FROM sales_project
GROUP BY category;


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * 
from sales_project 
where total_sale>1000; 


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
select category,gender, count(transactions_id) from sales_project group by gender,category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

select year,month,avg_of_total_sale from		
		(select extract(year from sale_date) as year, extract(month from sale_date) as month, avg(total_sale) as avg_of_total_sale,
		rank() over (partition by extract(year from sale_date) order by avg(total_sale) desc) as rank 
		from sales_project group by 1,2) as t1
		where rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
select  customer_id,sum(total_sale) as no_of_sale from sales_project  group by customer_id   order by no_of_sale desc limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct(customer_id)) as Total_customer from sales_project group by category;
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS num_orders
FROM sales_project
GROUP BY 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END;


	----End of Project----
