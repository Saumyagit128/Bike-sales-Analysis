# 🚴‍♂️ Bike Sales Analysis  

## 🔥 Problem Statement  

An international retailer specializing in bikes, accessories, and clothing faces challenges in understanding its sales performance, customer behavior, and product profitability across different geographies. Despite having large amounts of transactional data, the company lacks clear visibility into:  

- Which products and customer segments drive the most revenue.  
- How customer purchasing behavior changes over time.  
- Which regions outperform others in terms of sales.  
- How product categories contribute to overall revenue.  
- Identifying top customers and high-performing products.  

🎯 **Goal:** Use Power BI to transform raw sales data into actionable insights that enable data-driven decision-making for marketing, inventory management, customer retention, and revenue optimization.

## 🗺️ Project Overview  

This project focuses:  
- **Data Exploration (EDA) using SQL** – understanding the data structure, distributions, and basic business metrics. 
- **Data Modeling** – creating clean, aggregated views for products and customers.  
- **Data Visualization with Power BI** – building interactive dashboards.  
- **Insights & Recommendations** – delivering actionable solutions aligned with the problem statement. 

## 🛠️ Tools & Technologies  

| Tool          | Purpose                                     |  
|----------------|---------------------------------------------|
| **SQL (MySQL)** | Data extraction, EDA                      |
| **Power BI**    | Data Modeling, Visualization, Dashboards  |  
| **DAX**         | Calculated Measures, Advanced Analytics   |  

## 🌟 Project Highlights  

- ✅ Created **3 comprehensive Power BI dashboards**:  
  1. Sales Performance Summary + Time Series analysis + Geographical analysis
  2. Product Insights  
  3. Customer Insights  

- ✅ SQL-powered data exploration 
- ✅ Built advanced DAX measures for MoM/YoY growth, moving averages, and forecasting.  
- ✅ Delivered clear insights on revenue drivers, customer behavior, and market opportunities.

##  Dataset overview
- gold.fact_sales.csv : All sales transacion records for all purchases (fact table) 
- gold.dim_customers.csv : Customer Information (dimension table)
- gold.dim_products.csv : Products information (dimension table)

## 🏗️ Exploratory Data Analysis (EDA) – SQL

- Used SQL for basic database exploration and to understand the data better for better Power BI visualization
- 🎯 Data Segmentation  
  - Product Cost Segmentation: Expensive, Mid-range, Cheaper  
  - Customer Segmentation by Spending:
    - VIP: >$5000 & ≥12 months lifespan  
    - Regular: ≤$5000 & ≥12 months lifespan  
    - New: <12 months lifespan  
- Generated a **product-level summary view** with key metrics. 
- Generated a **customer summary view** capturing lifetime metrics.

 **Value Added by SQL Views**  
- Simplify Power BI modeling  
- Enable faster report performance  
- Power deep product- and customer-specific insights

## 📊 Data Visualization – Power BI Dashboards  

### 📄 Page 1: Sales Performance Overview + Time Series + Geographical  

#### 🎯 Purpose: High-level KPIs, revenue, time series, and geographical insights.  

#### 🔸 Visuals:  
- KPI Cards: Revenue, Total Orders, Total Customers, YoY Growth %  
- Revenue by Country (Column Chart)  
- Top 5 Products by Revenue (Column Chart)  
- Donut Charts:  
  - Revenue by Customer Segment  
  - Revenue by Product Segment  
  - Revenue by Weekday vs Weekend  
- Time Series:  
  - Yearly & Monthly Revenue (Line Chart)  
  - Cumulative Revenue (Area Chart)  
  - Monthly Growth % (Column Chart)  
  - Revenue Forecast (2 Years Ahead)  
  - 3-Month Moving Avg (Line Chart)  
- Slicers: Year, Country, Category  
- Page Navigation Enabled

DAX:

    Total Sales = SUM(fact_sales[sales_amount])

    Total Orders = DISTINCTCOUNT(order_number)

