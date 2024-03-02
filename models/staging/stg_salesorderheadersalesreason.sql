with
    salesorderheadersalesreason as (
        select
            cast(salesorderid as int) as salesorderid
            , cast(salesreasonid as int) as salesreasonid
        from {{ source('adventure_works', 'salesorderheadersalesreason') }}
    )
select *
from salesorderheadersalesreason