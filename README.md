# Retail Sales Analysis using PostgreSQL

A SQL project that answers 10 business questions on a retail sales dataset: daily and monthly sales, category performance, customer demographics, top customers and sales by time of day. It uses filtering, aggregation, date and time functions, `CASE` and window functions.

**Tools:** PostgreSQL, SQL (pgAdmin or any PostgreSQL client)
**Dataset:** `Retail_Sales_Analysis_utf.csv` [add the source link and row count]

---

## Business questions answered

| # | Question | SQL concepts used |
| --- | --- | --- |
| 1 | All sales made on a given date (2022-11-05) | WHERE filter |
| 2 | Clothing transactions with quantity above 2 in November 2022 | WHERE, TO_CHAR |
| 3 | Total sales for each category | GROUP BY, SUM |
| 4 | Average age of customers who bought from the Beauty category | AVG, ROUND |
| 5 | Transactions where the total sale is above 1000 | WHERE filter |
| 6 | Number of transactions by gender in each category | GROUP BY, COUNT |
| 7 | Average sale for each month and the best-selling month in each year | EXTRACT, AVG, RANK() OVER (PARTITION BY), subquery |
| 8 | Top 5 customers by total sales | GROUP BY, SUM, ORDER BY, LIMIT |
| 9 | Number of unique customers in each category | COUNT(DISTINCT) |
| 10 | Number of orders in each shift (morning, afternoon, evening) | CASE, EXTRACT(HOUR) |

---

## Dataset and table

One table, `sales_project`:

| Column | Type | Description |
| --- | --- | --- |
| `transactions_id` | INT | Primary key |
| `sale_date` | DATE | Date of the sale |
| `sale_time` | TIME | Time of the sale |
| `customer_id` | INT | Customer identifier |
| `gender` | VARCHAR(20) | Customer gender |
| `age` | INT | Customer age |
| `category` | VARCHAR(20) | Product category, for example Clothing, Beauty |
| `quantiy` | INT | Units sold (the column name is spelled this way in the script) |
| `price_per_unit` | NUMERIC(10,2) | Price of one unit |
| `cogs` | NUMERIC(10,2) | Cost of goods sold |
| `total_sale` | INT | Total sale amount for the transaction |

---

## Repository contents

```
.
├── README.md
├── [your_sql_file].sql      # table creation, data load and all 10 queries
├── data/                    # Retail_Sales_Analysis_utf.csv [if you add it]
└── images/                  # [result screenshots]
```

---

## How to run

1. Install PostgreSQL and open pgAdmin (or `psql`).
2. Create a database and run the `CREATE TABLE sales_project (...)` statement from the SQL file.
3. Load the data. In the SQL file, change the `COPY` path to where the CSV is on your machine, or use pgAdmin's Import/Export tool (or `\copy` in `psql`).
4. Run the queries one at a time; each has a comment with the question above it.

---

## Sample queries

**Best-selling month in each year (average sale per month, ranked within the year)**

```sql
SELECT year, month, avg_of_total_sale
FROM (
    SELECT EXTRACT(YEAR FROM sale_date)  AS year,
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale)               AS avg_of_total_sale,
           RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date)
                        ORDER BY AVG(total_sale) DESC) AS rnk
    FROM sales_project
    GROUP BY 1, 2
) AS t1
WHERE rnk = 1;
```

**Orders by shift**

```sql
SELECT CASE
           WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
           WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
           ELSE 'Evening'
       END AS shift,
       COUNT(*) AS num_orders
FROM sales_project
GROUP BY 1;
```

Shift rule: morning is before 12:00, afternoon is 12:00 to 17:59, evening is 18:00 onwards.

---

## Key insights

[Fill these in from your own results. Examples of what to write: which category earns the most, the average age of Beauty customers, which month is best in each year, which shift has the most orders, and who the top 5 customers are. Add one or two result screenshots in `images/`.]

---

## What I learned

- Loading a CSV into PostgreSQL and designing a table with suitable data types.
- Using date and time functions (`EXTRACT`, `TO_CHAR`) to group sales by month, year and shift.
- Ranking within groups with `RANK() OVER (PARTITION BY ...)`.
- Turning a transactions table into answers a retail business asks.

---

## Acknowledgements

Dataset: [source]. Problem statements adapted from [name the tutorial or course you followed, with a link]. The SQL solutions are my own.

---

## Author



**Rahul Kumar**: Python/Django backend developer with SQL experience
LinkedIn: [your link] | GitHub: [RahulRanjan350](https://github.com/RahulRanjan350)
