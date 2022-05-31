{{ config(materialized='table') }}

with renamed as (
    select
        businessentityid
        , phonenumber
        , phonenumbertypeid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'person_personphone') }}
)

select *
from renamed

