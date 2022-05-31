{{ config(materialized='table') }}

with departament as (
    select
        departmentid
        , name as departament_name
        , groupname
    from
        {{ ref('stg_departament') }}
)

, employee as (
    select
        businessentityid
        , nationalidnumber
        , loginid
        , jobtitle
        , birthdate
        , gender
        , hiredate
    from
        {{ ref('stg_employee') }}
)

, employeedepartmenthistory as (
    select
        businessentityid
        , departmentid
        , shiftid
        , startdate as startdate_department
    from
        {{ ref('stg_employeedepartmenthistory') }}
    where
        enddate is null
) 

, shift as (
    select
        shiftid
        , name as name_shift
        , starttime as starttime_shift
        , endtime as endtime_shift
    from
        {{ ref('stg_shift') }}
)

, person as (
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

, salesperson as (
    select
        businessentityid
        , territoryid
        , salesquota
        , bonus
        , commissionpct
        , salesytd
        , saleslastyear
    from
        {{ ref('stg_salesperson') }}
)

, joined as (
    select
        salesperson.businessentityid
        , salesperson.territoryid
        , salesperson.salesquota
        , salesperson.bonus
        , salesperson.commissionpct
        , salesperson.salesytd
        , salesperson.saleslastyear
        , employee.nationalidnumber
        , employee.loginid
        , employee.jobtitle
        , employee.birthdate
        , employee.gender
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
        , employee.hiredate
        , employeedepartmenthistory.departmentid
        , departament.departament_name
        , employeedepartmenthistory.shiftid
        , shift.name_shift
        , shift.starttime_shift
        , shift.endtime_shift
        , employeedepartmenthistory.startdate_department        
    from 
        salesperson
    left join employee
        on salesperson.businessentityid = employee.businessentityid
    left join employeedepartmenthistory
        on employee.businessentityid = employeedepartmenthistory.businessentityid
    left join departament
        on departament.departmentid = employeedepartmenthistory.departmentid
    left join shift
        on shift.shiftid = employeedepartmenthistory.shiftid
    left join person
        on employee.businessentityid = person.businessentityid
    left join phonenumber_final
        on person.businessentityid = phonenumber_final.businessentityid
    left join emailaddress
        on person.businessentityid = emailaddress.businessentityid
)

select *
from joined

