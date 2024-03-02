{{ config(materialized="table") }}

with
    dim_territory as (
        select
            {{ dbt_utils.generate_surrogate_key(['territoryid', 'name']) }} as skterritory
            , *
        from {{ ref('stg_territory') }}
    )
select *
from dim_territory