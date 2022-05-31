{{ config(materialized='table') }}

with renamed as (
    select
        phonenumbertypeid
        , name
        , modifieddate
    from
        {{ source('adventure_works_etl', 'person_phonenumbertype') }}
)

select *
from renamed

