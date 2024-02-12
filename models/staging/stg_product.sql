with
    product as (
        select 
            cast(productid as int) as productid
            , name
            , color
            , cast(listprice as decimal) as listprice
            , sellstartdate
        from {{ source('adventure_works', 'product') }}
    )
select *
from product