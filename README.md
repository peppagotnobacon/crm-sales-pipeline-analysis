# crm-sales-pipeline-analysis
B2B Sales Pipeline Analysis using Excel, PostgreSQL, and Power BI | Maven Analytics Dataset


# B2B Sales Pipeline Analysis

## Overview
This project analyzes a B2B sales pipeline dataset from Maven Analytics 
to identify key factors driving deal success and sales team effectiveness. 
The analysis follows an end-to-end workflow across three tools: 
Excel, PostgreSQL, and Power BI.

## Business Questions
1. Which products are the most profitable?
2. Which sales agents are the most effective?

## Tools & Workflow
| Tool | Purpose |
|---|---|
| **Excel** | Data cleaning, feature engineering, EDA (statistical analysis, correlation, pivot table) |
| **SQL (PostgreSQL)** | In-depth analysis, window functions, agent scoring system |
| **Power BI** | Interactive 3-page dashboard |

## Dataset
- Source: Maven Analytics — CRM Sales Opportunities (https://mavenanalytics.io/data-playground/crm-sales-opportunities)
- 4 tables: `accounts`, `products`, `sales_teams`, `sales_pipeline`
- 8,800 rows in main pipeline table

## Key Findings
- Overall win rate is consistent at ~63% across all categories 
  (product, region, sector)
- GTX Basic has the highest win contribution (21.59%) — most popular product
- GTK 500 has the highest median deal value ($25,897) — premium segment
- Darcel Schlecht ranked as top performer based on custom scoring system 
  (win contribution + time to close + median deal value)
- No significant correlation found between numeric variables — 
  suggesting categorical factors drive deal outcomes

## File Structure
```
├── data/
│   └── raw/          # Original CSV files
├── excel/
│   └── crm_analysis.xlsx
├── sql/
│   └── queries.sql   # All SQL queries
└── dashboard/
└── screenshots/  # Power BI dashboard screenshots
```

## Dashboard Preview
### Overview
<img width="1152" height="651" alt="image" src="https://github.com/user-attachments/assets/a5c1e318-cbcd-4a62-97db-742faf8fe86b" />



### Product Analysis
<img width="1159" height="655" alt="image" src="https://github.com/user-attachments/assets/71ab2aa1-b4ca-4610-aa17-5f4e9587bba0" />


### Regional Performance
<img width="1152" height="651" alt="image" src="https://github.com/user-attachments/assets/58c87124-4632-4eeb-89a9-670585e6d005" />
