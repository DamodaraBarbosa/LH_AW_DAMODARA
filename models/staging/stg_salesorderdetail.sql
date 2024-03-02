with
    salesorderdetail as (
        select
            cast(salesorderid as int) as salesorderid
            , cast(salesorderdetailid as int) as salesorderdetailid
            , cast(orderqty as int) as orderqty
            , cast(productid as int) as productid
            , cast(unitprice as int) as unitprice
            , cast(unitpricediscount as decimal) as unitpricediscount
        from {{ source('adventure_works', 'salesorderdetail') }}
    )
select *
from salesorderdetail