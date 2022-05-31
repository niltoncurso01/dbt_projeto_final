{{ config(materialized='table') }}

with product as (
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
    from
        {{ ref ('stg_product')}}
)

, productmodel as (
    select
        productmodelid
        , name
        , catalogdescription
        , instructions   
    from
        {{ ref('stg_productmodel') }}
)

, productmodelproductdescription as (
    select
        productmodelid
        , productdescriptionid
        , culture
    from
        {{ ref('stg_productmodelproductdescription') }}
    where
        culture like 'en%'
)

, productdescription as (
    select
        productdescriptionid
        , description
    from
        {{ ref('stg_productdescription') }}
)

, joined as (
    select
        product.productid
        , product.name
        , product.productnumber
        , product.makeflag
        , product.finishedgoodsflag
        , product.color
        , product.safetystocklevel
        , product.reorderpoint
        , product.standardcost
        , product.listprice
        , product.size
        , product.sizeunitmeasurecode
        , product.weightunitmeasurecode
        , product.weight
        , product.daystomanufacture
        , product.productline
        , product.class
        , product.style
        , product.productsubcategoryid
        , product.productmodelid
        , productmodel.name as modelname
        , productmodel.catalogdescription
        , productmodel.instructions
        , productdescription.productdescriptionid
        , productdescription.description
        , product.sellstartdate
        , product.sellenddate
        , product.discontinueddate
    from
        product
    left join productmodel
        on product.productmodelid = productmodel.productmodelid
    left join productmodelproductdescription
        on productmodel.productmodelid = productmodelproductdescription.productmodelid
    left join productdescription
        on productmodelproductdescription.productdescriptionid = productdescription.productdescriptionid
)

select *
from joined

