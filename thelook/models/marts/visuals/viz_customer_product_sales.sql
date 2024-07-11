WITH order_items_products as (
	SELECT
		*
	FROM  {{ref('int_ecommerce__order_items_products')}}
)
, products as (
	SELECT
		*
	FROM {{ ref('dim_products')}}
)
, users as (
	SELECT
		*
	FROM {{ ref('dim_users')}}
)
SELECT
	oip.order_creation_date,
	oip.user_id,
	oip.order_id,
	oip.product_id,


	p.name as product_name,
	p.brand as product_brand,
	p.category as product_category,
	p.department as product_department,
u.country,
        u.state,
        u.city,

        ROUND(SUM(p.cost * oip.quantity),2) as cost,
        SUM(oip.revenue) as revenue,
        ROUND(SUM(oip.revenue) - SUM(p.cost * oip.quantity),2) as margin,
        SUM(oip.quantity) as quantity


FROM order_items_products AS oip
INNER JOIN products as p
        ON p.product_id = oip.product_id
INNER JOIN users as u
        ON u.user_id = oip.user_id
GROUP BY
        oip.order_creation_date,
        oip.order_id,
        oip.user_id,
        oip.product_id,
        p.name,
        p.brand,
        p.category,
        p.department,
        u.country,
        u.state,
        u.city