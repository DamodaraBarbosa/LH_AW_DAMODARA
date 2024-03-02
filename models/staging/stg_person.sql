with
    person as (
        select 
            cast(businessentityid as int) as businessentityid
            , cast(persontype as string) as persontype
            , cast(title as string) as title
            , cast(firstname as string) as firstname
            , cast(middlename as string) as middle
            , cast(lastname as string) as lastname
            , cast(emailpromotion as string) as emailpromotion
        from {{ source('adventure_works', 'person') }}
    )
select *
from person