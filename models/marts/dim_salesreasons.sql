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
    , transformed_all_stg as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_salesorderheadersalesreason.salesorderid', 'stg_salesorderheadersalesreason.salesreasonid']) }} as salesreason_sk
            , stg_salesorderheadersalesreason.salesorderid
            , stg_salesorderheadersalesreason.salesreasonid
            , stg_salesreason.name
            , stg_salesreason.reasontype
        from stg_salesorderheadersalesreason
        left join stg_salesreason on stg_salesreason.salesreasonid = stg_salesorderheadersalesreason.salesreasonid
    )
select *
from transformed_all_stg