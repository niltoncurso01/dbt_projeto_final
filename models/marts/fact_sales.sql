{{ config(materialized='table') }}

with salesorderheader as (
    select
        salesorderid
        , revisionnumber
        , cast(orderdate as date) as orderdate
        , cast(duedate  as date) as duedate
        , cast(shipdate as date) as shipdate
        , status
        , onlineorderflag
        , purchaseordernumber
        , accountnumber
        , customerid
        , salespersonid
        , territoryid
        , billtoaddressid
        , shiptoaddressid
        , shipmethodid
        , creditcardid
        , creditcardapprovalcode
        , currencyrateid
        , subtotal
        , taxamt
        , freight
        , totaldue
        , comment
    from
        {{ ref('stg_salesorderheader') }}
)

, creditcard as (
    select
        creditcardid
        , cardtype
        , cardnumber
        , expmonth
        , expyear
    from
        {{ ref('stg_creditcard') }}
)

, personcreditcard as (
    select
        businessentityid
        , creditcardid 
    from
        {{ ref('stg_personcreditcard') }}
)

, joined_salesreason as (
	select 
        stg_salesorderheadersalesreason.salesorderid
        ,stg_salesorderheadersalesreason.salesreasonid
        , reasontype
	from
        {{ ref('stg_salesorderheadersalesreason') }}
	left join {{ ref('stg_salesreason') }}
	    on stg_salesorderheadersalesreason.salesreasonid = stg_salesreason.salesreasonid 
)

, final_salesreason as (
	select 
        salesorderid
        , reasontype
	from
        joined_salesreason
	group by
        salesorderid
        , reasontype
)

, salesorderdetail as (
    select
        salesorderid
        , salesorderdetailid
        , carriertrackingnumber
        , orderqty
        , productid
        , specialofferid
        , unitprice
        , unitpricediscount
    from
        {{ ref('stg_salesorderdetail')}}
)


, joined as (
    select
        salesorderheader.salesorderid
        , final_salesreason.reasontype
        , salesorderdetail.salesorderdetailid
        , salesorderdetail.carriertrackingnumber
        , salesorderdetail.orderqty
        , salesorderdetail.productid        
        , salesorderdetail.specialofferid
        , salesorderdetail.unitprice
        , salesorderdetail.unitpricediscount 
        , salesorderheader.revisionnumber
        , salesorderheader.orderdate
        , salesorderheader.duedate
        , salesorderheader.shipdate
        , salesorderheader.status
        , salesorderheader.onlineorderflag
        , salesorderheader.purchaseordernumber
        , salesorderheader.accountnumber
        , salesorderheader.customerid
        , salesorderheader.salespersonid
        , salesorderheader.territoryid
        , salesorderheader.billtoaddressid
        , salesorderheader.shiptoaddressid
        , salesorderheader.shipmethodid
        , salesorderheader.creditcardid
        , creditcard.cardtype
        , creditcard.cardnumber
        , creditcard.expmonth
        , creditcard.expyear
        , personcreditcard.businessentityid      
        , salesorderheader.creditcardapprovalcode
        , salesorderheader.currencyrateid
        , salesorderheader.subtotal
        , salesorderheader.taxamt
        , salesorderheader.freight
        , salesorderheader.totaldue
        , salesorderheader.comment
    from
        salesorderdetail
    left join salesorderheader
        on salesorderdetail.salesorderid = salesorderheader.salesorderid            
    left join final_salesreason
        on final_salesreason.salesorderid = salesorderdetail.salesorderid
    left join creditcard
        on salesorderheader.creditcardid = creditcard.creditcardid
    left join personcreditcard
        on personcreditcard.creditcardid = creditcard.creditcardid
)

select *
from joined

