{{ config(materialized='table') }}

with
    stg_salesorderdetail as (
        select
            salesorderid
            , salesorderdetailid
            , orderqty
            , productid
            , unitprice
            , unitpricediscount
        from {{ ref('stg_salesorderdetail') }}
    )
    , dim_products as (
        select
            product_sk
            , productid
        from {{ ref('dim_products') }}
    )
    , salesorderdetail_transformed as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_salesorderdetail.salesorderid', 'stg_salesorderdetail.salesorderdetailid']) }} as salesorderdetails_sk
            , stg_salesorderdetail.salesorderid
            , stg_salesorderdetail.salesorderdetailid
            , stg_salesorderdetail.productid
            , dim_products.product_sk as product_fk
            , stg_salesorderdetail.orderqty
            , stg_salesorderdetail.unitprice
            , stg_salesorderdetail.unitpricediscount
        from stg_salesorderdetail
        left join dim_products on dim_products.productid = stg_salesorderdetail.productid
    )
select *
from salesorderdetail_transformed