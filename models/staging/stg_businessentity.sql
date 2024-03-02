with
    businessentity as (
        select
            cast(businessentityid as int) as businessentityid
        from {{ source('adventure_works', 'businessentity') }}

    )
select *
from businessentity