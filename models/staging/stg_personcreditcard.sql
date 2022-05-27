{{ config(materialized='table') }}

with renamed as (
    select
        businessentityid
        , creditcardid
        , modifieddate  
    from
        {{ source('adventure_works_etl', 'sales_personcreditcard') }}
)

select *
from renamed

