{{ config(materialized='table') }}

with renamed as (
    select
        shiftid
        , name
        , starttime
        , endtime
        , modifieddate
    from
        {{ source('adventure_works_etl', 'humanresources_shift') }}
)

select *
from renamed

