{{ config(materialized='table') }}

with renamed as (
    select
        businessentityid
        , departmentid
        , shiftid
        , startdate
        , enddate
        , modifieddate
    from
        {{ source('adventure_works_etl', 'humanresources_employeedepartmenthistory') }}
)

select *
from renamed

