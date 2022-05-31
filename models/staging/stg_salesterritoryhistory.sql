{{ config(materialized='table') }}

with renamed as (
    select
        businessentityid
        , territoryid
        , startdate
        , enddate
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'sales_salesterritoryhistory') }}
)

select *
from renamed

