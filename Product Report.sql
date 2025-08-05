/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from fact_sales and dim_products
---------------------------------------------------------------------------*/
CREATE VIEW report_product as
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from fact_sales and dim_products
---------------------------------------------------------------------------*/
With base_query as (
					select
						s.order_number,	s.order_date, p.product_key, 
                        p.product_name, p.category, p.subcategory,
						p.cost, s.customer_key, s.sales_amount, s.quantity																										
					from fact_sales s
						left join dim_products p
							on s.product_key = p.product_key
					),
	product_aggregation as (
    /*---------------------------------------------------------------------------
2) Product_aggregation: Summurizes key metrics at the product level
---------------------------------------------------------------------------*/
							select
								product_key, product_name, category, subcategory, cost,
								count(distinct order_number) as total_orders,
								sum(sales_amount) as total_sales,
								sum(quantity) as total_quantity,
								count(distinct customer_key) as total_customers,
								max(order_date) as last_sale_date,
								timestampdiff(month, max(order_date), curdate()) as recency,
								timestampdiff(month, min(order_date), max(order_date)) as lifespan
							from base_query
							group by product_key, product_name, category, subcategory, cost
							)
/*---------------------------------------------------------------------------
  3) Final Query: Combines all product results into one output
---------------------------------------------------------------------------*/
select 
	product_key, product_name, category, subcategory, cost,
	total_orders, total_sales, total_quantity, total_customers,
	case 
		 when total_quantity = 0 then 0
		 else round(total_sales/total_orders)
	end as avg_order_revenue,
	case 
		 when lifespan = 0 then total_sales
		 else round(total_sales/lifespan)
	end as avg_monthly_revenue,
	case 
		 when total_sales > 500000 then "High-performer"
		 when total_sales between 100000 and 500000 then "Mid-Range"
		 else "Low-performer"
	end as product_segment,
	last_sale_date, recency, lifespan
from product_aggregation;


select* from report_product;







