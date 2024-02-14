with
    address as (
        select
            addressid
            , addressline1
            , city
            , stateprovinceid
        from {{ source('adventure_works', 'address') }}
    )
select *
from address