with
    sales_validation as (
        select 
            sum(totaldue) as sumtotaldue
        from {{ ref('fact_sales') }}
    )
select *
from sales_validation
where sumtotaldue != 109846381.39982836