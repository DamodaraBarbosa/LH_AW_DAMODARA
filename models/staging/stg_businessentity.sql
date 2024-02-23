with
    businessentity as (
        select
            businessentityid
        from {{ source('adventure_works', 'businessentity') }}

    )
select *
from businessentity