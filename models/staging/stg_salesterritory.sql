{{ config(enabled = false) }}

{{ config(materialized='table') }}

with renamed as (
    select
        territoryid
        , name
        , countryregioncode
        , "group" as group_name
        , salesytd
        , saleslastyear
        , costytd
        , costlastyear
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'sales_salesterritory') }}
)

select *
from renamed

