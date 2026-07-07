{{ config(materialized='table') }}

select *
from MEDICARE_DB.DBT_LEARNING.MEDICARE_RAW