YoY Growth using:

    Latest Year = MAX('Date Table'[Year])
    Latest Year Revenue = CALCULATE( [Total Revenue], 'Date Table'[Year] = MAX('Date Table'[Year]))
    Previous Year Revenue = 
    CALCULATE(
        [Total Revenue],
        'Date Table'[Year] = MAX('Date Table'[Year]) - 1
    )

    YoY Growth % = 
    DIVIDE([Latest Year Revenue] - [Previous Year Revenue], [Previous Year Revenue])

Monthly growth using: - 
    
    Previous Month Revenue = 
    CALCULATE(
        [Total Revenue],
        PREVIOUSMONTH('Date Table'[Date]))

    MoM Growth % = 
    IF(NOT ISBLANK([Previous Month Revenue]), DIVIDE([Total Revenue] - [Previous Month Revenue], [Previous Month Revenue], BLANK()))

For Cumulative revenue graph -
    
    Running Total Revenue = 
    CALCULATE(
    [Total Revenue],
    FILTER(
        ALLSELECTED('Date Table'[Date]),
        'Date Table'[Date] <= MAX('Date Table'[Date])
        )
    )
    

For 3- month moving avg -

    3-Month Moving Avg = 
    AVERAGEX(
    DATESINPERIOD(
        'Date Table'[Date],
        MAX('Date Table'[Date]),
        -3,
        MONTH
        ), [Total Revenue]
    )

### 🚴‍♂️ Page 2: Product Insights  

#### 🎯 Purpose: Deep dive into product performance.  

#### 🔸 Visuals:  
- Scatter Plot: Avg Order Value vs Total Quantity (Bubble size: Total Sales, Color: Category)  
- Donut Charts (x3): Revenue by Subcategory for Bikes, Clothing, Accessories  
- Total Orders by Product Segment  
- Total Revenue by Product Segment  
- Product KPI Table (report_product view)  
- Slicers: Year, Country, Category
- Page Navigation Enabled
  
### 👥 Page 3: Customer Insights  

#### 🎯 Purpose: Analyze customer behavior and value.  

#### 🔸 Visuals:  
- Customer Lifecycle Scatter Plot (Lifespan vs Recency)  
- Donut Charts:  
  - Customer Segments (VIP, Regular, New)  
  - Revenue by Customer Segment  
  - Revenue by Age Group (Bar Chart)  
  - Revenue by Gender (Bar Chart)  
- Customer Count by Country (Bar Chart)  
- Customer KPI Table (report_customer view)  
- Slicers: Year, Country, Category
- Page Navigation Enabled

## 🔥 Key Insights & Solutions  

### 📌 Insights:  
- Bikes generate ~60% of revenue.  
- Clothing has high sales volume but lower revenue contribution.  
- VIP customers drive a disproportionate share of revenue.  
- USA and Germany are top-performing countries.  
- Strong seasonal peaks (summer).  
- Several products underperform and may need promotions or removal.  

### 🏆 Solutions:  
- Retention Focus: Prioritize engagement for VIPs and Regular customers.
- Increase inventory for high-performing products.  
- Marketing Strategy: Target countries with high sales potential; promote during peak months.  
- New Customer Acquisition: Target **female customers** (nearly 50% of revenue); design products like bikes with compartments for essentials.  
  - Capture younger customers for long-term growth.  
- Collaborate with **touring groups** to rent tour bikes, which currently underperform.

# Snapshot of the Dashboard
## Sales Performance
![Image](https://github.com/user-attachments/assets/121accb7-bfe6-4245-ada9-5244dee56847)

## Product Insights
<img width="1467" height="825" alt="image" src="https://github.com/user-attachments/assets/c998e44d-6702-4141-b5e6-e0c870a63469" />

## Customer Insights
![Image](https://github.com/user-attachments/assets/55cdc040-9f58-4298-8af3-8a65171acf2f)
