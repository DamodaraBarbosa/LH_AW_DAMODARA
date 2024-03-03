{{ config(materialized='table') }}

with
    stg_product as (
        select *
        from {{ ref('stg_product') }}
    )

    , transformed_stg_product as (
        select
            {{ dbt_utils.generate_surrogate_key(['productid', 'name_product']) }} as skproduct
            , stg_product.*
        from stg_product
    )
select *
from transformed_stg_product