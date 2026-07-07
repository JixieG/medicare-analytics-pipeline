{{ config(materialized='table') }}

with base as (
    select
        "Rndrng_Prvdr_State_Abrvtn"            as state,
        count(distinct "Rndrng_NPI")           as total_providers,
        sum(cast("Tot_Srvcs" as float))        as total_services,
        sum(cast("Tot_Benes" as float))        as total_beneficiaries,
        round(avg(cast("Avg_Mdcr_Pymt_Amt" as float)), 2) as avg_medicare_payment,
        round(sum(cast("Avg_Mdcr_Pymt_Amt" as float)), 2) as total_medicare_payment
    from MEDICARE_DB.DBT_LEARNING.MEDICARE_RAW
    group by "Rndrng_Prvdr_State_Abrvtn"
)

select *
from base
order by total_medicare_payment desc
