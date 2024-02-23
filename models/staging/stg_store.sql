with
    store as (
        select
            businessentityid
            , name
        from {{ source('adventure_works', 'store') }}
    )
select *
from store