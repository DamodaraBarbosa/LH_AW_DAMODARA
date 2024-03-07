with
    store as (
        select
            cast(businessentityid as int) as businessentityid
            , cast(name as string) as name
            , cast(salespersonid as int) as salespersonid
        from {{ source('adventure_works', 'store') }}
    )
select *
from store