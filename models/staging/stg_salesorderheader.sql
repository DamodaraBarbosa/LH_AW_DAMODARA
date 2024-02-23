with
    salesorderheader as (
        select
            salesorderid
            , orderdate
            , duedate
            , shipdate
            , status
            , onlineorderflag
            , customerid
            , territoryid
            , billtoaddressid
            , shiptoaddressid
            , shipmethodid
            , creditcardid
            , subtotal
            , taxamt
            , freight
            , totaldue
        from {{ source('adventure_works', 'salesorderheader') }}
    )
select *
from salesorderheader