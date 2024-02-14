with
    businessentityaddress as (
        select
        businessentityid
        , addressid
        , addresstypeid
        from {{ source('adventure_works', 'businessentityaddress') }}
    )
select *
from businessentityaddress

