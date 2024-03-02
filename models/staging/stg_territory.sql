with
    stg_salesterritory as (
        select
            cast(territoryid as int) as territoryid
            , cast(name as string) as name
            , cast(countryregioncode as string) as countryregioncode
            , case
                when name = "France" or name = "Germany" or name = "United Kingdom" then "Europe"
                when name = "Australia" then "Pacific"
                else "North America"
            end as macrogroup
        from {{ source('adventure_works', 'salesterritory') }}
    )
select *
from stg_salesterritory