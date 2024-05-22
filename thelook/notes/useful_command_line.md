dbt run-operation generate_base_model --args '{"source_name":"thelook_ecommerce", "table_name":"distribution_centers"}'

dbt run-operation generate_model_yaml --args '{"model_names": ["stg_ecommerce__distribution_centers"]}'