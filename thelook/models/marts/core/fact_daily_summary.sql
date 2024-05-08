WITH daily_sessions as (
	SELECT
		*
	FROM  {{ref('int_ecommerce__daily_session_count')}}
)
, order_items_products as(
	SELECT
		*
	FROM {{ ref('int_ecommerce__order_items_products')}}
)

SELECT
-- Date
	oip.order_creation_date,

-- Calculated Metrics
	SUM(DS.distinct_session_count) as distinct_session_count,
	SUM(oip.revenue) as revenue,
	COUNT(DISTINCT oip.order_id) as order_count,
	SUM(oip.quantity) as quantity


FROM order_items_products as oip
INNER JOIN daily_sessions as ds
	ON ds.event_creation_date = oip.order_creation_date
GROUP BY
	oip.order_creation_date