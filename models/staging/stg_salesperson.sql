{{ config(materialized='table') }}

with renamed as (
    select
        businessentityid
        , territoryid
        , salesquota
        , bonus
        , commissionpct
        , salesytd
        , saleslastyear
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'sales_salesperson') }}
)

select *
from renamed

