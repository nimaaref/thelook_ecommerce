with order_items_products
as (
	select *
	from {{ref('int_ecommerce__order_items_products') }})
, products
as (
	select *
	from {{ ref('products') }})
, users
as (
	select *
	from {{ref('users') }}
	)
select oip.order_creation_date
	, oip.user_id
	, oip.order_id
	, oip.product_id
	,
	---PRODUCT INFORMATION
	p.name as product_name
	, p.brand as product_brand
	, p.category as product_category
	, p.department as product_department
	,
	---USER METRICS
	u.traffic_source
	, u.country
	, u.state
	, u.closest_dc_name as customer_closest_dc
	, oip.product_distribution_name as product_originating_dc
	, case
		when u.closest_dc_name <> oip.product_distribution_name
			then "Not Matching"
		else "Matching"
		end as dc_match
	, u.customer_status
	,
	---AGGREGATED METRICS
	ROUND(SUM(p.cost * oip.quantity), 2) as cost
	, SUM(oip.revenue) as revenue
	, ROUND(SUM(oip.revenue) - SUM(p.cost * oip.quantity), 2) as margin
	, SUM(oip.quantity) as quantity
	, COUNT(distinct case
			when u.closest_dc_name = oip.product_distribution_name
				then oip.order_id
			end) as matches_closest_dc
	, COUNT(distinct case
			when u.closest_dc_name <> oip.product_distribution_name
				then oip.order_id
			end) as not_matching_closest_dc
from order_items_products as oip
inner join products as p
	on p.product_id = oip.product_id
inner join users as u
	on u.user_id = oip.user_id
group by oip.order_creation_date
	, oip.order_id
	, oip.user_id
	, oip.product_id
	, p.name
	, p.brand
	, p.category
	, p.department
	, u.traffic_source
	, u.country
	, u.state
	, oip.product_distribution_name
	, u.closest_dc_name
	, u.customer_status