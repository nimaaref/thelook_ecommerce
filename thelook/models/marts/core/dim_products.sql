WITH products as (
	SELECT
		*
	FROM  {{ref('stg_ecommerce__products')}}
)

SELECT
	product_id,
	cost,
	category,
	name,
	brand,
	retail_price,
	department,
	sku,
	distribution_center_id
FROM products