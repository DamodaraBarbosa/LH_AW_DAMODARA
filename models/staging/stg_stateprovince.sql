with 
    stateprovince as (
        select
            cast(stateprovinceid as int) as stateprovinceid
            , cast(stateprovincecode as string) as stateprovincecode
            , cast(countryregioncode as string) as countryregioncode
            , cast(name as string) as name
            , cast(territoryid as int) as territoryid
        from {{ source('adventure_works', 'stateprovince') }}
    )
select * 
from stateprovince