{{ config(materialized='table') }}

with
    stg_salesorderheader as (
        select
            salesorderid
            , orderdate
            , duedate
            , shipdate
            , case
                when status = 1 then "In process"
                when status = 2 then "Approved"
                when status = 3 then "Backordered"
                when status = 4 then "Rejected"
                when status = 5 then "Shipped"
                when status = 6 then "Cancelled"
            end as status
            , onlineorderflag
            , customerid
            , territoryid
            , shiptoaddressid
            , creditcardid
            , subtotal
            , taxamt
            , freight
            , totaldue
        from {{ ref('stg_salesorderheader') }}
    )
    , dim_creditcards as (
        select
            creditcard_sk
            , creditcardid
        from {{ ref('dim_creditcards') }}
    )
    , dim_customers as (
        select
            customer_sk
            , customerid
        from {{ ref('dim_customers') }}
    )
    , dim_locations as (
        select 
            locations_sk
            , addressid
        from {{ ref('dim_locations') }}
    )
    , dim_salesreasons as (
        select
            reason_sk
            , salesorderid
            , reason_name
        from {{ ref('dim_salesreasons') }}
    )
    , stg_salesorderdetail as (
        select
          salesorderid
          , salesorderdetailid
          , orderqty
          , productid
          , unitprice
          , unitpricediscount
        from {{ ref('stg_salesorderdetail') }}
    )
    , transformed_sales as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_salesorderheader.salesorderid', 'stg_salesorderdetail.salesorderdetailid']) }} as sales_sk
            , stg_salesorderheader.salesorderid
            , stg_salesorderheader.orderdate
            , stg_salesorderheader.duedate
            , stg_salesorderheader.shipdate
            , stg_salesorderheader.status
            , stg_salesorderheader.onlineorderflag
            , dim_customers.customer_sk as customer_fk
            , stg_salesorderheader.customerid
            , stg_salesorderheader.territoryid
            , dim_locations.locations_sk as locations_fk
            , stg_salesorderheader.shiptoaddressid
            , dim_creditcards.creditcard_sk as creditcard_fk
            , stg_salesorderheader.creditcardid
            , stg_salesorderdetail.salesorderdetailid
            , stg_salesorderdetail.orderqty
            , ((1 - stg_salesorderdetail.unitpricediscount) * stg_salesorderdetail.unitprice * stg_salesorderdetail.orderqty) as totaldue
            , dim_salesreasons.reason_sk as reason_fk
        from stg_salesorderheader
        left join dim_customers on dim_customers.customerid = stg_salesorderheader.customerid
        left join dim_locations on dim_locations.addressid = stg_salesorderheader.shiptoaddressid
        left join dim_creditcards on dim_creditcards.creditcardid = stg_salesorderheader.creditcardid
        left join dim_salesreasons on dim_salesreasons.salesorderid = stg_salesorderheader.salesorderid
        left join stg_salesorderdetail on stg_salesorderdetail.salesorderid = stg_salesorderheader.salesorderid
    )
select *
from transformed_sales