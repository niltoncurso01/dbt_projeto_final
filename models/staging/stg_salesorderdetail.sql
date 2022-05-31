{{ config(materialized='table') }}

with renamed as (
    select
        salesorderid
        , salesorderdetailid
        , carriertrackingnumber
        , orderqty
        , productid
        , specialofferid
        , unitprice
        , unitpricediscount
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'sales_salesorderdetail') }}
)

select *
from renamed

