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
    , transformed_reason as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_salesorderheader.salesorderid', 'stg_salesreason.name']) }} as reason_sk
            , stg_salesorderheader.salesorderid
            , string_agg(stg_salesreason.name, ", ") as reason_name
        from stg_salesorderheader
        left join stg_salesorderheadersalesreason on stg_salesorderheadersalesreason.salesorderid = stg_salesorderheader.salesorderid
        left join stg_salesreason on stg_salesreason.salesreasonid = stg_salesorderheadersalesreason.salesreasonid
        group by stg_salesorderheader.salesorderid, reason_sk
    )
select *
from transformed_reason
