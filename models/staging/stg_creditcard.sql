{{ config(materialized='table') }}

with renamed as (
    select
        creditcardid
        , cardtype
        , cardnumber
        , expmonth
        , expyear
        , modifieddate
    from
        {{ source('adventure_works_etl', 'sales_creditcard') }}
)

select *
from renamed

