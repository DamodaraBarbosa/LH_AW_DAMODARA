with
    product as (
        select 
            cast(productid as int) as productid
            , cast(name as string) as name_product
            , cast(color as string) as color
            , cast(listprice as decimal) as listprice
            , cast(sellstartdate as datetime) as sellstartdate 
            , cast(productsubcategoryid as int) as productsubcategoryid
        from {{ source('adventure_works', 'product') }}
    )
    , productcategory as (
        select
            productcategoryid
            , name
        from {{ source('adventure_works', 'productcategory') }}
    )
    , productsubcategory as (
        select
            productsubcategoryid
            , productcategoryid
            , name
        from {{ source('adventure_works', 'productsubcategory') }}
    )
    , products_to_staging as (
        select 
            product.*
            , coalesce(productcategory.name, "Other") as name_category
        from product
        left join productsubcategory on productsubcategory.productsubcategoryid = product.productsubcategoryid
        left join productcategory on productcategory.productcategoryid = productsubcategory.productcategoryid
    )
select *
from products_to_staging