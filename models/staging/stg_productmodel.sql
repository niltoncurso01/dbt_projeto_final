{{ config(materialized='table') }}

with renamed as (
    select
        productmodelid
        , name
        , catalogdescription
        , instructions
        , rowguid
        , modifieddate    
    from
        {{ source('adventure_works_etl', 'production_productmodel') }}
)

select *
from renamed

