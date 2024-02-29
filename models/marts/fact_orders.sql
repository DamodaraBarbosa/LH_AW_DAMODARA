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
            , shipmethodid
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
            salesreason_sk
            , salesorderid
        from {{ ref('dim_salesreasons') }}
    )
    , sales_order_transformed as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_salesorderheader.salesorderid']) }} as order_sk
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
            , stg_salesorderheader.shipmethodid
            , dim_creditcards.creditcard_sk as creditcard_fk
            , stg_salesorderheader.creditcardid
            , dim_salesreasons.salesreason_sk as salesreason_fk
        from stg_salesorderheader
        left join dim_creditcards on dim_creditcards.creditcardid = stg_salesorderheader.creditcardid
        left join dim_locations on dim_locations.addressid = stg_salesorderheader.shiptoaddressid
        left join dim_customers on dim_customers.customerid = stg_salesorderheader.customerid
        left join dim_salesreasons on dim_salesreasons.salesorderid = stg_salesorderheader.salesorderid
    )
    , deduplicated_order_transformed as (
        select *
            , row_number() over (partition by order_sk order by salesorderid) as row_num
        from sales_order_transformed

    )
select 
    order_sk
    , salesorderid
    , orderdate
    , duedate
    , shipdate
    , status
    , onlineorderflag
    , customer_fk
    , customerid
    , territoryid
    , locations_fk
    , shiptoaddressid
    , shipmethodid
    , creditcard_fk
    , creditcardid
    , salesreason_fk
from deduplicated_order_transformed
where row_num = 1