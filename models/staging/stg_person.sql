{{ config(materialized='table') }}

with renamed as (
    select
        businessentityid
        , persontype
        , namestyle
        , title
        , firstname
        , middlename
        , lastname
        , suffix
        , emailpromotion
        , additionalcontactinfo
        , demographics
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'person_person') }}
)

select *
from renamed

