with
    address as (
        select
            cast(addressid as int) as adressid
            , cast(addressline1 as string) as addresline1
            , cast(city as string) as city
            , cast(stateprovinceid as int) as stateprovinceid
        from {{ source('adventure_works', 'address') }}
    )
select *
from address