{{ config(materialized='table') }}

with renamed as (
    select
        productid
        , name
        , productnumber
        , makeflag
        , finishedgoodsflag
        , color
        , safetystocklevel
        , reorderpoint
        , standardcost
        , listprice
        , size
        , sizeunitmeasurecode
        , weightunitmeasurecode
        , weight
        , daystomanufacture
        , productline
        , class
        , style
        , productsubcategoryid
        , productmodelid
        , sellstartdate
        , sellenddate
        , discontinueddate
        , rowguid
        , modifieddate
    from
        {{ source('adventure_works_etl', 'production_product') }}
)

select *
from renamed

