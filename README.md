# Olist E-commerce Data Analysis Project 🛒

This repository features a comprehensive data analysis of the Olist e-commerce dataset.

The project demonstrates a full data pipeline: from raw data ingestion and cleaning using **SQL Server** to final business metrics consolidation in **Google Sheets**.

---

## Stack & Technologies

- **Database Engine:** Microsoft SQL Server (MSSQL)
- **Language:** T-SQL (Transact-SQL)
- **Data Processing:** Staging Tables, Joins, Aggregations, and Type Casting
- **Reporting:** Google Sheets (Final Spreadsheet)

---

## Project Workflow

The analysis was divided into three main technical stages:

1. **Data Sanitization**
   - Cleaning and normalizing data types for financial accuracy.

2. **Performance Metrics**
   - Calculating Revenue, Sales Volume, and Average Ticket.

3. **Regional Insights**
   - Mapping sales concentration across Brazilian states.

---

## 🛠️ Technical Challenges & Troubleshooting

During the implementation, I encountered and resolved several data integrity issues that are common in real-world ETL processes:

- **Invalid Column Names (SQL Error 207):** Some raw CSV files were imported with double quotes inside the column headers (e.g., `"order_id"`). I resolved this by creating staging tables (`_clean`) and aliasing the columns to remove the noise.
- **Data Type Mismatch (SQL Error 8117):** The `price` column was initially imported as a `VARCHAR`. This caused errors when attempting to use the `SUM()` function. 
- **Currency Localization:** Since the dataset uses the Brazilian format (commas for decimals), I implemented a transformation pipeline using `REPLACE(price, ',', '.')` combined with `TRY_CAST(... AS FLOAT)` to ensure mathematical accuracy without breaking the query.
- **Null Category Handling:** Identified missing values in the product category names. I applied filters to ensure the business reports focused only on classified data.

---

# SQL Repository (Queries)

Below are the documented queries used in the process.

---

## 1. Data Cleaning & Staging

**File:** `01_staging_cleaning.sql`

Prepares the raw data by ensuring financial columns are correctly typed as `FLOAT`.

```sql
/*
Author: Mauricio
Description: Standardizing data types for price and freight
to ensure mathematical accuracy.
*/

SELECT
    order_id,
    product_id,
    CAST(price AS FLOAT) AS price,
    CAST(freight_value AS FLOAT) AS freight_value
INTO olist_order_items_clean
FROM olist_order_items_dataset;
```

---

## 2. Category Performance Analysis

**File:** `02_category_performance.sql`

Aggregates sales data to rank product categories by total revenue.

```sql
/*
Author: Mauricio
Description: Ranks the top product categories
by total revenue and sales volume.
*/

SELECT
    p.product_category_name AS category,
    COUNT(oi.order_id) AS sales_volume,
    SUM(oi.price) AS total_revenue,
    AVG(oi.price) AS average_ticket
FROM olist_order_items_clean oi
JOIN olist_products_dataset p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_revenue DESC;
```

---

## 3. Regional Sales Distribution

**File:** `03_regional_distribution.sql`

Identifies the geographical distribution of revenue.

```sql
/*
Author: Mauricio
Description: Analyzes sales distribution across
different Brazilian states (UF).
*/

SELECT
    c.customer_state AS state,
    COUNT(o.order_id) AS total_orders,
    SUM(oi.price) AS state_revenue
FROM olist_orders_dataset o
JOIN olist_customers_dataset c
    ON o.customer_id = c.customer_id
JOIN olist_order_items_clean oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY state_revenue DESC;
```

---

# Spreadsheet Analysis (Top 10 Categories)

The following metrics were consolidated in a Google Sheets spreadsheet after exporting the SQL results.

| Category               | Sales Volume | Total Revenue (R$) | Avg Ticket (R$) |
| ---------------------- | ------------ | ------------------ | ---------------- |
| beleza_saude           | 9,670        | 1,258,681.34       | 130.16           |
| relogios_presentes     | 5,991        | 1,203,505.60       | 200.89           |
| cama_mesa_banho        | 11,115       | 1,036,988.68       | 93.30            |
| esporte_lazer          | 8,641        | 988,048.06         | 114.34           |
| informatica_acessorios | 7,827        | 911,954.32         | 116.51           |
| moveis_decoracao       | 8,334        | 729,762.49         | 87.56            |
| utilidades_domesticas  | 6,964        | 632,248.05         | 90.78            |
| instrumentos_musicais  | 680          | 191,482.53         | 281.59           |
| cool_stuff             | 3,796        | 635,290.99         | 167.36           |
| brinquedos             | 4,117        | 483,946.45         | 117.55           |

---

# Key Conclusions

- **Top Performer:** Health & Beauty leads in total revenue.
- **High Volume:** Bed, Bath & Table shows the highest market penetration.
- **Premium Segment:** Musical Instruments presents the highest average ticket in the top 10.
- **Geographic Bias:** Revenue is heavily concentrated in the Southeast region.

---

# Next Steps

- Integrate data with Power BI for interactive dashboards.
- Perform deeper logistics analysis (Shipping vs. Lead Time).
