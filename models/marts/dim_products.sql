{{ config(materialized='table') }}

with
    stg_product as (
        select
            productid
            , name
        from {{ ref('stg_product') }}
    )

    , transformed_stg_product as (
        select
            {{ dbt_utils.generate_surrogate_key(['productid', 'name']) }} as product_sk
            , productid
            , name
        from stg_product
    )
select *
from transformed_stg_product