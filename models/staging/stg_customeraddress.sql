{{ config(materialized='table') }}

with renamed as (
    select
        customerid
        , addressid
        , addresstype
        , modifieddate
    from
        {{ source('adventure_works_etl', 'public_customeraddress') }}
)

select *
from renamed

