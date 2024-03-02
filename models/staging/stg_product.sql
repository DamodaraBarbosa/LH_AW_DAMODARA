with
    product as (
        select 
            cast(productid as int) as productid
            , cast(name as string) as name
            , cast(color as string) as color
            , cast(listprice as decimal) as listprice
            , cast(sellstartdate as datetime) as sellstartdate 
        from {{ source('adventure_works', 'product') }}
    )
select *
from product