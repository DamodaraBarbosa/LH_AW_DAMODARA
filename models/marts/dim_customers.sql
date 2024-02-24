{{ config(materialized='table') }}

with
    stg_customers as (
        select 
            customerid
            , personid
            , storeid
            , territoryid
        from {{ ref('stg_customers') }}
    )
    , stg_person as (
        select
            businessentityid
            , persontype
            , title
            , case
                when middlename is null then (firstname || " " || lastname)
                else (firstname || " " || middlename || " " || lastname)
            end as name
            , emailpromotion
        from {{ ref('stg_person') }}
    )
    , stg_store as (
        select 
        businessentityid
        , name
        from {{ ref('stg_store') }}
    )
    , transformed_all_stg as (
        select
            {{ dbt_utils.generate_surrogate_key(['customerid', 'personid', 'storeid']) }} as customer_sk
            , stg_customers.customerid
            , stg_customers.personid
            , stg_customers.storeid
            , case
                when stg_customers.personid is null then stg_store.name
                else stg_person.name
            end as name
            , stg_customers.territoryid
            , stg_person.emailpromotion
        from stg_customers
        left join stg_person on stg_person.businessentityid = stg_customers.personid
        left join stg_store on stg_store.businessentityid = stg_customers.storeid
    )
select *
from transformed_all_stg