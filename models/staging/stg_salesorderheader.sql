with
    salesorderheader as (
        select
            salesorderid
            , date(orderdate) as orderdate
            , date(duedate) as duedate
            , date(shipdate) as shipdate
            , cast(status as int) as status
            , cast(onlineorderflag as boolean) as onlineorderflag
            , cast(customerid as int) as customerid
            , cast(territoryid as int) as territoryid
            , cast(billtoaddressid as int) as billtoaddressid
            , cast(shiptoaddressid as int) as shiptoaddressid
            , cast(shipmethodid as int) as shipmethodid
            , cast(creditcardid as int) as creditcardid
            , subtotal
            , taxamt
            , freight
            , totaldue
        from {{ source('adventure_works', 'salesorderheader') }}
    )
select *
from salesorderheader