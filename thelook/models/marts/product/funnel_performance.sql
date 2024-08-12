with events
as (
	select *
	from {{ref('stg_ecommerce__events') }}
	)
select cast(e.created_at as date) as event_creation_date
	, traffic_source
	, event_type
	, browser
	, COUNT(distinct SESSION_ID) as session_count
	, COUNT(distinct case
			when event_type = "purchase"
				then SESSION_ID
			end) as purchase_count
	, COUNT(distinct case
			when event_type = "cart"
				then SESSION_ID
			end) as cart_count
	, COUNT(distinct case
			when event_type = "product"
				then SESSION_ID
			end) as product_count
	,
from events as e
where event_type in (
		"purchase"
		, "cart"
		, "product"
		)
group by cast(e.created_at as date)
	, traffic_source
	, event_type
	, browser