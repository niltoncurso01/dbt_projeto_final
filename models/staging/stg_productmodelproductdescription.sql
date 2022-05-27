{{ config(materialized='table') }}

with renamed as (
    select
        productmodelid
        , productdescriptionid
        , culture
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'public_productmodelproductdescription') }}
)

select *
from renamed

