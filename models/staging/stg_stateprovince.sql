{{ config(materialized='table') }}

with renamed as (
    select
        stateprovinceid
        , stateprovincecode
        , countryregioncode
        , isonlystateprovinceflag
        , name
        , territoryid
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'person_stateprovince') }}
)

select *
from renamed

