WITH events as (
	SELECT
		*
	FROM  {{ref('stg_ecommerce__events')}}
)

SELECT
  CAST(e.created_at as DATE) as event_creation_date,
  COUNT(DISTINCT e.session_id) as distinct_session_count,
FROM events as e
GROUP BY event_creation_date
