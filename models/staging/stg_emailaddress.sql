{{ config(materialized='table') }}

with renamed as (
    select
        businessentityid
        , emailaddressid
        , emailaddress
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'person_emailaddress') }}
)

select *
from renamed

