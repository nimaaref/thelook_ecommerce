WITH events as (
	SELECT
		*
	FROM  {{ref('stg_ecommerce__events')}}
)

SELECT
  cast(e.created_at as date) as event_creation_date,
  traffic_source,
  event_type,
  browser,
  COUNT(DISTINCT SESSION_ID) AS session_count,
  COUNT(DISTINCT CASE WHEN event_type = "purchase" THEN SESSION_ID  END) AS purchase_count,
  COUNT(DISTINCT CASE WHEN event_type = "cart" THEN SESSION_ID  END) AS cart_count,
  COUNT(DISTINCT CASE WHEN event_type = "product" THEN SESSION_ID END) AS product_count,

 FROM events as e

 where event_type in ("purchase","cart","product")
group by
  cast(e.created_at as date) ,
  traffic_source,
  event_type,
  browser
