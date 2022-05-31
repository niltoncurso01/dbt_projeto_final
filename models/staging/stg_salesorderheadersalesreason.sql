{{ config(materialized='table') }}

with renamed as (
    select
        salesorderid
        , salesreasonid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'sales_salesorderheadersalesreason') }}
)

select *
from renamed

