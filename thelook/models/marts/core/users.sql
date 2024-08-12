with users
as (
	select *
	from {{ref('stg_ecommerce__users') }})
, closest_dc
as (
	select *
	from {{ ref('int_ecommerce__user_closest_dc') }})
	, dc
as (
	select *
	from {{ ref('stg_ecommerce__distribution_centers') }})
, customer_purchases
as (
	select u.user_id
		, MIN(oip.order_creation_date) as first_purchase_date
		, MAX(oip.order_creation_date) as latest_purchase_date
		,
	from {{ ref('int_ecommerce__order_items_products') }} as oip
	inner join users u
		on u.user_id = oip.user_id
	group by u.user_id
	)
select users.user_id
	, cd.distribution_center_id as closest_dc_id
	, dc.name as closest_dc_name
	, users.first_name
	, users.last_name
	, users.email
	, users.age
	, users.gender
	, users.traffic_source
	, users.state
	, users.street_address
	, users.postal_code
	, users.city
	, users.country
	, users.user_geolocation
	, users.created_at
	, cp.first_purchase_date
	, cp.latest_purchase_date
	, case
		when cp.first_purchase_date = cp.latest_purchase_date
			then "New"
		else "Returning"
		end as customer_status
from users
inner join closest_dc as cd
	on cd.user_id = users.user_id
inner join dc
	on dc.distribution_center_id = cd.distribution_center_id
inner join customer_purchases as cp
	on cp.user_id = users.user_id