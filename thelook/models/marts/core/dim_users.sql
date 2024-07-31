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
),
customer_purchases AS (
    SELECT
        u.user_id,
        MIN(oip.order_creation_date) AS first_purchase_date,
        MAX(oip.order_creation_date) AS latest_purchase_date,
     FROM {{ ref('int_ecommerce__order_items_products')}} as oip
    INNER JOIN users u ON u.user_id = oip.user_id
    GROUP BY u.user_id
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
        users.created_at,
        cp.first_purchase_date,
        cp.latest_purchase_date,
		CASE WHEN cp.first_purchase_date = cp.latest_purchase_date THEN "New" ELSE "Returning" END AS customer_status
from users
inner join closest_dc as cd
        on cd.user_id = users.user_id
inner join dc
        on dc.distribution_center_id = cd.distribution_center_id
inner join customer_purchases as cp
		on cp.user_id = users.user_id
