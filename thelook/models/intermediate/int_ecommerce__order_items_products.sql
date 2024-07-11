WITH orders as (
	SELECT
		*
	FROM  {{ref('stg_ecommerce__orders')}}
)

, order_items as (
	SELECT
		*
	FROM  {{ref('stg_ecommerce__order_items')}}
)
, inventory_items as (
	SELECT *

	FROM {{ref('stg_ecommerce__inventory_items')}}
)
, dc as (
	SELECT *

	FROM {{ref('stg_ecommerce__distribution_centers')}}
)
	SELECT
	-- Date
   		CAST(oi.created_at AS DATE) as order_creation_date,

	-- Ids
		oi.user_id,
		oi.order_id,
		oi.product_id,
		oi.inventory_item_id,
		ii.product_distribution_center_id,
		dc.name as product_distribution_name,
		oi.status,


	--Calculated Fields
		ROUND(SUM(oi.sale_price),2) AS sale_price,
		ROUND(SUM(oi.sale_price * o.num_of_item),2) as revenue,
		SUM(o.num_of_item) as quantity
  	FROM order_items as oi
  	INNER JOIN orders as o
    	ON o.order_id = oi.order_id
	INNER JOIN inventory_items as ii
		ON ii.inventory_item_id = oi.inventory_item_id
	INNER JOIN dc
		ON dc.distribution_center_id = ii.product_distribution_center_id
  	GROUP BY
		order_creation_date,
		oi.user_id,
		oi.order_id,
		oi.product_id,
		oi.inventory_item_id,
		ii.product_distribution_center_id,
		oi.status,
		dc.name

