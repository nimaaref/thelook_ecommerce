with  users as (
	SELECT *

	FROM {{ref('stg_ecommerce__users')}}
)
, closest_dc as (

	SELECT *
	FROM {{ ref('int_ecommerce__user_closest_dc')}}
)

select
        users.*,
        cd.distribution_center_id,
        cd.dc_name,
        cd.distance_in_kms

from users
inner join closest_dc as cd
        on cd.user_id = users.user_id