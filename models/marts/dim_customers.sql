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
            , case
                when emailpromotion = 0 then "No promotional e-mail"
                when emailpromotion = 1 then "Promotinal e-mail from Adventure Works"
                when emailpromotion = 2 then "Promotinal e-mail from Adventure Works and partners"
                when emailpromotion is null then "Not applied"
            end as emailpromotion
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
            {{ dbt_utils.generate_surrogate_key(['customerid', 'personid', 'storeid']) }} as skcustomer
            , stg_customers.customerid
            , stg_customers.personid
            , stg_customers.storeid
            , stg_person.name as person_name
            , stg_store.name as store_name
            , stg_customers.territoryid
            , stg_person.emailpromotion
        from stg_customers
        left join stg_person on stg_person.businessentityid = stg_customers.personid
        left join stg_store on stg_store.businessentityid = stg_customers.storeid
    )
select *
from transformed_all_stg