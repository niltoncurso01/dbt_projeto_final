{{ config(enabled = false) }}

{{ config(materialized='table') }}

with renamed as (
    select
        businessentityid
        , name
        , salespersonid
        , demographics
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'sales_store') }}
)

select *
from renamed

