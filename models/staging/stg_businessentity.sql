with
    businessentity as (
        select
            businessentityid
            , rowguide
        from {{ source('adventure_works', 'businessentity') }}

    )
select *
from businessentity