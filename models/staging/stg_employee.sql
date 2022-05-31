{{ config(materialized='table') }}

with renamed as (
    select
        businessentityid
        , nationalidnumber
        , loginid
        , jobtitle
        , birthdate
        , maritalstatus
        , gender
        , hiredate
        , salariedflag
        , vacationhours
        , sickleavehours
        , currentflag
        , rowguid
        , modifieddate
        , organizationnode
    from
        {{ source('adventure_works_etl', 'humanresources_employee') }}
)

select *
from renamed

