{{ config(materialized='table') }}

with
    stg_salesreason as (
        select
            salesreasonid
            , name
            , reasontype
        from {{ ref('stg_salesreason') }}
    )
    , stg_salesorderheadersalesreason as (
        select
            salesorderid
            , salesreasonid
        from {{ ref('stg_salesorderheadersalesreason') }}
    )
    , stg_salesorderheader as (
        select salesorderid
        from {{ ref('stg_salesorderheader') }}
    )
    , transformed_all_stg as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_salesorderheader.salesorderid', 'stg_salesreason.name']) }} as salesreason_sk
            , stg_salesorderheader.salesorderid
            , case
                when stg_salesreason.name is null then "Not applied"
                else stg_salesreason.name
            end as reason_name
        from stg_salesorderheader
        left join stg_salesorderheadersalesreason on stg_salesorderheadersalesreason.salesorderid = stg_salesorderheader.salesorderid
        left join stg_salesreason on stg_salesreason.salesreasonid = stg_salesorderheadersalesreason.salesreasonid
    )
select *
from transformed_all_stg
