{{ config(materialized='table') }}

with renamed as (
    select
        customerid
        , personid
        , storeid
        , territoryid
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'sales_customer') }}
)

select *
from renamed

