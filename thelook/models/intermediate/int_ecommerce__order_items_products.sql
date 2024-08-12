with orders
as (
	select *
	from {{ref('stg_ecommerce__orders') }})
, order_items
as (
	select *
	from {{ref('stg_ecommerce__order_items') }})
, inventory_items
as (
	select *
	from {{ref('stg_ecommerce__inventory_items') }})
, dc
as (
	select *
	from {{ref('stg_ecommerce__distribution_centers') }}
	)
select
	-- Date
	CAST(oi.created_at as date) as order_creation_date
	,
	-- Ids
	oi.user_id
	, oi.order_id
	, oi.product_id
	, oi.inventory_item_id
	, ii.product_distribution_center_id
	, dc.name as product_distribution_name
	, oi.status
	,
	--Calculated Fields
	ROUND(SUM(oi.sale_price), 2) as sale_price
	, ROUND(SUM(oi.sale_price * o.num_of_item), 2) as revenue
	, SUM(o.num_of_item) as quantity
from order_items as oi
inner join orders as o
	on o.order_id = oi.order_id
inner join inventory_items as ii
	on ii.inventory_item_id = oi.inventory_item_id
inner join dc
	on dc.distribution_center_id = ii.product_distribution_center_id
group by order_creation_date
	, oi.user_id
	, oi.order_id
	, oi.product_id
	, oi.inventory_item_id
	, ii.product_distribution_center_id
	, oi.status
	, dc.name