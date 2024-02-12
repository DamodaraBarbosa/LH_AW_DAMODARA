with
    customer as (
        select
            cast(customerid as int) as customerid
            , cast(personid as int) as personid
            , cast(storeid as int) as storeid
            , cast(territoryid as int) as territoryid
        from {{ source('adventure_works', 'customer') }}
    )
select * 
from customer