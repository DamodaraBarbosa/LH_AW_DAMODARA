with
    creditcard as (
        select 
        cast(creditcardid as int) as creditcardid
        , cardtype
        , cast(cardnumber as int) as cardnumber
        from {{ source('adventure_works', 'creditcard') }}
    )
select *
from creditcard