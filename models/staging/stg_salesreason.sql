with
    salesreason as (
        select
            salesreasonid
            , name
            , reasontype
        from {{ source('adventure_works', 'salesreason') }}
    )
select *
from salesreason