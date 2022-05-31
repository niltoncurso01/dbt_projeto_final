{{ config(materialized='table') }}

with renamed as (
    select
        departmentid
        , name
        , groupname
        , modifieddate
    from
        {{ source('adventure_works_etl', 'humanresources_department') }}
)

select *
from renamed

