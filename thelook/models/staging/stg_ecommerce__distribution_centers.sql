
WITH source AS (
        SELECT *

        FROM {{ source('thelook_ecommerce', 'distribution_centers') }}
)

SELECT
        id AS distribution_center_id,
        name,
		latitude,
        longitude,
        st_geogpoint(longitude, latitude) as dc_geolocation
FROM source