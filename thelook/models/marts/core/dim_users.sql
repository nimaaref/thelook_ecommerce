with  users as (
	SELECT *

	FROM {{ref('stg_ecommerce__users')}}
)
, closest_dc as (

	SELECT *
	FROM {{ ref('int_ecommerce__user_closest_dc')}}
),
dc as (
	SELECT *
	FROM {{ ref('stg_ecommerce__distribution_centers')}}
)

select
        users.user_id,
        cd.distribution_center_id as closest_dc_id,
        dc.name as closest_dc_name,
        users.first_name,
        users.last_name,
        users.email,
        users.age,
        users.gender,
        users.traffic_source,
        users.state,
        users.street_address,
        users.postal_code,
        users.city,
        users.country,
        users.user_geolocation,
        users.created_at

from users
inner join closest_dc as cd
        on cd.user_id = users.user_id
inner join dc
        on dc.distribution_center_id = cd.distribution_center_id
