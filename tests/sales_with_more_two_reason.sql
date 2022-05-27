{{ config(severity = 'warn') }}

with more_than_two_reason as (
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
        more_than_two_reason
	group by
        salesorderid
        , reasontype
)

, count_reason as (
    select 
        salesorderid
        , count(*) as count_
    from
        final_salesreason
    group by 
        salesorderid
)

select *
from count_reason
where count_ > 3