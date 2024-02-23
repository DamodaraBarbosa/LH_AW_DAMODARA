{{ config(materialized='table') }}

with 
    stg_creditcard as (
        select
            creditcardid
            , cardnumber
            , cardtype
        from {{ ref('stg_creditcard') }}
    )

    , transformed_stg_creditcards as (
        select
            {{ dbt_utils.generate_surrogate_key(['creditcardid', 'cardnumber']) }} as creditcard_sk
            , *
        from stg_creditcard
    )
    
select *
from transformed_stg_creditcards