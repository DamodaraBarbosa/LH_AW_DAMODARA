{{ config(materialized='table') }}

with
    stg_countryregion as (
        select
            countryregioncode
            , name
        from {{ ref('stg_countryregion') }}
    )
    , stg_stateprovince as (
        select
            stateprovinceid
            , stateprovincecode
            , countryregioncode
            , name
            , territoryid
        from {{ ref('stg_stateprovince') }}
    )
    , stg_address as (
        select
            addressid
            , addressline1
            , city
            , stateprovinceid
        from {{ ref('stg_address') }}
    )
    , stg_businessentityaddress as (
        select
            businessentityid
            , addressid
            , addresstypeid
        from {{ ref('stg_businessentityaddress') }}
    )
    , transformed_all_stg as (
        select
            {{ dbt_utils.generate_surrogate_key(['stg_businessentityaddress.businessentityid', 'stg_address.addressid']) }} as sklocation
            , stg_businessentityaddress.businessentityid
            , stg_countryregion.name as country_name
            , stg_stateprovince.name as province_name
            , stg_address.city as city_name
            , stg_address.addressid
            , stg_address.addressline1 as address
        from stg_businessentityaddress
        left join stg_address on stg_address.addressid = stg_businessentityaddress.addressid
        left join stg_stateprovince on stg_stateprovince.stateprovinceid = stg_address.stateprovinceid
        left join stg_countryregion on stg_countryregion.countryregioncode = stg_stateprovince.countryregioncode
    )
select *
from transformed_all_stg