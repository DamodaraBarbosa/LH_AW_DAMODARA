with 
    stateprovince as (
        select
            stateprovinceid
            , stateprovincecode
            , countryregioncode
            , name
            , territoryid
        from {{ source('adventure_works', 'stateprovince') }}
    )
select * 
from stateprovince