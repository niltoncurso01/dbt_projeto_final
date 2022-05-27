{{ config(materialized='table') }}

with renamed as (
    select
        salesreasonid
        , name
        , reasontype
        , modifieddate
    from
        {{ source('adventure_works_etl', 'sales_salesreason') }}
)

select *
from renamed

