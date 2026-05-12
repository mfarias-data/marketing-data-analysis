# Processed Data & Reports

## Overview
This directory contains the final outputs of the Olist Sales Performance analysis. These files translate SQL queries into visual and structured business insights for executive decision-making.

## ⚠️ Important Note on Data Localization
Please note that column headers and category names (e.g., "relogios_presentes", "Faturamento_Total") follow the **Portuguese (pt-BR)** naming convention. This was intentionally maintained to preserve data lineage and ensure consistency with the original Olist dataset sourced from Kaggle, avoiding potential mapping errors during the ETL process.

## Files Description

### 1. Sales_Performance_Report.xlsx
A multi-tab spreadsheet consolidating the data extracted via SQL:
- **Performance por Categoria:** Displays Sales Volume, Total Revenue, and Average Ticket (AOV) for each product category.
- **Performance por Estado:** Breaks down the distribution of orders and revenue across Brazilian states.

### 2. Análise de Performance Olist.pdf
A high-level executive presentation (Strategy Consulting style).
- **Key Visuals:** Geographic concentration maps, Pareto-style category rankings, and Average Ticket analysis.
- **Strategic Highlight:** Explains why "Relógios e Presentes" is a high-priority category due to its superior profit margin per sale.

## Main Business Insights
- **Regional Dominance:** São Paulo (SP) is the primary market hub, accounting for ~42% of all orders.
- **Revenue vs. Volume:** While "Cama, Mesa e Banho" leads in sales volume, "Relógios e Presentes" generates higher total revenue due to its superior Average Ticket (~R$ 200.89).
- **Growth Opportunity:** Identifies the need for logistical optimization in the South and Northeast regions to reduce dependency on the Southeast hub.

## Tooling
- Data processed in **SQL Server**.
- PDF Friendly Report generated using **Python (Pandas)** and **HTML/CSS** for executive-level formatting.
