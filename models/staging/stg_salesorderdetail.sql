with
    salesorderdetail as (
        select
            salesorderid
            , salesorderdetailid
            , orderqty
            , productid
            , unitprice
            , unitpricediscount
        from {{ source('adventure_works', 'salesorderdetail') }}
    )
select *
from salesorderdetail