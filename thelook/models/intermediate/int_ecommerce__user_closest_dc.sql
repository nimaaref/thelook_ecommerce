WITH distribution_centers as (
	SELECT
	*
	FROM {{ ref('stg_ecommerce__distribution_centers')}}
)

, users as (
	SELECT *

	FROM {{ref('stg_ecommerce__users')}}
)
, user_dc_geo_distance as (

SELECT
  user_id,
  dc.distribution_center_id,
  dc.name as dc_name,
  st_distance(u.user_geolocation,dc.dc_geolocation)/1000 as distance_in_kms

FROM USERS as u
CROSS JOIN distribution_centers as dc
)

select
	user_id,
	distribution_center_id,
	dc_name,
	distance_in_kms

from user_dc_geo_distance
qualify row_number() over(partition by user_id order by distance_in_kms asc)  = 1

