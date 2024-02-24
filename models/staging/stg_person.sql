with
    person as (
        select 
            cast(businessentityid as int) as businessentityid
            , persontype
            , title
            , firstname
            , middlename
            , lastname
            , emailpromotion
        from {{ source('adventure_works', 'person') }}
    )
select *
from person