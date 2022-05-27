{{ config(materialized='table') }}

with person as (
    select
        businessentityid
        , persontype
        , title
        , firstname
        , middlename
        , lastname
    from
        {{ ref('stg_person') }}
)

, personphone as (
    select
        businessentityid
        , phonenumber
        , phonenumbertypeid
    from
        {{ ref('stg_personphone') }}
)

, phonenumbertype as (
    select
        phonenumbertypeid
        , name as phonenumbertype_name
    from
        {{ ref('stg_phonenumbertype') }}
)

, phonenumber_final as (
    select
        personphone.businessentityid
        , personphone.phonenumber
        , personphone.phonenumbertypeid
        , phonenumbertype.phonenumbertype_name
    from
        personphone
    left join phonenumbertype
        on personphone.phonenumbertypeid = phonenumbertype.phonenumbertypeid
)
, emailaddress as (
    select
        businessentityid
        , emailaddressid
        , emailaddress
    from
        {{ ref('stg_emailaddress') }}
)

, customer as (
    select
        customerid
        , personid
        , storeid
        , territoryid
    from
        {{ ref('stg_customer') }}
)


, joined as (
    select
        customer.customerid
        , customer.personid
        , person.persontype
        , person.title
        , person.firstname
        , person.middlename
        , person.lastname
        , phonenumber_final.phonenumber
        , phonenumber_final.phonenumbertypeid
        , phonenumber_final.phonenumbertype_name
        , emailaddress.emailaddressid
        , emailaddress.emailaddress
        , customer.storeid
        , customer.territoryid
    from 
        customer
    left join person
        on customer.personid = person.businessentityid
    left join phonenumber_final
        on person.businessentityid = phonenumber_final.businessentityid
    left join emailaddress
        on person.businessentityid = emailaddress.businessentityid
)

select *
from joined
