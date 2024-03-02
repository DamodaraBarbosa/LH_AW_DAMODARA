with
    store as (
        select
            cast(businessentityid as int) as businessentityid
            , cast(name as string) as name
        from {{ source('adventure_works', 'store') }}
    )
select *
from store