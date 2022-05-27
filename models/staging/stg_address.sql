{{ config(materialized='table') }}

with renamed as (
    select
        addressid
        , addressline1
        , addressline2
        , city
        , stateprovinceid
        , postalcode
        , spatiallocation
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'person_address') }}
)

select *
from renamed

