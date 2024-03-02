with
    countryregion as (
        select
            cast(countryregioncode as string) as countryregioncode
            , cast(name as string) as name
        from {{ source('adventure_works', 'countryregion') }}
    )
select *
from countryregion