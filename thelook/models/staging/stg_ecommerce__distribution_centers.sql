with source
as (
	select *
	from {{ source('thelook_ecommerce', 'distribution_centers') }}
	)
select id as distribution_center_id
	, name
	, latitude
	, longitude
	, st_geogpoint(longitude, latitude) as dc_geolocation
from source