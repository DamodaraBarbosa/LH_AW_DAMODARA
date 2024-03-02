with
    businessentityaddress as (
        select
            cast(businessentityid as int) as businessentityid
            , cast(addressid as int) as addressid
            , cast(addresstypeid as int) as addresstypeid
        from {{ source('adventure_works', 'businessentityaddress') }}
    )
select *
from businessentityaddress

