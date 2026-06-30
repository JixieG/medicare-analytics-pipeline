{{ config(materialized='table') }}

select *
from read_csv_auto('C:/Users/jixie.george/my_first_project/data/Medicare_Physician_Other_Practitioners_by_Provider_and_Service_2024.csv')
limit 100000
