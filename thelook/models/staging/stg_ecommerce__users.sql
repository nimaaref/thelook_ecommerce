with source
as (
	select *
	from {{ source('thelook_ecommerce', 'users') }}
	)
select id as user_id
	, first_name
	, last_name
	, email
	, age
	, gender
	, state
	, street_address
	, postal_code
	, city
	, country
	, latitude
	, longitude
	, st_geogpoint(longitude, latitude) as user_geolocation
	, traffic_source
	, created_at
from source