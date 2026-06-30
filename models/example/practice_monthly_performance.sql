{{ config(materialized='table') }}

with base as (
    select
        practice_id,
        practice_name,
        region,
        month,
        collections_amount,
        ssu_rate,
        total_patients,
        phreesia_payments,
        round(phreesia_payments * 1.0 / nullif(collections_amount, 0) * 100, 2) as phreesia_payment_rate
    from {{ ref('practice_performance') }}
)

select *
from base
order by practice_id, month
