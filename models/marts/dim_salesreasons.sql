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
            , string_agg(stg_salesreason.name, ", ") as name
        from stg_salesorderheadersalesreason
        left join stg_salesreason on stg_salesreason.salesreasonid = stg_salesorderheadersalesreason.salesreasonid
        group by salesreason_sk, stg_salesorderheadersalesreason.salesorderid
    )
select *
from transformed_all_stg
