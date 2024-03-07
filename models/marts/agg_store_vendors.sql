with
    stg_person as (
        select *
        from {{ ref('stg_person') }}
    )
    , dim_customers as (
        select *
        from {{ ref('dim_customers') }}
    )
    , fact_sales as (
        select *
        from {{ ref('fact_sales') }}
    )
select 
    coalesce(dim_customers.store_name, "Ecommerce") as storename
    , coalesce((stg_person.firstname || " " || stg_person.middlename || " " || stg_person.lastname), "Online shop") as vendorname
    , sum(fact_sales.orderqty) as totalqty
    , sum(fact_sales.totaldue) as totaldue
from fact_sales
left join dim_customers on dim_customers.customerid = fact_sales.customerid
left join stg_person on stg_person.businessentityid = fact_sales.salespersonid
group by storename, vendorname