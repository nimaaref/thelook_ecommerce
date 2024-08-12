with products
as (
	select *
	from {{ref('stg_ecommerce__products') }}
	)
select product_id
	, cost
	, category
	, name
	, brand
	, retail_price
	, department
	, sku
	, distribution_center_id
from products