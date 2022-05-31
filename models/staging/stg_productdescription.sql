{{ config(materialized='table') }}

with renamed as (
    select
        productdescriptionid
        , description
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'production_productdescription') }}
)

select *
from renamed

