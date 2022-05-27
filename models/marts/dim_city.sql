{{ config(materialized='table') }}

with city as (
    select
        city
        , stateprovinceid
    from
        {{ ref('stg_address') }}
    group by
        city
        , stateprovinceid
)

, stateprovince as (
    select
        stateprovinceid
        , stateprovincecode
        , countryregioncode
        , name as provincename
        , territoryid
    from
        {{ ref('stg_stateprovince') }}
)

, countryregion as (
    select
        countryregioncode
        , name as countryname
    from
         {{ ref('stg_countryregion') }}
)


, joined as (
    select
        city.city
        , city.stateprovinceid
        , stateprovince.stateprovincecode
        , stateprovince.countryregioncode
        , countryregion.countryname
        , stateprovince.provincename
        , stateprovince.territoryid
    from
        city
    left join stateprovince
        on city.stateprovinceid = stateprovince.stateprovinceid
    left join countryregion
        on countryregion.countryregioncode = stateprovince.countryregioncode
)

select *
from joined

