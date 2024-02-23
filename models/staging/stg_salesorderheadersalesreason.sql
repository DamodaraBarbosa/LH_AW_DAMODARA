with
    salesorderheadersalesreason as (
        select
            salesorderid
            , salesreasonid
        from {{ source('adventure_works', 'salesorderheadersalesreason') }}
    )
select *
from salesorderheadersalesreason