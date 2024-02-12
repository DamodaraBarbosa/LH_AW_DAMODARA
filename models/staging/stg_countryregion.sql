with
    countryregion as (
        select
            countryregioncode
            , name
        from {{ source('adventure_works', 'countryregion') }}
    )
select *
from countryregion