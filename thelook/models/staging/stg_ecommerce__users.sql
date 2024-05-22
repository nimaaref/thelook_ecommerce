WITH source AS (
        SELECT *

        FROM {{ source('thelook_ecommerce', 'users') }}
)

SELECT
        id AS user_id,
        first_name,
        last_name,
        email,
        age,
        gender,
        state,
        street_address,
        postal_code,
        city,
        country,
        latitude,
        longitude,
		st_geogpoint(longitude, latitude) as user_geolocation,
        traffic_source,
        created_at

FROM source