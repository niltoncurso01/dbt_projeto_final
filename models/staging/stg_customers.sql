{{ config(materialized='table') }}

with 
renamed as (
    select
        customerid
        , firstname
        , middlename
        , lastname
        , case
            when title = 'Mr.'
                then 'H'
            when title = 'Ms.'
                then 'M'
            else 'Fora do padrão'
        end persons_sex
        , suffix
        , companyname
        , salesperson
        , emailaddress
        , phone
    from {{ source('adventure_works_etl', 'public_customer') }}
)

select *
from renamed

