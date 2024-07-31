with  users as (
	SELECT *

	FROM {{ref('stg_ecommerce__users')}}
)

select
        distinct
        users.street_address,
        users.postal_code,
        users.city,
		users.state,
        users.country

from users