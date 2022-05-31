{{ config(materialized='table') }}

with renamed as (
    select
        countryregioncode
        , name
        , modifieddate
    from
        {{ source('adventure_works_etl', 'person_countryregion') }}
)

select *
from renamed

