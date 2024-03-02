with
    salesreason as (
        select
            cast(salesreasonid as int) as salesreasonid
            , cast(name as string) as name
            , cast(reasontype as string) as reasontype
        from {{ source('adventure_works', 'salesreason') }}
    )
select *
from salesreason